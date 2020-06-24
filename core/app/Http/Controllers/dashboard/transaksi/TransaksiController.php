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
            WHERE users.id = ? GROUP BY transaksis.`id`",array($user->id));
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
            $transaksi = Transaksi::find($decrypted);
            
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
}
