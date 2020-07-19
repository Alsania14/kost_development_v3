<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;

use App\UserNotification;

class AdminNotifikasiController extends Controller
{
    public function index()
    {
        // MENGAMBIL DATA ADMIN
            $admin = Auth::user();
        // AKHIR
        
        // MENGAMBIL SEMUA NOTIFIKASI YANG BELUM DIBACA
            $notifications = UserNotification::where('notifiable_id',$admin->id)
                                ->whereNull('read_at')
                                ->orderBy('created_at','DESC')
                                ->get();
        // AKHIR

        // DECODE SEMUA DATA NOTIFIKASI
            foreach ($notifications as $index => $notif) {
                $notifications[$index]->setFullDataAttribute($notif->data);
            }
        // AKHIR

        return view('admin/adminnotifikasi/adminnotifikasi',compact('notifications','admin'));
    }

    public function markall($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/adminnotifikasi');
            }
        // AKHIR

        // MAIN LOGIC
            UserNotification::where('notifiable_id',$decrypted)->whereNull('read_at')->update(['read_at' => date('Y-m-d H:i:s')]);
        // AKHIR

        return redirect('/adminnotifikasi')->with(['system' => 'success']);

    }
}
