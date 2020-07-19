<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Notifications\UserNotification;

use App\User;

class AdminProfileController extends Controller
{
    public function index()
    {
        // MENGAMBIL DATA ADMIN
            $admin = Auth::user();
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $admin->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        // VERIFIKASI NOMOR HP
            if($admin->nomor_hp == null)
            {
                $admin->nomor_hp = "belum diatur";
            }
        // AKHIR

        return view('admin/adminprofile/adminprofile',compact('admin','notification'));
    }

    public function edit()
    {
        // MENGAMBIL DATA ADMIN
            $admin = Auth::user();
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $admin->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        return view('admin/adminprofile/admineditprofile',compact('admin','notification'));
    }

    public function update(Request $request)
    {
        // SECURITY LAYER
            // MENGAMBIL DATA ADMIN UNTUK UNIQUE VALIDATOR
                $admin = User::where('role','admin')->first();
            // AKHIR
            $validator = Validator::make($request->all(),[
                'username' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%?]/',
                    'min:4',
                    'max:50',
                    'unique:users,username,'.$admin->id,
                ),
                'name' => array(
                    'required',
                    'not_regex:/[*<>^&@;=\/|%?]/',
                    'min:4',
                    'max:50',
                ),

                'nomor_hp' => 'required|numeric|digits_between:4,14|unique:users,nomor_hp,'.$admin->id,
                'email' => 'required|email|min:4|max:50|unique:users,email,'.$admin->id,
                'password' => 'nullable|same:password_confirmation|min:4|max:50',
                'password_confirmation' => 'nullable|min:4|max:50',
            ],[
                'username.not_regex' => 'tidak diperbolehkan menggunakan simbol',
                'name.not_regex' => 'tidak diperbolehkan menggunakan simbol',
                'nomor_hp.not_regex' => 'tidak diperbolehkan menggunakan simbol',
            ]);
        
            if($validator->fails())
            {   
                return redirect()->back()->withErrors($validator->errors());
            }
        // AKHIR

        // MAIN LOGIC UPDATE
                $admin->name = $request->name;
                $admin->username = $request->username;
                $admin->nomor_hp = $request->nomor_hp;
                $admin->email = $request->email;

                if($request->password != null)
                {
                    $admin->password = Hash::make($request->password);
                }

                $admin->save();
        // AKHIR

        // NOTIFIKASI UNTUK ADMIN
            $text = '{"title" : "Update Profile","text" : "Profile Admin telah diperbaharui , data credential untuk login menggunakan data profile terbaru", "type" : "common"}';
            
            $admin->notify(new UserNotification($text));
        // AKHIR

        return redirect('/adminprofile')->with(['system' => 'success']);
    }
}
