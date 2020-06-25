<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes; 

class User extends Authenticatable
{
    use Notifiable,SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function kamar()
    {
        return $this->hasOne('App\Kamar')->withTrashed()->first();
    }

    public function tagihan()
    {
        return $this->hasMany('App\Tagihan')
                    ->withTrashed()
                    ->orderBY('status_tagihan')
                    ->orderBy('tgl_awal_sewa','desc')
                    ->where('deleted_by_user',0)
                    ->get();
    }

    public function tagihanarsip()
    {
        return $this->hasMany('App\Tagihan')
                    ->withTrashed()
                    ->orderBY('status_tagihan')
                    ->orderBy('tgl_awal_sewa','desc')
                    ->where('deleted_by_user',1)
                    ->get();
    }
    
    public function notifications(){
        return $this->morphMany(UserNotification::class, 'notifiable' )->orderBy('created_at', 'desc');
    }

}
