<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes; 

class Transaksi extends Model
{
    use SoftDeletes;

    public function tagihan()
    {
        return $this->belongsTo('App\Tagihan')->withTrashed();
    }

    public function user()
    {
        return $this->belongsTo('App\User')->withTrashed();
    }
}
