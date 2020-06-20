<?php

namespace App\Http\Controllers\dashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Validator;
use ImageOptimizer;

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

    public function update(Request $request,$id)
    {   
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
                    'not_regex:/[*<>^&@;=\/|%?]/',
                    'min:4',
                    'max:20',
                ),
                'email' => 'required|email|min:4|max:50',
                'nomor_hp' => 'required|numeric|digits_between:8,14'
            ],[
                'name.not_regex' => 'hanya menerima angka dan huruf',
                'username.not_regex' => 'hanya menerima angka dan huruf',
            ]);

            if($validator->fails())
            {   
                return redirect()->back()->withErrors($validator->errors());
            }
        // AKHIR

        // DECRYPT ID USER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/profile');
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
                                Storage::delete('image_users/'.$user->image);
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
                                Storage::delete('ktp_users',$user->ktp);
                                $simpan_image_ktp = Storage::putFile('public_html/ktp_users',$request->file('ktp'));
                                $simpan_image_ktp = basename($simpan_image_ktp);
                                ImageOptimizer::optimize(storage_path('app/public_html/ktp_users/'.$simpan_image_ktp));
                            }

                            // SIMPAN KE TABLE USER
                            $user->ktp = $simpan_image_ktp;
                        }   
                }
                else
                {
                    return redirect('/profile');
                }
        // AKHIR

        // MAIN LOGIC
            
            $user->name = $request->name;
            $user->username = $request->username;
            $user->email = $request->email;
            $user->nomor_hp = $request->nomor_hp;
            $user->save();
            
            return redirect('/profile')->with(['system' => 'success']);
        // AKHIR

    }
}
