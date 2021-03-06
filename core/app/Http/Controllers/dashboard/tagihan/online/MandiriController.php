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

class MandiriController extends Controller
{
    public function charge(Request $request)
    {   
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


        // MEMBUAT OBJECT UNTUK JSON API KE MIDTRANS BANK MANDIRI
            $payload = new class{};
            $payload->payment_type = 'echannel';
            $payload->transaction_details = (object) array(
                'gross_amount' => $tagihan->nominal_pembayaran,
                'order_id' => $nota,
            );
            $payload->item_details[] = (object) array(
                'id' => $kamar->id,
                'price' => $tagihan->nominal_pembayaran,
                'quantity' => 1,
                'name' => 'Tirta Aruna Cottage = Kamar '.$kamar->nomor,
            );
            $payload->echannel = (object) array(
                'bill_info1' => 'Tirta Aruna Cottage Online Payment',
                'bill_info2' => 'Tirta Aruna Cottage Online Payment',
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
            $transaksi_new->nominal = $tagihan->nominal_pembayaran;
            $transaksi_new->via = 'bank_transfer';
            $transaksi_new->integration_name = 'mandiri';
            $transaksi_new->status_pembayaran = 'proses';
            $transaksi_new->field_1 = $response_php->bill_key;
            $transaksi_new->field_2 = $response_php->biller_code;
            $transaksi_new->developer_information_charge = $response;
            $transaksi_new->save();
        // AKHIR
        
        // USER NOTIFICATION
            $text = '{"title" : "CHARGE BERHASIL !","text" : "Tagihan dengan Order ID '.$nota.'  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan","type" : "common"}';
                
            $user->notify(new UserNotification($text));
        // AKHIR

        return redirect('/bank_transfer'.'/'.Crypt::encryptString($transaksi_new->id))->with(['system' => 'success']);
    }
}
