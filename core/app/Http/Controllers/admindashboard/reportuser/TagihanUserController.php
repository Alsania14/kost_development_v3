<?php

namespace App\Http\Controllers\admindashboard\reportuser;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Http\Request;
use Illuminate\Contracts\Encryption\DecryptException;

use App\Tagihan;
use App\User;
use App\Notifications\UserNotification;

class TagihanUserController extends Controller
{
    public function index(Request $request)
    {
        // SECURITY LAYER
            $validator = Validator::make($request->all(),[
                'user' => array(
                    'nullable',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:50',
                ),
                'nomor_kamar' => array(
                    'nullable',
                    'numeric',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:50',
                ),
                'tipe' => array(
                    'nullable',
                    Rule::in(['bulan', 'tahun']),
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:50',
                ),
                'status_tagihan' => array(
                    'nullable',
                    Rule::in(['hutang', 'lunas']),
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:50',
                ),
            ]);
        
            if($validator->fails())
            {
                return redirect('/admintagihan')->with(['system' => 'denied']);
            }
        // AKHIR
        
        // MENGAMBIL SEMUA DATA TAGIHAN DENGAN PARAMETER (SEARCH ENGINE)
            $tagihans = Tagihan::query()->where('deleted_by_admin',0);
            
            if(isset($request->status_tagihan))
            {
                $tagihans = $tagihans->where('status_tagihan',$request->status_tagihan);
            }

            if(isset($request->nomor_kamar))
            {
                $tagihans = $tagihans->where('nomor_kamar',$request->nomor_kamar);
            }
            
            if(isset($request->tipe))
            {
                $tagihans = $tagihans->where('tipe_pembayaran',$request->tipe);
            }

            if(isset($request->user))
            {                
                    $hasil = User::where('username', 'like', '%'.$request->user.'%')->get();
                    $array_hasil = array();
                    foreach ($hasil as $index => $var_hasil) {
                        $array_hasil[$index] = $var_hasil->id;
                    }
                    
                    $tagihans = $tagihans->whereIn('user_id',$array_hasil);
            }
            
            // MEMBUAT PAGINATION
               $tagihans =  $tagihans
                            ->orderBy('status_tagihan','ASC')
                            ->orderBy('tgl_awal_sewa','ASC')
                            ->paginate(10);
            // AKHIR
            
        // AKHIR

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

        // MEMBENTUK VARIABLE INPUT SEARCH ENGINE
            $input = $request->all();
        // AKHIR
        
        return view('admin\adminreportuser\tagihanuser\admintagihanuser',compact('notification','tagihans','input'));
    }

    public function tariktagihan(Request $request,$id)
    {   
        // SECURITY LAYER
                $validator = Validator::make($request->all(),[
                    'password' => 'required|min:4|max:50',
                ]);
            
                if($validator->fails())
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }

            // MENGAMBIL DATA ADMIN
                $admin = Auth::user();
            // AKHIR
            
            // DECRYPT ID TAGIHAN UNSER
                try {
                    $decrypted = Crypt::decryptString($id);
                } catch (DecryptException $e) {
                    return redirect()->back()->with(['system' => 'denied']);
                }
            // AKHIR

            // PASSWORD ADMIN CHECK
                if(!Hash::check($request->password,$admin->password))
                {
                    return redirect()->back()->with(['system' => 'denied']);
                }
            // AKHIR

        // AKHIR
        
        // MAIN LOGIC
                // MENGAMBIL DATA TAGIHAN
                    $tagihan = Tagihan::find($decrypted);
                    $transaksis = $tagihan->transaksi();
                    $curl = curl_init();
                    
                    // CURL EXECUTOR
                        foreach ($transaksis as $index => $transaksi)
                        {
                            if($transaksi->status_pembayaran != 'expired' && $transaksi->status_pembayaran != 'approved' && $transaksi->status_pembayaran != 'rejected')
                            {                            
                                curl_setopt_array($curl, array(
                                    CURLOPT_URL => config('global.url_midtrans_base').$transaksi->order_id.'/cancel',
                                    CURLOPT_RETURNTRANSFER => true,
                                    CURLOPT_ENCODING => "",
                                    CURLOPT_MAXREDIRS => 10,
                                    CURLOPT_TIMEOUT => 0,
                                    CURLOPT_FOLLOWLOCATION => true,
                                    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                                    CURLOPT_CUSTOMREQUEST => "POST",
                                    CURLOPT_HTTPHEADER => array(
                                    "Accept: application/json",
                                    "Authorization: ".config('global.key_midtrans'),
                                    "Content-Type: application/json"
                                    ),
                                ));
                                $response = curl_exec($curl);
                                $err = curl_error($curl);
                                // JIKA TERJADI ERROR MAKA REDIRECT BACK DENGAN INFORMASI
                                    $response_php = json_decode($response);
                                    if($err != "")
                                    {
                                        return redirect('/admintagihan')->with(['system' => 'denied']);
                                    }
                                // AKHIR
                            }
                            $transaksi->deleted_by_admin = 1;
                            $transaksi->save();
                        }
                        curl_close($curl);
                
                    // AKHIR

                    // MENGAMBIL DATA USER DAN MENGUPDATE DATA TAGIHAN MENJADI TERHAPUS
                        $user = $tagihan->user();
                        $tagihan->deleted_by_admin = 1;
                        $tagihan->save();
                    // AKHIR

                // AKHIR
                
                // MEMBUAT NOTIFIKASI ADMIN
                    $text = '{"title" : "Penarikan Tagihan","text" : "Tagihan User '.$user->username.' dengan tanggal tagihan '.$tagihan->tgl_awal_sewa.' sampai dengan '.$tagihan->tgl_akhir_sewa.' telah berhasil ditarik", "type" : "common"}';

                    $admin->notify(new UserNotification($text));
                // AKHIR

                    return redirect()->back();
        // AKHIR
       


        
    }
}
