<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\User;
use App\Kamar;
use App\Tagihan;

class AdminDashboardController extends Controller
{
    public function index()
    {   
        // MENGAMBIL DATA USER DI DALAM SISTEM
            $users = User::all();
            $user_aktif = $users->where('deleted_by_admin',0)->where('role','user')->count();
            $user_denied = $users->where('deleted_by_admin',1)->where('role','user')->count();
            $users = $users->count();
        // AKHIR

        // MENGAMBIL DATA KAMAR DI DALAM SISTEM
            $kamars = Kamar::all();
            $kamar_disewa = $kamars->where('user_id','!=',null)->count();
            $kamars = $kamars->count();
        // AKHIR

        // DATA TAGIHAN
            $tagihans =  Tagihan::all();
            $tagihan_hutang = $tagihans->where('status_tagihan','hutang')->count();
            $tagihan_terbayar = $tagihans->where('status_tagihan','lunas')->count();
            $tagihans = $tagihans->count();
        // AKHIR

        // PEMASUKAN
            $pemasukans = DB::select('SELECT SUM(nominal_pembayaran) as total_pemasukan FROM tagihans WHERE tagihans.`status_tagihan` = "lunas"');
            $pemasukan_belum_dibayar = DB::select('SELECT SUM(nominal_pembayaran) as total_pemasukan_belum_dibayar FROM tagihans WHERE tagihans.`status_tagihan` = "hutang"');
        // AKHIR

        return view('admin/admindashboard/admindashboard',compact('user_aktif','users','user_denied','kamars','kamar_disewa','tagihans','tagihan_hutang','tagihan_terbayar','pemasukans','pemasukan_belum_dibayar'));
    }
}
