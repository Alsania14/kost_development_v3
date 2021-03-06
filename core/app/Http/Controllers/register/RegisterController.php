<?php

namespace App\Http\Controllers\register;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Contracts\Encryption\DecryptException;

use App\User;
use App\Mail\VerifikasiUser;

class RegisterController extends Controller
{
    public function viewregister()
    {
        return view('user/reglog/register');
    }

    public function postregister(Request $request)
    {   
        // SECURITY LAYER
            
            // LARAVEL VALIDATION ANTI XSS
            $validator = Validator::make($request->all(),[
                'name' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'min:4',
                    'max:50',
                ),
                'email' => 'required|email|unique:users,email|min:4|max:50',
                'username' => array(
                    'required',
                    'unique:users,username',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'min:4',
                    'max:50',
                ),
                'password' => 'required|same:password_confirmation|min:4|max:50',
                'password_confirmation' => 'required|min:4|max:50|',
            ],[
                'name.not_regex' => 'hanya menerima angka dan huruf',
                'username.not_regex' => 'hanya menerima angka dan huruf',
            ]);

            if($validator->fails())
            {
                return redirect()->back()->withErrors($validator->errors())
                ->withInput();
            }
            
        // AKHIR

        // MAIN LOGIC

            // GENERATE KODE_INVITATION 
            while (true) 
            {
                $characters = '0123456789abcdefghijklmnopqrstuvwxyz';
                $charactersLength = strlen($characters);
                $randstring = '';
                for ($i = 0; $i < 5; $i++)
                {
                    $randstring .= $characters[rand(0, $charactersLength - 1)];
                }
                
                if(User::where('kode_invitation',$randstring)->first())
                {
                    
                }
                else
                {
                    break;
                }
            }
            
            // SIMPAN DATA BARU
                $new_user = new User;
                $new_user->name = $request->name;
                $new_user->username = $request->username;
                $new_user->email = $request->email;
                $new_user->password = Hash::make($request->password);
                $new_user->kode_invitation = $randstring;
                $new_user->role = 1;
                $new_user->save();
            // AKHIR

            // MEMASUKKAN DATA PENTING UNTUK VERIFIKASI EMAIL
                $data['param'] = Crypt::encryptString($request->email); 
                $data['name'] = $request->name;
            // AKHIR

            // KIRIMKAN EMAIL VERIFIKASI KEPADA USER
                \Mail::to($request->email)->send(new VerifikasiUser($data));
            // AKHIR

                return redirect('/login')->with(['system' => 'success']);
        // AKHIR
    }

    public function verifikasiemail($email)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($email);
            } catch (DecryptException $e) {
                return redirect('/register');
            }
        // AKHIR
            
        // MAIN LOGIC VERIFIKASI EMAIL
            $user = User::where('email',$decrypted)->first();
            
            if($user != null)
            {
                $user->verified_email_at = date('Y-m-d H:i:s');
                $user->save();
            }
            else
            {
                return redirect('/login')->with(['system' => 'denied']);
            }
        // AKHIR

        return view('email/success');
    }
}
