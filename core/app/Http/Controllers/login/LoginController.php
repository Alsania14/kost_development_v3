<?php

namespace App\Http\Controllers\login;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

use App\User;

// MENENTUKAN DATETIME
date_default_timezone_set("Asia/Makassar");
class LoginController extends Controller
{
    public function viewlogin()
    {
        return view('user/reglog/login');
    }

    public function postlogin(Request $request)
    {
        // SECURITY LAYER

            // ANTI XSS VALIDATOR
            $validator = Validator::make($request->all(),[
                'username' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'min:4',
                    'max:50',
                ),
                'password' => 'required|min:4|max:50',
            ]);

            if($validator->fails())
            {
                dd($validator->fails());
                return redirect()->back()->withErrors($validator->errors())->withInput();
            }
        // AKHIR
            
        // MAIN LOGIC
            $credentials = $request->only('username','password');
            if(Auth::attempt($credentials))
            {   
                if(Auth::user()->role == 'user')
                {
                    if(Auth::user()->verify_admin == 1)
                    {
                        return redirect('/dashboard');
                    }
                    else
                    {
                        return redirect()->back()->with(['system' => 'denied']);
                    }
                }
                elseif(Auth::user()->role == 'admin')
                {   
                    return date('Y-m-d h:i:s a');
                }
                else
                {   
                    return redirect()->back()->with(['system' => 'denied']);
                }
            }
            else
            {
                return redirect()->back()->with(['system' => 'false']);
            }
        // AKHIR
    }

    public function logout()
    {
        Auth::logout();
        return redirect('/login');
    }
}
