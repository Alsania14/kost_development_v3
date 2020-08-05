<?php

namespace App\Http\Controllers\admindashboard\reportuser;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Maatwebsite\Excel\Facades\Excel;

use App\Exports\TagihansExport;

class ExportingreportController extends Controller
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

        return view('admin/adminreportuser/adminexporting/adminreportindex',compact('notification'));
    }

    public function tagihanreport(Request $request)
    {   
        // SECURITY LAYER
            $validator=Validator::make($request->all(),[
                'tgl_awal' => 'nullable|date',
                'tgl_akhir' => 'nullable|date',
            ]);

            if($validator->fails())
            {
                return redirect()->back()->withErrors($validator->errors());
            }
        // AKHIR
        
        
        // EKSEKUSI PARAMETER
            $array_params = [];
            if(isset($request->tgl_awal))
            {
                $array_params[] = $request->tgl_awal;
            }
            else
            {
                $array_params[] = '0000-01-01';
            }

            if(isset($request->tgl_akhir))
            {
                $array_params[] = $request->tgl_akhir;
            }
            else
            {
                $array_params[] = '3000-01-01';
            }
            
        return Excel::download(new TagihansExport($array_params),'TIRTA ARUNA TAGIHAN REPORT.xlsx');
        
    }

    public function preview(Request $request)
    {
         // SECURITY LAYER
            $validator=Validator::make($request->all(),[
                'tgl_awal' => 'nullable|date',
                'tgl_akhir' => 'nullable|date',
            ]);

            if($validator->fails())
            {
                return redirect()->back()->withErrors($validator->errors());
            }
        // AKHIR
        
        
        // EKSEKUSI PARAMETER
            $array_params = [];
            if(isset($request->tgl_awal))
            {
                $array_params[] = $request->tgl_awal;
            }
            else
            {
                $array_params[] = '0000-01-01';
            }

            if(isset($request->tgl_akhir))
            {
                $array_params[] = $request->tgl_akhir;
            }
            else
            {
                $array_params[] = '3000-01-01';
            }
        // AKHIR

            $tagihans = DB::table('tagihans')
                            ->select('tagihans.id AS tagihan_idnya','tagihans.*','users.*','users.id AS user_idnya')
                            ->join('users','users.id','=','tagihans.user_id')
                            ->whereDate('tagihans.tgl_awal_sewa','>',$array_params[0])
                            ->whereDate('tagihans.tgl_awal_sewa','<',$array_params[1])
                            ->orderBy('tagihans.tgl_awal_sewa','ASC')
                            ->get();

        return view('admin/adminreportuser/adminexporting/admintagihan',compact('tagihans'));
    }
}
