<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Contracts\Encryption\DecryptException;
use App\Kamar;

class KamarController extends Controller
{
    public function index()
    {
        // MENAMPILKAN USER
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

        // AMBIL DATA KAMAR
            $kamar_all = Kamar::all();
        // AKHIR

        return view('user/kamar/kamar',compact('user','kamar','notification','kamar_all'));
    }

    public function gambar($id)
    {   
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect()->back();
            }
        // AKHIR

        // MENCARI KAMAR DENGAN ID YANG TELAH DI DECRYPT
            $kamar_single = Kamar::find($decrypted);
            $gambars = $kamar_single->gambar();
        // AKHIR

        // MENAMPILKAN USER
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

        return view('user/kamar/gambarkamar',compact('user','kamar','gambars','kamar_single','notification'));
    }
}
