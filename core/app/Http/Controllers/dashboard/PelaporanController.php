<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use App\Laporan;

class PelaporanController extends Controller
{
    public function index()
    {
        // MENCARI DATA LAPORAN USER SEBELUMNYA
            $user = Auth::user();

            $laporan = Laporan::where('user_id',$user->id)
            ->get();
        // AKHIr

        // MENCARI STATUS LAPORAN HARIAN
            /*USER HANYA BOLEH MELAKUKAN LAPORAN SEKALI SEHARI MENGHINDARI SPAM KEPADA ADMIN */
            $kuota_laporan = $user->pelaporan;
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

        return view('user/pelaporan/pelaporan',compact('user','notification','kamar','kuota_laporan'));

    }
}
