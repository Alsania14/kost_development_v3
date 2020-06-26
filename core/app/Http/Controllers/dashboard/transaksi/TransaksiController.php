<?php

namespace App\Http\Controllers\dashboard\transaksi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Contracts\Encryption\DecryptException;
use App\Notifications\UserNotification;

use App\Transaksi;
use App\Tagihan;

class TransaksiController extends Controller
{
    public function index()
    {   
        // MENGAMBIL DATA TRANSAKSI USER
            $user = Auth::user();
            $kamar = $user->kamar();
        // AKHIIR

        // MENGAMBIL DATA TRANSAKSI (HARD SEKALI MENGGUNAKAN ELOQUENT MAKANYA PAKEK RAW)
            $transaksis = DB::select("SELECT tagihans.`user_id` AS USER,tagihans.`id` AS tagihan,transaksis.* FROM tagihans
                                        INNER JOIN users ON users.id = tagihans.`user_id`
                                        INNER JOIN transaksis ON transaksis.`tagihan_id` = tagihans.`id`
                                        WHERE users.id = ? AND transaksis.deleted_by_user = 0 
                                        GROUP BY transaksis.`id`",array($user->id));
        // AKHIR

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $test_kamar = $user->kamar();
            
            if(!is_null($test_kamar))
            {
                $kamar = $test_kamar;
            }
        // AKHIR

         // CEK NOTIFIKASI USER
            $notification = $user->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        return view('/user/pembayaran/transaksi/transaksi',compact('user','kamar','transaksis','notification'));
    }

    public function detailtransaksionline($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/transaksi');
            }
        // AKHIR
        
         // MENGAMBIL DATA TRANSAKSI 
            $transaksi = Transaksi::withTrashed()->find($decrypted);
            
         // AKHIR
 
         // MENGAMBIL TAGIHAN TRANSAKSI UNTUK MENDAPATKAN KAMAR YANG DIBAYARKAN
             $tagihan = $transaksi->tagihan()->first();
             $nomor = $tagihan->kamar()->nomor;
         // AKHIR
         
         // MENGAMBIL DATA USER
             $user = Auth::user();
             $kamar = $user->kamar();
         // AKHIR
 
         // CEK NOTIFIKASI USER
             $notification = $user->unreadNotifications->count();
             if($notification == 0)
             {
                 $notification = null;
             }
         // AKHIR
         
        return view('/user/pembayaran/transaksi/detailonline',compact('user','kamar','notification','transaksi','tagihan','nomor'));
    }

    public function refreshtransaksi($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // MENGAMBIL ORDER_ID TRANSAKSI YANG DIMAKSUD
            $transaksi = Transaksi::find($decrypted);
        // AKHIR

        // MAIN LOGIC MENGAMBIL DATA TERBARU DARI SERVER MIDTRANS
            // CURL EXECUTOR
            $curl = curl_init();
            
            curl_setopt_array($curl, array(
                CURLOPT_URL => config('global.url_midtrans_base').'/'.$transaksi->order_id.'/status',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "GET",
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
                
                if($err != "")
                {
                    return redirect('/transaksi')->with(['system' => 'denied']);
                }
                
            // AKHIR

            // MENYESUAIKAN FORMAT MIDTRANS DENGAN FORMAT STATUS SISTEM
                if($response_php->transaction_status == 'settlement')
                {
                    $transaksi->status_pembayaran = 'approved';
                    $tagihan = $transaksi->tagihan()->first();

                    // MENGUPDATE TABLE TAGIHAN
                        $tagihan->status_tagihan = 'lunas';
                        $tagihan->tgl_pembayaran = date('Y-m-d');
                    // AKHIR
                    
                    $transaksi->developer_information_finish = json_encode($response_php);
                    $tagihan->save();

                }
                elseif($response_php->transaction_status == 'expire')
                {
                    $transaksi->status_pembayaran = 'expired';
                }
                elseif($response_php->transaction_status == 'pending')
                {
                    $transaksi->status_pembayaran = 'pending';
                }
                else
                {
                    $transaksi->status_pembayaran = 'rejected';
                }

            // AKHIR

            // MENYIMPAN CATATAN DEVELOPER UNTUK LAST NOTIFICATION
                $transaksi->developer_information_last_notification = $response;
                $transaksi->save();
            // AKHIR

        // AKHIR

        return redirect('/transaksi')->with(['system' => 'success']);
    }

    public function indexarsip()
    {
        // MENGAMBIL DATA TRANSAKSI USER
            $user = Auth::user();
            $kamar = $user->kamar();
        // AKHIIR

        // MENGAMBIL DATA TRANSAKSI (HARD SEKALI MENGGUNAKAN ELOQUENT MAKANYA PAKEK RAW)
            $transaksis = DB::select("SELECT tagihans.`user_id` AS USER,tagihans.`id` AS tagihan,transaksis.* FROM tagihans
                                        INNER JOIN users ON users.id = tagihans.`user_id`
                                        INNER JOIN transaksis ON transaksis.`tagihan_id` = tagihans.`id`
                                        WHERE users.id = ? AND transaksis.deleted_by_user = 1 
                                        GROUP BY transaksis.`id`",array($user->id));
        // AKHIR

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $test_kamar = $user->kamar();
            
            if(!is_null($test_kamar))
            {
                $kamar = $test_kamar;
            }
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $user->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        return view('/user/pembayaran/transaksi/arsiptransaksi',compact('user','kamar','transaksis','notification'));
    }

    public function arsiptransaksi($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/transaksi');
            }
        // AKHIR
            
        // MAIN LOGIC UBAH DELETED BY USER MENJADI 1 ATAU TRUE
            $transaksi = Transaksi::withTrashed()->find($decrypted);
            $transaksi->deleted_by_user = 1;
            $transaksi->save();
        // AKHIR


        return redirect('/transaksi');
    }

    public function keluarkanarsip($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/transaksi');
            }
        // AKHIR
            
        // MAIN LOGIC UBAH DELETED BY USER MENJADI 1 ATAU TRUE
            $transaksi = Transaksi::withTrashed()->find($decrypted);
            $transaksi->deleted_by_user = 0;
            $transaksi->save();
        // AKHIR


        return redirect('/arsiptransaksi');
    }
}
