<?php

namespace App\Http\Controllers\dashboard\tagihan\manual;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Contracts\Encryption\DecryptException;
use ImageOptimizer;

use App\Notifications\UserNotification;
use App\Tagihan;
use App\Transaksi;

class ManualController extends Controller
{
    public function charge(Request $request)
    {   
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($request->tagihan);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // MAIN LOGIC CHARGE
            $user = Auth::user();
            $tagihan = Tagihan::find($decrypted);
            $kamar = $tagihan->kamar();
        // AKHIR

        // MEMBUAT NOMOR ID DAN NOTA
            $statement = DB::select("SHOW TABLE STATUS LIKE 'transaksis'");
            $nextid = $statement[0]->Auto_increment;

            $filled_int = sprintf("%05d",$nextid);
            $nota = config('global.nota').'M-'.$filled_int;
        // AKHIR
        
         // PENYIMPANAN DATA TRANSAKSI DENGAN STATUS DARI RESPONSE API
            $transaksi_new = new Transaksi;
            $transaksi_new->order_id = $nota;
            $transaksi_new->tagihan_id = $decrypted;
            $transaksi_new->tgl_awal = $tagihan->tgl_awal_sewa;
            $transaksi_new->tgl_akir = $tagihan->tgl_akhir_sewa;
            $transaksi_new->nominal = $tagihan->nominal_pembayaran;
            $transaksi_new->via = 'manual';
            $transaksi_new->integration_name = 'manual';
            $transaksi_new->status_pembayaran = 'proses';
            $transaksi_new->save();
        // AKHIR
        
        // USER NOTIFICATION
            $text = '{"title" : "CHARGE MANUAL !","text" : "Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid","type" : "common"}';
                    
            $user->notify(new UserNotification($text));
        // AKHIR

        return redirect('/manual'.'/'.Crypt::encryptString($transaksi_new->id))->with(['system' => 'success']);
    }

    public function detailtransaksimanual($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/transaksi');
            }
        // AKHIR

        // MENGAMBIL DATA TRANSAKSI
            $transaksi = Transaksi::withTrashed()->find($decrypted);
        // AKHIR

        // MENGAMBIL TAGIHAN TRANSKASI UNTUK MENDAPATKAN KAMAR YANG DIBAYARKAN
            $tagihan = $transaksi->tagihan()->first();
            $nomor = $tagihan->kamar()->nomor;
        // AKHIR

        // MENGAMBIL DATA USER
            $user = Auth::user();
            $kamar = $user->kamar();
        // AKHIR

        // CEK NOTIFIKASI USER
            $notification = $user->unreadNotifications->count();
            if($notification == 0)
            {
                $notification = null;
            }
        // AKHIR

        return view('/user/pembayaran/transaksi/detailmanual',compact('user','kamar','notification','transaksi','tagihan','nomor','id'));
    }

    public function uploadbukti(Request $request)
    {   
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($request->tagihan);
            } catch (DecryptException $e) {
                return redirect()->back()->with(['system' => 'denied']);
            }

            $validator = Validator::make($request->all(),[
                'bukti' => 'required|image|mimes:jpeg,png,jpg,svg|max:4096',
            ]);
            
            if($validator->fails())
            {
                return redirect()->back()->with(['system' => 'denied']);
            }
        // AKHIR
        
        // MAIN LOGIC
            // MENCARI TRANSAKSI DENGAN ID YANG TELAH DI DECRYPT
                $transaksi  = Transaksi::find($decrypted);
            // AKHIR
            
            //MENYIMPAN FILE BUKTI PADA SERVER
                    /*APABILA BUKTI MASIH KOSONG MAKA LANGSUNG DISIMPAN */
                    if($transaksi->bukti_transaksi == null)
                    {   
                        
                        $simpan = Storage::putFile('public_html/bukti_pembayaran',$request->file('bukti'));
                        $nama_file = basename($simpan);
                        ImageOptimizer::optimize(storage_path('app/public_html/bukti_pembayaran/'.$nama_file));
                    }
                    elseif($transaksi->bukti_transaksi != null)
                    {   
                        
                        Storage::delete('public_html/bukti_pembayaran/'.$transaksi->bukti_transaksi);
                        $simpan = Storage::putFile('public_html/bukti_pembayaran',$request->file('bukti'));
                        $nama_file = basename($simpan);
                        ImageOptimizer::optimize(storage_path('app/public_html/bukti_pembayaran/'.$nama_file));
                    }
            // AKHIR
                    

            // SIMPAN DATA KE DALAM TABLE TRANSAKSI
                    $transaksi->bukti_transaksi = $nama_file;
                    $transaksi->status_pembayaran = 'pending';
                    $transaksi->save();
            // AKHIR

        // AKHIR

        return redirect()->back()->with(['system' => 'success']);
    }
}
