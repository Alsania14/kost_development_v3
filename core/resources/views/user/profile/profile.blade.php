@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('profile',config('global.active'))
@section('header','Profile')
@section('content')

<!-- AWAL CONTAINER -->
<div class="container">
    <div class="row d-flex justify-content-center">
        <div class="col-md-7 d-flex justify-content-center">
            <img src="{{ url('storage/image_users',[$user->image]) }}" alt="Something wrong" style="max-width:200px;max-height:200px;border-radius:50%;" class="img-thumbnail">
        </div>
    </div>

    <div class="row d-flex justify-content-center mt-2">
        <div class="col-md-7 d-flex justify-content-center h3 text-center">
            {{ $user->name }}
        </div>
    </div>

    <div class="row d-flex justify-content-center mt-2">
        <div class="col-md-7 d-flex justify-content-center h5 text-center">
            {{ strtoupper($user->username) }}
        </div>
    </div>

    <div class="row d-flex justify-content-center mt-5">
        <div class="col-md-6 d-flex justify-content-between border-bottom">
            <div>
                Email
            </div>
            <div>
                {{ $user->email }}
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center">
        <div class="col-md-6 d-flex justify-content-between border-bottom">
            <div>
                Nomor HP
            </div>
            <div>
                <?php
                    // JIKA NULL
                        if($user->nomor_hp == null)
                        {
                            echo 'Belum Diatur';
                        }
                        else
                        {
                            echo $user->nomor_hp;
                        }
                    // AKHIR
                ?>
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center">
        <div class="col-md-6 d-flex justify-content-between border-bottom">
            <div>
                KTP
            </div>
            <div>
                <?php
                    // JIKA NULL
                    if(is_null($user->ktp))
                    {
                        echo 'Belum Diatur';
                    }
                    else
                    {
                        echo '<button class="btn btn-sm btn-info">Lihat</button>';
                    }
                ?>
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center">
        <div class="col-md-6 d-flex justify-content-between border-bottom">
            <div>
                Room
            </div>
            <div>
                {{ $kamar->nomor }}
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center">
        <div class="col-md-6 d-flex justify-content-between border-bottom">
            <div>
                Tanggal Masuk
            </div>
            <div>
                {{ $user->created_at }}
            </div>
        </div>
    </div>

    <div class="row d-flex justify-content-center pt-5 mb-5">
        <div class="col-md-6 d-flex justify-content-center">
            <a href="{{ url('/edit',[Crypt::encryptString($user->id)]) }}">
            <button class="btn" style="{{ config('global.active') }}">Edit Profile</button>
            </a>
        </div>
    </div>

</div>
<!-- AKHIR CONTAINER -->
      

@endsection