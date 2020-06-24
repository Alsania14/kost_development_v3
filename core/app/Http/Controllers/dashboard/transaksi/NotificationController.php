<?php

namespace App\Http\Controllers\dashboard\transaksi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Transaksi;

class NotificationController extends Controller
{
    public function index(Request $request)
    {   
        $transaksi = Transaksi::where('order_id',$request->order_id)->first();

        if($request->transaction_status == 'settlement')
        {
            $transaksi->status_pembayaran = 'approved';
            $tagihan = $transaksi->tagihan()->first();
            $tagihan->status_tagihan = 'lunas';
            $tagihan->save();
        }
        elseif($request->transaction_status == 'expired')
        {
            $transaksi->status_pembayaran = 'expired';
        }
        elseif($request->transaction_status == 'pending')
        {
            $transaksi->status_pembayaran = 'pending';
        }
        else
        {
            $transaksi->status_pembayaran = 'rejected';
        }

        $transaksi->save();

        return \response('oke',200);
    }
}
