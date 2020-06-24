<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Tagihan extends Model
{
    use SoftDeletes;

    public function user()
    {
        return $this->belongsTo('App\User','user_id')->withTrashed()->first();
    }

    public function kamar()
    {
        return $this->belongsTo('App\Kamar','kamar_id')->withTrashed()->first();
    }

    public function transaksi()
    {
        return $this->hasMany('App\Transaksi','tagihan_id')->withTrashed()->get();
    }
}
