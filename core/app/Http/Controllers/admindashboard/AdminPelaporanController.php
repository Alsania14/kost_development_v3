<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Contracts\Encryption\DecryptException;

use App\Laporan;
use App\Notifications\UserNotification;

class AdminPelaporanController extends Controller
{
    public function index()
    {
        // MENGAMBIL DATA ADMIN
            $admin = Auth::user();
        // AKHIR

        // MNEGMABIL SEMUA LAPORAN
            $laporans = Laporan::where('deleted_by_admin',0)
                                ->orderBy('created_at','ASC')
                                ->get();
            
        // AKHIR

        // CEK NOTIFIKASI ADMIN
            $notification = $admin->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR
            
        return view('admin/adminpelaporan/adminpelaporan',compact('notification','laporans'));
    }

    public function tanggapan(Request $request,$id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect()->back()->with(['system' => 'denied']);
            }

            // MENGAMBIL DATA ADMIN DAN MENGECEK PASSWORD
                $admin = Auth::user();

                if(!Hash::check($request->password, $admin->password))
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }
            // AKHIR

            $validator = Validator::make($request->all(),[
                'respon' => 'required|min:4|max:200',
            ]);

            if($validator->fails())
            {
                return redirect()->back()->with(['system' => 'denied']);
            }

        // AKHIR
        
        // MAIN LOGIC
            // MENGAMBIL LAPORAN
                $laporan = Laporan::find($decrypted);

                if($laporan == null)
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }
                
                $laporan->respon = $request->respon;
                $laporan->status_keluhan = 'proses';
                $laporan->save();

            // NOTIFIKASI USER
                $user = $laporan->user()->first();

                $text = '{"title" : "LAPORAN DITANGANI","text" : "Laporan yang anda buat sedang diproses oleh admin, jadi mohon tunggu kabar dari admin. Anda dapat melihat respon admin melalui halaman pelaporan", "type" : "common"}';
            
                $user->notify(new UserNotification($text));
            // AKHIR

                return redirect()->back()->with(['system' => 'success2']);
    }

    public function hapuslaporan(Request $request,$id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect()->back()->with(['system' => 'denied']);
            }

            // MENGAMBIL DATA ADMIN DAN MENGECEK PASSWORD
                $admin = Auth::user();

                if(!Hash::check($request->password, $admin->password))
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }
            // AKHIR
        // AKHIR
        
        // MAIN LOGIC
            // MENCARI LAPORAN DENGAN ID DECRYPT
                $laporan = Laporan::find($decrypted);

                if($laporan == null)
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }

                $laporan->deleted_by_admin = 1 ;
                $laporan->save();
            // AKHIR

            // NOTIFIKASI USER
                $user = $laporan->user()->first();

                $text = '{"title" : "LAPORAN DIHAPUS","text" : "Sebuah laporan yang anda ajukan dihapus oleh admin. pastikan anda mengajukan laporan yang memang merupakan tanggung jawab dari pemilik kost melalui sistem ini", "type" : "common"}';
            
                $user->notify(new UserNotification($text));
            // AKHIR
        // AKHIR

            return redirect()->back()->with(['system' => 'success2']);
        
    }
}
