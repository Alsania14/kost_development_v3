@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('profile',config('global.active'))
@section('header','Profile\Edit')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container">
<form action="{{ url('') }}" id="myform" enctype="multipart/form-data" method="POST">
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

    <div class="row d-flex justify-content-center pt-5">
        <div class="col-md-5 d-flex justify-content-center">
            <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Nama Lengkap" value="{{ $user->name }}" autocorrect="off" autocapitalize="none" required>
        </div>
    </div>

    <div class="row d-flex justify-content-center pt-2">
        <div class="col-md-5 d-flex justify-content-center">
            <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Username" value="{{ $user->username }}" name="username" autocorrect="off" autocapitalize="none" required>
        </div>
    </div>

    <div class="row d-flex justify-content-center pt-2">
        <div class="col-md-5 d-flex justify-content-center">
            <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Email" value="{{ $user->email }}" name="email" autocorrect="off" autocapitalize="none" required>
        </div>
    </div>

    <div class="row d-flex justify-content-center pt-2">
        <div class="col-md-5 d-flex justify-content-center">
            <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;" placeholder="Nomor Handphone" value="{{ $user->nomor_hp }}" name="nomor_hp" autocorrect="off" autocapitalize="none" required>
        </div>
    </div>


    <div class="row d-flex justify-content-center mt-2">
        <div class="col-md-10 text-center">
            <label>Masukkan Gambar KTP</label>
        </div>
        <div class="col-md-5">
                <input type="file" id="capture" class="btn-sm btn-info w-100" accept="image/*" capture>
                <img src="{{ asset('vendor_app/img_web/ktp.jpg') }}" id="image" alt="Something wrong" class="img-thumbnail mt-3">
        </div>
    </div>

    <div class="row d-flex justify-content-center mt-5 mb-5">
        <div class="col-md-10 text-center">
            <button class="btn" style="{{ config('global.active') }}">Submit</button>
        </div>
    </div>
</form>
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