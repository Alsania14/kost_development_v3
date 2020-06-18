<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

use App\User;
use App\kamar;

class DashboardController extends Controller
{
    public function index()
    {   
        // CEK KAMAR
        $kamar = new \stdClass;
        $kamar->nomor = 'Belum Memiliki kamar';
        $kamar->tgl_bayar_selanjutnya = null;
        $user = Auth::user();
        $test_kamar = $user->kamar()->first();
        
        // JIKA ADA MAKA V KAMAR DIGANTI TEST KAMAR
        if(!is_null($test_kamar))
        {
            $kamar = $test_kamar;
        }
        
        return view('user/dashboard/dashboard',compact('user','kamar'));
    }
}
