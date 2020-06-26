<?php

namespace App\Http\Controllers\dashboard\transaksi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Notifications\UserNotification;

use App\Transaksi;

class NotificationController extends Controller
{
    public function index(Request $request)
    {   
        // MEMASTIKAN MENGGUNAKAN ZONA WAKTU WITA
            date_default_timezone_set("Asia/Makassar");
        // AKHIR

        // SECURITY LAYER
            /* MENGAMBIL DATA YANG MEMILIKI TRANSACTION_ID VALID DARI MIDTRANS
            DAN ORDER ID YANG SAMA DENGAN YANG DIKELUARKAN SISTEM */
            $transaksi = Transaksi::where('order_id',$request->order_id)
            ->where('transaction_id',$request->transaction_id)
            ->first();
        // AKHIR

        // MENYIMPAN DATA NOTIFIKASI TERAKHIR UNTUK DEVELOPER
            $transaksi->developer_information_charge = json_encode($request->all());
        // AKHIR

        // MENCARI USER YANG MEMILIKI TRANSAKSI INI
            $user = $transaksi->tagihan()->first()->user();
        // AKHIR

        // MENYESUAIKAN FORMAT MIDTRANS DENGAN FORMAT STATUS SISTEM
            if($request->transaction_status == 'settlement')
            {
                $transaksi->status_pembayaran = 'approved';
                $tagihan = $transaksi->tagihan()->first();

                // MENGUPDATE TABLE TAGIHAN
                    $tagihan->status_tagihan = 'lunas';
                    $tagihan->tgl_pembayaran = date('Y-m-d');
                // AKHIR
                
                $transaksi->developer_information_finish = json_encode($request->all());
                $tagihan->save();

                // USER NOTIFICATION
                    $text = '{"title" : "PEMBAYARAN SUCCESS","text" : "Transaksi dengan Order ID '.$request->order_id.'  telah selesai , terimakasih banyak, have a good day","type" : "special"}';
                        
                    $user->notify(new UserNotification($text));
                // AKHIR

            }
            elseif($request->transaction_status == 'expire')
            {
                $transaksi->status_pembayaran = 'expired';

                // USER NOTIFICATION
                    $text = '{"title" : "PEMBAYARAN EXPIRED","text" : "Transaksi dengan Order ID '.$request->order_id.'  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali","type" : "common"}';
                            
                    $user->notify(new UserNotification($text));
                // AKHIR
            }
            elseif($request->transaction_status == 'pending')
            {
                $transaksi->status_pembayaran = 'pending';
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

            return \response('oke',200);
    }
}
