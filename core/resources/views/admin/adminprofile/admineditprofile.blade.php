@extends('app_layout.admindashboard_layout')
@section('jumlah',$notification)
@section('')
@section('content')
@section('header','Admin Profile / Admin Edit Profile')
<div class="container-fluid p-0" style="min-height:555px;">
    
    <div class="jumbotron bg-dark pt-5" style="border-top:3px solid orange;">
        <div class="row">
            <div class="col-md d-flex flex-column text-center">
                <form action="{{ url('/adminpostprofile') }}" id="main_form" method="post" onsubmit="document.getElementById('sub').disabled=true;document.getElementById('modal_lanjutkan').disabled=true;" autocomplete="off">
                {{ csrf_field() }}
                <div class="d-flex justify-content-center">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN USERNAME</small>
                </div>
                <div class="d-flex justify-content-center">
                <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" placeholder="username" name="username" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50"  value="{{ $admin->username }}" required>
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('username'))
                    {
                        echo $errors->first('username');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN NAME</small>
                </div>
                <div class="d-flex justify-content-center">
                    <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" placeholder="name" name="name" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" value="{{ $admin->name }}" required>
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('name'))
                    {
                        echo $errors->first('name');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN NOMOR HP</small>
                </div>
                <div class="d-flex justify-content-center">
                    <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" placeholder="Belum diatur" name="nomor_hp" autocorrect="off" autocapitalize="none" minlength="4" maxlength="14" value="{{ $admin->nomor_hp }}" required>
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('nomor_hp'))
                    {
                        echo $errors->first('nomor_hp');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN EMAIL</small>
                </div>
                <div class="d-flex justify-content-center">
                    <input type="email" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" placeholder="Belum diatur" name="email" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" value="{{ $admin->email }}" required>
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('email'))
                    {
                        echo $errors->first('email');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center mt-5">
                    <p class="m-0 text-info" style="width:400px;font-size:12pt;">JIKA DIPERLUKAN SILAHKAN GANTI PASSWORD</p>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">PASSWORD</small>
                </div>
                <div class="d-flex justify-content-center">
                    <input type="password" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" name="password" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" >
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('password'))
                    {
                        echo $errors->first('password');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">PASSWORD CONFIRMATION</small>
                </div>
                <div class="d-flex justify-content-center">
                    <input type="password" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" name="password_confirmation" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" >
                </div>
                <div class="d-flex justify-content-center">
                    <p class="text-danger">
<?php
                    if($errors->has('password_confirmation'))
                    {
                        echo $errors->first('password_confirmation');
                    }
?>
                    </p>
                </div>

                <div class="d-flex justify-content-center">
                    <div style="width:400px;" class="d-flex justify-content-around">
                    <a href="" class="btn btn-sm mt-5 bg-danger text-light">CANCEL</a>
                    <button type="button" id="sub" class="btn btn-sm mt-5" style="{{ config('global.active') }}">SUBMIT</button>
                    </div>
                </div>

                </form>

            </div>
        </div>
    </div>

</div>
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@extends('app_layout/modal_denied')
@section('modal_denied_judul','PERINGATAN ADMIN')
@section('modal_denied_isi')
    <p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan pembaruan pada profile.</p>
    <ul>
        <li class="text-dark">Mengganti Username maka credential untuk login kedalam sistem akan menggunakan username terbaru</li>
        <li class="text-dark">Mengganti Nomor HP maka data pada halaman Kontak sisi users akan menunjukkan nomor terbaru</li>
        <li class="text-dark">Mengganti E-mail maka data pada pada halaman kontak sisi users akan menunjukkan email terbaru, dan laporan sistem akan ditujukan pada email terbaru </li>
        <li class="text-dark">Mengganti Password maka credential yang akan digunakan untuk login admin merupakan password terbaru</li>

    </ul>
    
    <input type="submit" id="modal_lanjutkan" class="btn-info btn" value="LANJUTKAN" form="main_form" style="position:relative;transform:translateX(-50%);left:50%;">
    
@endsection

@endsection

@section('tambahanbawah')
<script>
    document.addEventListener('DOMContentLoaded', (ev)=>{
        let tombol = document.getElementById("sub");

        tombol.addEventListener('click',(ev)=>{
        $('#modaldenied').modal('show');
    })
    })

    
</script>
@endsection
