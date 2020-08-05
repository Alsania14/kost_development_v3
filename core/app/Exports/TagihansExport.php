<?php

namespace App\Exports;

use App\Tagihan;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\DB;

use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;

class TagihansExport implements FromView,WithColumnFormatting
{
    
    public $tagihans;

    public function __construct($array_params)
    {    
        $this->tagihans = DB::table('tagihans')
                                ->select('tagihans.id AS tagihan_idnya','tagihans.*','users.*','users.id AS user_idnya')
                                ->join('users','users.id','=','tagihans.user_id')
                                ->whereDate('tagihans.tgl_awal_sewa','>',$array_params[0])
                                ->whereDate('tagihans.tgl_awal_sewa','<',$array_params[1])
                                ->orderBy('tagihans.tgl_awal_sewa','ASC')
                                ->get();
                                
    }

    public function view(): View
    {
        return view('admin/adminreportuser/adminexporting/admintagihan', [
            'tagihans' => $this->tagihans,
        ]);
    }

    public function columnFormats(): array
    {
        return [
            'D' => "+############################",
        ];
    }
}
