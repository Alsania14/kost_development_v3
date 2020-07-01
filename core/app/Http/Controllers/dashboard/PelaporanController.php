<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

use App\Laporan;
use App\User;
use App\Mail\LaporanAdmin;

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

        // MENGAMBIL DATA LAPORAN USER
            $laporans = $user->pelaporan()->get();
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

        return view('user/pelaporan/pelaporan',compact('user','notification','kamar','kuota_laporan','laporans'));

    }

    public function create(Request $request)
    {   
        // SECURITY LAYER
            $validator = Validator::make($request->all(),[
                'keluhan' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'min:4',
                    'max:200',
                ),
                'laporan' => 'nullable|mimes:jpeg,bmp,jpg,png|max:2000',
            ],[
                'keluhan.not_regex' => 'Tidak diperbolehkan menggunakan simbol',
            ]);
        // AKHIR

        if($validator->fails())
        {
            return redirect()->back()->withErrors($validator->errors());
        }

        // MENDAPATKAN DATA USER
            $user = Auth::user();
            $kamar = $user->kamar();
        // AKHIR

        // MAIN LOGIC MENYIMPAN DATA LAPORAN KE TABLE LAPORANS
            $laporan = new Laporan;
            $laporan->kamar_id = $kamar->id;
            $laporan->user_id = $user->id;
            $laporan->keluhan = $request->keluhan;
            $laporan->status_keluhan = 'terkirim';
            // SIMPAN GAMBAR KELUHAN BILA ADA
                if($request->file('laporan') != null)
                {
                    $simpan = Storage::putFile('public_html/image_pelaporan',$request->file('laporan'));
                    $simpan = basename($simpan);
                    $laporan->image_keluhan = $simpan;
                }
            // AKHIR

            $laporan->save();
        // AKHIR

        // UPDATE TABLE USER SET KUOTA LAPORAN MENJADI 1
            $user->pelaporan = 1;
            $user->save();
        // AKHIR
        
        // MENYIAPKAN DATA YANG AKAN DIKIRIM KE ADMIN
            $data = [
                'name' => $user->name,
                'kamar' => $kamar->nomor,
                'keluhan' => $request->keluhan,
            ];
            if(isset($simpan)){
                $data['image'] = $simpan;
            }
            else
            {
                $data['image'] = null;
            }

        // KIRIM KE EMAIL ADMIN SEBAGAI NOTIFIKASI
            $admin = User::where('role','admin')->first();

            \Mail::to($admin->email)->send(new LaporanAdmin($data));
        // AKHIR

        return redirect()->back()->with(['system' => 'success']);

    }
}
