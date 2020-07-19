<?php

namespace App\Http\Controllers\dashboard\transaksi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Notifications\UserNotification;

use App\Transaksi;
use App\User;

class NotificationController extends Controller
{
    public function index(Request $request)
    {   
        // SECURITY LAYER
            /* MENGAMBIL DATA YANG MEMILIKI TRANSACTION_ID VALID DARI MIDTRANS
            DAN ORDER ID YANG SAMA DENGAN YANG DIKELUARKAN SISTEM MEMBUAT SIGNATURE KEY
            DAN MENGGUNAKAN SIGNATURE KEY MIDTRANS UNTUK KEAMANAN BERLAPIS*/

            $security_order_id = $request->order_id;
            $security_status_code = $request->status_code;
            $security_gross_amount = $request->gross_amount;
            $security_server_key = config('global.security_key_midtrans');
            $security_input = $security_order_id.$security_status_code.$security_gross_amount.$security_server_key;
            $signature_key = \openssl_digest($security_input, 'sha512');

            if($signature_key != $request->signature_key)
            {
                return response()->json(['status_code' => 500],500);
            }

            $transaksi = Transaksi::where('order_id',$request->order_id)
            ->where('transaction_id',$request->transaction_id)
            ->first();
        // AKHIR

        // MENYIMPAN DATA NOTIFIKASI TERAKHIR UNTUK DEVELOPER
            $transaksi->developer_information_last_notification = json_encode($request->all());
        // AKHIR

        // MENCARI USER YANG MEMILIKI TRANSAKSI INI DAN JUGA ADMIN APLIKASI DAN TAGIHAN DARI TRANSAKSI
            $user = $transaksi->tagihan()->first()->user();
            $admin = User::where('role','admin')->first();
            $tagihan = $transaksi->tagihan()->first();
        // AKHIR

        // MENYESUAIKAN FORMAT MIDTRANS DENGAN FORMAT STATUS SISTEM
            if($request->transaction_status == 'settlement')
            {
                $transaksi->status_pembayaran = 'approved';

                // MENGUPDATE TABLE TAGIHAN
                    $tagihan->status_tagihan = 'lunas';
                    $tagihan->tgl_pembayaran = date('Y-m-d');
                // AKHIR
                
                $transaksi->developer_information_finish = json_encode($request->all());
                $tagihan->save();

                // USER NOTIFICATION DAN ADMIN
                    $text = '{"title" : "PEMBAYARAN SUCCESS","text" : "Transaksi dengan Order ID '.$request->order_id.'  telah selesai , terimakasih banyak, have a good day","type" : "special"}';
                        
                    $user->notify(new UserNotification($text));

                    $text = '{"title" : "PEMBAYARAN SUCCESS","text" : "User '.$user->username.' telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID '.$tagihan->id.'. Transaksi dilakukan dengan order_id '.$request->order_id.' ","type" : "special"}';

                    $admin->notify(new UserNotification($text));
                    
                // AKHIR

            }
            elseif($request->transaction_status == 'expire')
            {
                $transaksi->status_pembayaran = 'expired';

                // USER NOTIFICATION
                    $text = '{"title" : "PEMBAYARAN EXPIRED","text" : "Transaksi dengan Order ID '.$request->order_id.'  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali","type" : "common"}';
                            
                    $user->notify(new UserNotification($text));

                    $text = '{"title" : "PEMBAYARAN EXPIRED","text" : "User '.$user->username.' Belum melakukan pembayaran hingga charge yang dibuatnya expired, tolong admin memberikan peringatan, charge yang expired dengan nomor order_id '.$request->order_id.' ","type" : "common"}';

                    $admin->notify(new UserNotification($text));
                // AKHIR
            }
            elseif($request->transaction_status == 'pending')
            {
                $transaksi->status_pembayaran = 'pending';

                $text = '{"title" : "CHARGE USER","text" : "User '.$user->username.' telah melakukan charge terhadap tagihan dengan ID '.$tagihan->id.' Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id '.$request->order_id.', dimohon untuk admin mengawasi aktifitas transaksi dengan baik ","type" : "common"}';

                $admin->notify(new UserNotification($text));
            }
            else
            {
                $transaksi->status_pembayaran = 'rejected';

                // USER NOTIFICATION
                    $text = '{"title" : "PEMBAYARAN REJECTED","text" : "Transaksi dengan Order ID '.$request->order_id.'  Telah gagal, dimohon untuk melakukan pembayaran dengan benar","type" : "common"}';
                                
                    $user->notify(new UserNotification($text));
                // AKHIR
            }

            $transaksi->save();
        // AKHIR

            return response()->json(['status_code' => 200],200);
    }
}
