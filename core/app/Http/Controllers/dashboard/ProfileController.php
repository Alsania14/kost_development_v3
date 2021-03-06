<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use ImageOptimizer;

use App\Notifications\UserNotification;
use App\User;
use App\Kamar;
use App\Mail\VerifikasiUser;

class ProfileController extends Controller
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
    
        return view('/user/profile/profile',compact('user','kamar','notification'));
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
            $kamar = $user->kamar();
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $user->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        return view('/user/profile/edit',compact('user','kamar','notification'));
    }

    public function update(Request $request,$id)
    {   
        // DECRYPT ID USER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/profile');
            }
        
        // AKHIR

        // SECURITY LAYER
            // LARAVEL VALIDATION ANTI XSS
            $validator = Validator::make($request->all(),[
                'image_profile' => 'mimes:jpeg,bmp,jpg,png|max:2000',
                'ktp' => 'mimes:jpeg,bmp,jpg,png|max:2000',
                'name' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%?]/',
                    'min:4',
                    'max:50',
                ),
                'username' => array(
                    'required',
                    'unique:users,username,'.$decrypted,
                    'not_regex:/[*<>^&@;=\/|%?]/',
                    'min:4',
                    'max:20',
                ),
                'password' => 'nullable|same:password_confirmation|min:4|max:50',
                'password_confirmation' => 'nullable|min:4|max:50|',
                'email' => 'required|unique:users,email,'.$decrypted.'|email|min:4|max:50',
                'nomor_hp' => array(
                    'required',
                    'unique:users,nomor_hp,'.$decrypted,
                    'regex:[\(?(?:\+62)(?:\d{2,3})?\)?[ .-]?\d{2,4}[ .-]?\d{2,4}[ .-]?\d{2,4}]',
                ),
            ],[
                'name.not_regex' => 'hanya menerima angka dan huruf',
                'username.not_regex' => 'hanya menerima angka dan huruf',
                'nomor_hp.regex' => 'Format Nomor Hp salah ex : +6281246082999',
            ]);

            if($validator->fails())
            {   
                return redirect()->back()->withErrors($validator->errors());
            }
        // AKHIR

        // SIMPAN GAMBAR
            // CARI USER
                $user = User::find($decrypted);
                if(!is_null($user))
                {
                    // IMAGE PROFILE
                        if(!is_null($request->file('image_profile')))
                        {
                            if($user->image == 'default.png')
                            {   
                                // LANGSUNG SIMPAN
                                $simpan_image_profile = Storage::putFile('public_html/image_users',$request->file('image_profile'));
                                $simpan_image_profile = basename($simpan_image_profile);
                                ImageOptimizer::optimize(storage_path('app/public_html/image_users/'.$simpan_image_profile));
                            }
                            else
                            {
                                // HAPUS GAMBAR YANG SUDAH ADA
                                Storage::delete('public_html/image_users/'.$user->image);
                                $simpan_image_profile = Storage::putFile('public_html/image_users',$request->file('image_profile'));
                                $simpan_image_profile = basename($simpan_image_profile);
                                ImageOptimizer::optimize(storage_path('app/public_html/image_users/'.$simpan_image_profile));
                            }

                            // SIMPAN KE TABLE USERS
                            $user->image = $simpan_image_profile;
                        }
                    // AKHIT
                    
                    // IMAGE KTP
                        if(!is_null($request->file('ktp')))
                        {
                            if($user->ktp == 'ktp_default.jpg')
                            {
                                // LANGUSNG SIMPAN
                                $simpan_image_ktp = Storage::putFile('public_html/ktp_users',$request->file('ktp'));
                                $simpan_image_ktp = basename($simpan_image_ktp);
                                ImageOptimizer::optimize(storage_path('app/public_html/ktp_users/'.$simpan_image_ktp));
                            }
                            else
                            {
                                // HAPUS GAMBAR KTP YANG SUDAH ADA
                                Storage::delete('public_html/ktp_users/'.$user->ktp);
                                $simpan_image_ktp = Storage::putFile('public_html/ktp_users',$request->file('ktp'));
                                $simpan_image_ktp = basename($simpan_image_ktp);
                                ImageOptimizer::optimize(storage_path('app/public_html/ktp_users/'.$simpan_image_ktp));
                            }

                            // SIMPAN KE TABLE USER
                                $user->ktp = $simpan_image_ktp;
                            // AKHIR
                        }   
                }
                else
                {
                    return redirect('/profile');
                }
        // AKHIR

        // MAIN LOGIC AND NOTIFICATION
            // APABILA EMAIL BARU MAKA USER HARUS MELAKUKAN VERIFIKASI KEMBALI
                if($user->email != $request->email){
                    $user->verified_email_at = null;
                }
            // AKHIR
            
            $user->name = $request->name;
            $user->username = $request->username;
            $user->email = $request->email;
            $user->nomor_hp = $request->nomor_hp;

            if($request->password != null)
            {
                $user->password = Hash::make($request->password);
            }

            $user->save();
            
            $text = '{"title" : "Update Profile","text" : "Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid", "type" : "common"}';
            
            $user->notify(new UserNotification($text));
            
        // AKHIR
        
        return redirect('/profile')->with(['system' => 'success']);

    }

    public function verifikasi($email)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($email);
            } catch (DecryptException $e) {
                return redirect('/profile');
            }
        // AKHIR

        // MENCARI USER DENGAN EMAIL INI
            $user = Auth::user();
        // AKHIR

        // MEMASUKKAN DATA UNTUK EMAIL
            $data['name'] = $user->name;
            $data['param'] = $email;
        
        // MAIN LOGIC KIRIM EMAIL KE USER
            \Mail::to($decrypted)->send(new VerifikasiUser($data));
            return redirect('/profile')->with(['system' => 'denied']);
        // AKHIR
    }
}
