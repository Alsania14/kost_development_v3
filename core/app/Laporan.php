<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Laporan extends Model
{
    public function user()
    {
        return $this->belongsTo('App\User','user_id')->withTrashed();
    }

    public function kamar()
    {
        return $this->belongsTo('App\Kamar','kamar_id')->withTrahed();
    }
}
