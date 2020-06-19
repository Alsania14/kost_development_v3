<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Contracts\Encryption\DecryptException;

use App\User;
use App\Kamar;

class ProfileController extends Controller
{
    public function index()
    {   
        // MENAMPILKAN USER
            $user = Auth::user();

        // CEK KAMAR
            $kamar = new \stdClass;
            $kamar->nomor = 'Belum Memiliki kamar';
            $kamar->tgl_bayar_selanjutnya = null;
            $test_kamar = $user->kamar()->first();
        // AKHIR

        // JIKA ADA MAKA V KAMAR DITIMPA TEST KAMAR
            if(!is_null($test_kamar))
            {
                $kamar = $test_kamar;
            }
        // AKHIR
    
            return view('/user/profile/profile',compact('user','kamar'));
    }

    public function edit($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/profile');
            }
        // AKHIR

        // MAIN LOGIC
            $user = User::find($decrypted);
            $kamar = $user->kamar()->first();
        
            return view('/user/profile/edit',compact('user','kamar'));
        // AKHIR
    }

    public function update($id)
    {
        
    }
}
