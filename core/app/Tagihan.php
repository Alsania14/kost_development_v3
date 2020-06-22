<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Tagihan extends Model
{
    public function user()
    {
        return $this->belongsTo('App\User','user_id');
    }

    public function kamar()
    {
        return $this->belongsTo('App\Kamar','kamar_id');
    }
}
