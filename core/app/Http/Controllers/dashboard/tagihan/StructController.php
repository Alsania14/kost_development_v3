<?php

namespace App\Http\Controllers\dashboard\tagihan;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Contracts\Encryption\DecryptException;
use PDF;

use App\Tagihan;

class StructController extends Controller
{
    public function index($id)
    {
        // SECURITY LAYER
            try {
                $decrypted = Crypt::decryptString($id);
            } catch (DecryptException $e) {
                return redirect('/tagihan');
            }
        // AKHIR

        // MENGAMBIL TAGIHAN DENGAN ID YANG TELAH DI DECRYPT
            /* JIKA TERDAPAT KEMUNGKINAN SATU TAGIHAN TERDAPAT 2 TRANSAKSI YANG APRROVED (USER BAYAR 2 KALI UNTUK SATU TAGIHAN)
            WALAUPUN INI CASE LANGKA, SISTEM AKAN MENGAMBIL TRANSAKSI YANG DI APPROVE PERTAMA */
            $tagihan = Tagihan::find($decrypted);
            $transaksi = $tagihan->transaksi()->where('status_pembayaran','approved')->first();
            $user = $tagihan->user();
            $kamar = $tagihan->kamar();
        // AKIHIR

        // MAIN LOGIC
            $data['name'] = $user->name;
            $data['username'] = $user->username;
            $data['kamar'] = $kamar->nomor;
            $data['tanggal'] = $tagihan->tgl_pembayaran;
            $data['order_id'] = $transaksi->order_id;
            $data['tgl_awal_sewa'] = $tagihan->tgl_awal_sewa;
            $data['tgl_akhir_sewa'] = $tagihan->tgl_akhir_sewa;
            $data['harga'] = $tagihan->nominal_pembayaran;
            $data['status'] = $tagihan->status_tagihan;
            $pdf = PDF::loadView('user/pembayaran/tagihan/struk',array('data' => $data));
            return $pdf->download('invoice.pdf');
        // AKHIR
    }
}
