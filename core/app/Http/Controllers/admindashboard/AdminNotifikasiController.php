<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

use App\UserNotification;
use App\User;

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

    public function arsipnotifikasi(Request $request)
    {
        // SECURITY LAYER
            $validator = Validator::make($request->all(),[
                'type' => array(
                    'nullable',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    Rule::in(['special', 'common']),
                ),

                'tgl_awal' => array(
                    'nullable',
                    'date',
                ),

                'tgl_akhir' => array(
                    'nullable',
                    'date',
                )
            ]);

            if($validator->fails())
            {
                return redirect()->back()->with(['system' => 'denied']);
            }
        // AKHIR

        // MAIN LOGIC
            // MENGAMBIL DATA ADMIN
                $admin = User::where('role','admin')->first();
            // AKHIR
            
            // MENGGUNAKAN PARAMETER UNTUK MENYARING DATA
                $notifications = DB::table('user_notifications')->where('notifiable_id',$admin->id);
                
                if(isset($request->type))
                {                    
                    $notifications = $notifications->where('data','LIKE','%'.$request->type.'%');
                }

                if(isset($request->tgl_awal))
                {
                    $notifications = $notifications->where('created_at','>',$request->tgl_awal);
                }

                if(isset($request->tgl_akhir))
                {
                    $notifications = $notifications->where('created_at','<',$request->tgl_akhir);
                }
                
                $notifications = $notifications->orderBy('created_at','DESC')->paginate(20);
            // AKHIR

            // MENYIMPAN INPUT PARAMETER
                $input = $request->all();
            // AKHIR

            // MENGUBAH BENTUK NOTIFIKASI KE BENTUK OBJECT PHP
                foreach ($notifications as $index => $notif)
                {
                    $notifications[$index]->full_data = json_decode($notif->data);
                }
            // AKHIR
            
        // AKHIR

                                
        return view('admin/adminnotifikasi/adminarsipnotifikasi',compact('notifications','input'));
    }
}
