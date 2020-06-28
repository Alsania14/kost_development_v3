@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('jumlah',$notification)
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('profile',config('global.active'))
@section('header','Profile\Edit')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0">
    <div class="jumbotron bg-dark pt-5" style="border-top:3px solid orange;">
    <form action="{{ url('/edit',[Crypt::encryptString($user->id)]) }}" id="myform" enctype="multipart/form-data" method="POST" onsubmit="document.getElementById('subbutton').disabled=true;">
        {{ csrf_field() }}
        {{ method_field('PUT') }}
        <div class="row d-flex justify-content-center">
            <div class="col-md-5 d-flex justify-content-center">
                <img src="{{ url('storage/image_users',[$user->image]) }}" alt="Something wrong" style="width:200px;height:200px;border-radius:50%;" class="img-thumbnail" id="bingkai_profile">
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-5">
            <div class="col-md-10 text-center">
                <label>Pilih Gambar Profile</label>
            </div>
            <div class="col-md-5 d-flex justify-content-center">
                <input type="file" class="btn-sm btn-info" name="image_profile" style="color:black;" id="image_profile">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('image_profile'))
                    {
                        echo $errors->first('image_profile');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-5">
            <div class="col-md-5 d-flex justify-content-center">
                <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Nama Lengkap" value="{{ $user->name }}" name="name" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('name'))
                    {
                        echo $errors->first('name');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-2">
            <div class="col-md-5 d-flex justify-content-center">
                <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Username" value="{{ $user->username }}" name="username" autocorrect="off" autocapitalize="none" minlength="4" maxlength="20">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('username'))
                    {
                        echo $errors->first('username');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-2">
            <div class="col-md-5 d-flex justify-content-center">
                <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Email" value="{{ $user->email }}" name="email" autocorrect="off" autocapitalize="none" minlength="4" maxlength="30">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('email'))
                    {
                        echo $errors->first('email');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-2">
            <div class="col-md-5 d-flex justify-content-center">
                <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Nomor Handphone" value="{{ $user->nomor_hp }}" name="nomor_hp" autocorrect="off" autocapitalize="none" minlength="4" maxlength="14">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('nomor_hp'))
                    {
                        echo $errors->first('nomor_hp');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-2">
        <div class="col-md-10 text-center">
                <label>Bila diperlukan silahkan ganti password</label>
            </div>
            <div class="col-md-5 d-flex justify-content-center">
                <input type="password" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Password Baru" name="password" autocorrect="off" autocapitalize="none" minlength="4" maxlength="14">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('password'))
                    {
                        echo $errors->first('password');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center pt-2">
            <div class="col-md-5 d-flex justify-content-center">
                <input type="password" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Konfirmasi Password" name="password_confirmation" autocorrect="off" autocapitalize="none" minlength="4" maxlength="14">
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('password_confirmation'))
                    {
                        echo $errors->first('password_confirmation');
                    }
                ?>
                </p>
            </div>
        </div>

        <div class="row d-flex justify-content-center mt-2">
            <div class="col-md-10 text-center">
                <label>Masukkan Gambar KTP</label>
            </div>
            <div class="col-md-5 text-center">
                    <img src="{{ url('/storage/ktp_users',[$user->ktp]) }}" style="max-height:300px;max-width:300px;" id="image" alt="Something wrong" class="img-thumbnail mt-3">
                    <input type="file" id="capture" name="ktp" class="btn-sm btn-info mt-3 w-75" accept="image/*" capture>
            </div>
        </div>
        <div class="row">
            <div class="col-md text-center">
                <p class="text-danger" style="font-size:15pt;">
                <?php
                    if($errors->has('ktp'))
                    {
                        echo $errors->first('ktp');
                    }
                ?>
                </p>
            </div>
        
        </div>
        

        <div class="row d-flex justify-content-center mt-5 mb-5">
            <div class="col-md-10 text-center">
                <a href="{{ url('/profile') }}">
                <button type="button" class="btn btn-danger mr-5" >Cancel</button>
                </a>
                <button type="submit" class="btn" style="{{ config('global.active') }}" id="subbutton">Submit</button>
            </div>
        </div>
    </form>
    </div>
<!-- FOOTER -->
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
</div>

<script>
    document.addEventListener('DOMContentLoaded', (ev)=>{
        let form = document.getElementById('myform');
        let input = document.getElementById('capture');
        let profile = document.getElementById('image_profile');

        profile.addEventListener('change',(ev)=>{
            console.log(profile.files[0]);
            if(profile.files[0].type.indexOf("image/") > -1){
                let bingkai = document.getElementById('bingkai_profile');
                bingkai.src = window.URL.createObjectURL(profile.files[0]);
                bingkai.innerHtml = window.URL.createObjectURL(profile.files[0]);
            }
        })

        input.addEventListener('change',(ev)=>{
            console.log(input.files[0]);
            if(input.files[0].type.indexOf("image/") > -1){
                let img = document.getElementById('image');
                img.src = window.URL.createObjectURL(input.files[0]);
                img.innerHtml = window.URL.createObjectURL(input.files[0]);
            }
        })
    })
</script>
<!-- AKHIR CONTAINER -->

@endsection