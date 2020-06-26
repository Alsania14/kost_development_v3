<?php

namespace App\Http\Controllers\dashboard\tagihan;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Contracts\Encryption\DecryptException;
use App\Notifications\UserNotification;

use App\User;
use App\Tagihan;

class TagihanController extends Controller
{
    public function index()
    {
        // AMBIL SEMUA DATA TAGIHAN USERS
            $user = Auth::user();
            $tagihans = $user->tagihan();
        // AKHIR

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $kamar->tgl_bayar_selanjutnya = null;
            $test_kamar = $user->kamar();
        // AKHIR

        // CEK NOTIFIKASI USER
              $notification = $user->unreadNotifications->count();
              if($notification == 0)
              {
                  $notification = null;
              }
        // AKHIR

        // JIKA ADA MAKA V KAMAR DITIMPA TEST KAMAR, JIKA TIDAK USER DIBERIKAN VIEW DENIED HALAMAN TAGIHAN
            if(!is_null($test_kamar))
            {
                $kamar = $test_kamar;
            }
            else
            {
                return view('user/denied',compact('user','kamar','notification'));
            }
        // AKHIR

        return view('user/pembayaran/tagihan/tagihan',compact('user','kamar','notification','tagihans'));
        
    }

    public function pilihpembayaran($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // AMBIL DATA USER
            $user = Auth::user();
        // AKHIR

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $kamar->tgl_bayar_selanjutnya = null;
            $test_kamar = $user->kamar();
        // AKHIR

         // JIKA ADA MAKA V KAMAR DITIMPA TEST KAMAR
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

        return view('user/pembayaran/tagihan/pilih_pembayaran',compact('user','kamar','notification','id'));
    }

    public function indexarsip()
    {
        // AMBIL SEMUA DATA TAGIHAN USERS
            $user = Auth::user();
            $tagihans = $user->tagihanarsip();
        // AKHIR

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $kamar->tgl_bayar_selanjutnya = null;
            $test_kamar = $user->kamar();
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $user->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        // JIKA ADA MAKA V KAMAR DITIMPA TEST KAMAR, JIKA TIDAK USER DIBERIKAN VIEW DENIED HALAMAN TAGIHAN
            if(!is_null($test_kamar))
            {
                $kamar = $test_kamar;
            }
            else
            {
                return view('user/denied',compact('user','kamar','notification'));
            }
        // AKHIR

        return view('/user/pembayaran/transaksi/arsiptagihan',compact('user','kamar','notification','tagihans'));

    }

    public function arsiptagihan($id)
    {
        // SCEURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // MENGUBAH TAGIHAN MENJADI ARSIP
            $tagihan = Tagihan::find($decrypted);
            $tagihan->deleted_by_user = 1;
            $tagihan->save();
        // AKHIR

        return redirect('/tagihan');
    }

    public function keluarkanarsip($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR
            
        // MAIN LOGIC KELUARKAN ARSIP
            $tagihan = Tagihan::find($decrypted);
            $tagihan->deleted_by_user = 0;
            $tagihan->save();
        // AKHIR

        return redirect('/arsiptagihan');
    }
}
