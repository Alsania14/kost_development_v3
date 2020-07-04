<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use App\Feature;

class FeatureController extends Controller
{
    public function index()
    {
        // MAIN LOGIC MENGAMBIL DATA PASSWORD WIFI DAN NAMA WIFI
            $wifi = Feature::where('name','wifi_name')->first();
            $wifi = $wifi->value;

            $password = Feature::where('name','wifi_pass')->first();
            $password = $password->value;
        // AAKHIR

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

        return view('user/wifi/wifi',compact('user','kamar','notification','wifi','password'));
    }
}
