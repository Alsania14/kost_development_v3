<?php

namespace App\Http\Controllers\dashboard\tagihan\online;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Notifications\UserNotification;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Contracts\Encryption\DecryptException;

use App\Tagihan;
use App\Transaksi;

class PermataController extends Controller
{
    public function charge(Request $request)
    {   
        // MEMASTIKAN MENGGUNAKAN WAKTU WITA
            date_default_timezone_set (config('global.timezone'));
        // AKHIR

        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($request->tagihan);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // MENDAPATKAN DATA USER DAN TAGIHAN
            $user = Auth::user();
            $tagihan = Tagihan::find($decrypted);
            $kamar = $user->kamar();

            
        // AKHIR

        // MEMBUAT NOMOR ID DAN NOTA
            $statement = DB::select("SHOW TABLE STATUS LIKE 'transaksis'");
            $nextId = $statement[0]->Auto_increment;

            $filled_int = sprintf("%05d", $nextId);
            $nota = config('global.nota').$filled_int;
        // AKHIR


        // MEMBUAT OBJECT UNTUK JSON API KE MIDTRANS BANK BNI
            $payload = new class{};
            $payload->payment_type = 'bank_transfer';
            $payload->transaction_details = (object) array(
                'gross_amount' => $kamar->harga,
                'order_id' => $nota,
            );
            $payload->customer_details = (object) array(
                'email' => $user->email,
                'first_name' => $user->name,
                'phone' => $user->nomor_hp,
            );
            $payload->item_details[] = (object) array(
                'id' => $kamar->id,
                'price' => $kamar->harga,
                'quantity' => 1,
                'name' => 'Tirta Aruna Cottage = Kamar '.$kamar->nomor,
            );
            $payload->custom_expiry = (object) array(
                'expiry_duration' => 1,
                'unit' => 'minute',
            );
            $permata = new class{};
            $permata = (object) array(
                'recipient_name' => $user->name,
            );
            $payload->bank_transfer = (object) array(
                'bank' => 'permata',
                'permata' => $permata,
            );

            $payload = \json_encode($payload);
        // AKHIR

        // CURL EXECUTOR
            $curl = curl_init();
            
            curl_setopt_array($curl, array(
                CURLOPT_URL => config('global.url_midtrans'),
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $payload,
                CURLOPT_HTTPHEADER => array(
                "Accept: application/json",
                "Authorization: ".config('global.key_midtrans'),
                "Content-Type: application/json"
                ),
            ));
            $response = curl_exec($curl);
            $err = curl_error($curl);
            curl_close($curl);
        // AKHIR
        
        // JIKA TERJADI ERROR MAKA REDIRECT BACK DENGAN INFORMASI
            $response_php = json_decode($response);
            if($err != "" || $response_php->status_code != 201 )
            {
                return redirect('/tagihan')->with(['system' => 'denied']);
            }
        // AKHIR
        
        // PENYIMPANAN DATA TRANSAKSI DENGAN STATUS DARI RESPONSE API
            $transaksi_new = new Transaksi;
            $transaksi_new->order_id = $nota;
            $transaksi_new->transaction_id = $response_php->transaction_id;
            $transaksi_new->tagihan_id = $decrypted;
            $transaksi_new->tgl_awal = $tagihan->tgl_awal_sewa;
            $transaksi_new->tgl_akir = $tagihan->tgl_akhir_sewa;
            $transaksi_new->nominal = $kamar->harga;
            $transaksi_new->via = 'bank_transfer';
            $transaksi_new->integration_name = 'permata';
            $transaksi_new->status_pembayaran = 'proses';
            $transaksi_new->field_1 = $response_php->permata_va_number;
            $transaksi_new->developer_information_charge = $response;
            $transaksi_new->save();
        // AKHIR

        // USER NOTIFICATION
            $text = '{"title" : "CHARGE BERHASIL !","text" : "Tagihan dengan Order ID '.$nota.'  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan","type" : "common"}';
                
            $user->notify(new UserNotification($text));
        // AKHIR

        return redirect('/bank_transfer'.'/'.Crypt::encryptString($transaksi_new->id))->with(['system' => 'success']);
    }
}