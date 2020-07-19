<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Crypt;

use App\User;
use App\UserNotification;

class NotifikasiController extends Controller
{
    public function index()
    {   
        // MENGAMBIL NOTIFIKASI YANG BELUM DIBACA USER DAN NOMOR KAMAR
            $user = Auth::user();
            $notif_model = UserNotification::where('notifiable_id',$user->id)
            ->whereNull('read_at')
            ->orderBy('created_at','DESC')
            ->get();
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
        
        // DECODE SEMUA DATA NOTIFIKASI
            foreach ($notif_model as $index => $notif) {
                $notif_model[$index]->setFullDataAttribute($notif->data);
            }
        // AKHIR
        
        return view('user/notifikasi/notifikasi',compact('user','notif_model','kamar'));
    }

    public function markall($id)
    {   
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/notifikasi');
            }
        // AKHIR
        
        // MAIN LOGIC
            UserNotification::where('notifiable_id',$decrypted)->whereNull('read_at')->update(['read_at' => date('Y-m-d H:i:s')]);
        // AKHIR

        return redirect('/notifikasi')->with(['system' => 'success']);
    }

}
