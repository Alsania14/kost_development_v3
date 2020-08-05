<?php

namespace App\Http\Controllers\admindashboard\reportuser;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Contracts\Encryption\DecryptException;

use App\Transaksi;
use App\User;
use App\Notifications\UserNotification;

class ValidasiController extends Controller
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
                'tagihan_id' => array(
                    'nullable',
                    'numeric',
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'digits_between:0,10',
                ),
                'bukti' => array(
                    'nullable',
                    Rule::in(['dikirim', 'tidak_dikirim']),
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:15',
                ),
                'status_pembayaran' => array(
                    'nullable',
                    Rule::in(['proses', 'pending','expired','approved']),
                    'not_regex:/[*<>^&@;=\/|%]/',
                    'max:10',
                ),
            ]);
        
            if($validator->fails())
            {
                return redirect()->back()->with(['system' => 'denied2']);
            }
        // AKHIR
        
        // MENGAMBIL DATA TRANSAKSI MANUAL BERDASARKAN PARAMETER
            $transaksis = DB::table('tagihans')
                            ->select('transaksis.*' ,'users.username','users.id as user_id','users.nomor_hp','tagihans.nomor_kamar','tagihans.tipe_pembayaran','tagihans.nominal_pembayaran')
                            ->join('transaksis','transaksis.tagihan_id','=','tagihans.id')
                            ->join('users','users.id','=','tagihans.user_id')
                            ->where('transaksis.via','manual')
                            ->where('transaksis.deleted_by_admin',0);
                          
            if(isset($request->status_pembayaran))
            {
                $transaksis = $transaksis->where('status_pembayaran',$request->status_pembayaran);
            }
            
            if(isset($request->tagihan_id))
            {
                $transaksis = $transaksis->where('tagihan_id',$request->tagihan_id);
            }

            if(isset($request->bukti))
            {
                if($request->bukti == 'dikirim')
                {
                    $transaksis = $transaksis->whereNotNull('bukti_transaksi');
                }
                else
                {
                    $transaksis = $transaksis->whereNull('bukti_transaksi');
                }
            }

            if(isset($transaksis->status_transaksi))
            {
                $transaksis = $transaksis->where('status_pembayaran',$request->status_pembayaran);
            }

            
            if(isset($request->user))
            {                
                    $hasil = User::where('username', 'like', '%'.$request->user.'%')->get();
                    $array_hasil = array();
                    foreach ($hasil as $index => $var_hasil) {
                        $array_hasil[$index] = $var_hasil->id;
                    }
                    
                    $transaksis = $transaksis->whereIn('user_id',$array_hasil);
            }
                    
                    $transaksis = $transaksis->orderBy('tagihans.status_tagihan','ASC')
                                ->paginate(10);
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

        return view('admin/adminreportuser/validasitransaksi/validasitransaksi',compact('transaksis','notification','input'));

    }

    public function verifikasi(Request $request,$id)
    {
        // SECURITY LAYER
            // DECRYPT ID TRANSAKSI MANUAL
                try {
                    $decrypted = Crypt::decryptString($id);
                } catch (DecryptException $e) {
                    return redirect()->back();
                }
            // AKHIR
            
            // MENGAMBIL DATA ADMIN
                $admin = Auth::user();
            // AKHIR

            // MENCOCOKKAN PASSWORD ADMIN
                if(!Hash::check($request->password, $admin->password))
                {
                    return redirect()->back()->with(['system' => 'denied2']);
                }
            // CEK PASSWORD ADMIN
                
        // AKHIR

        // MAIN LOGIC
                // MENCARI TRANSAKSI DENGAN ID YANG TELAH DI DECRYPT
                    $transaksi = Transaksi::where('id',$decrypted)
                                            ->where('via','manual')
                                            ->where('status_pembayaran','pending')
                                            ->first();

                    if($transaksi == null)
                    {
                        return redirect()->back()->with(['system' => 'denied2']);
                    }
                // AKHIR
                
                // MENGUBAH STATUS TAGIHAN MENJADI APPROVED
                    $transaksi->status_pembayaran = 'approved';
                    $transaksi->developer_information_finish = 'deiverifikasi oleh admin '.$admin->username. ' pada '.date('Y-m-d H:i:s');
                    $transaksi->save();
                // AKHIR

                // MENGUPDATE TABLE TAGIHAN YANG BERELASI DENGAN TRANSAKSI INI
                    $tagihan = $transaksi->tagihan()->first();
                    $tagihan->status_tagihan = 'lunas';
                    $tagihan->tgl_pembayaran = date('Y-m-d');
                    $tagihan->save();
                // AKHIR

                // MENGAMBIL DATA USER PEMBAYAR
                    $user = $tagihan->user();
                // AKHIR
                
                // NOTIFIKASI USER DAN ADMIN
                    $text = '{"title" : "PEMBAYARAN SUCCESS","text" : "Selamat '.$user->username.' anda telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID '.$tagihan->id.' Transaksi dilakukan dengan order_id'.$transaksi->order_id.'" , "type" : "special"}';
                
                    $user->notify(new UserNotification($text));

                    $text = '{"title" : "PEMBAYARAN SUCCESS","text" : "user '.$user->username.' telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID '.$tagihan->id.' Transaksi dilakukan dengan order_id'.$transaksi->order_id.'" , "type" : "special"}';
                
                    $admin->notify(new UserNotification($text));
                // AKHIR

                // NOTIFIKASI ADMIN
                    

        // AKHIR

        return redirect()->back()->with(['system' => 'success2']);

    }

    public function rejecttransaksi($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect()->back()->with(['system' => 'denied2']);
            }
        // AKHIR

        // MAIN LOGIC
            // MENCARI TRANSAKSI
                $transaksi = Transaksi::find($decrypted);
                
                if($transaksi == null)
                {
                    return redirect()->back()->with(['system' => 'denied2']);
                }
            // AKHIR
            
            // MENGHAPUS TRANSAKSI
                $transaksi->status_pembayaran = 'rejected';
                $transaksi->deleted_by_admin = 1;
                $transaksi->save();
            // AKHIR

            return redirect()->back()->with(['system' => 'success2']);

        // AKHIR
    }
}
