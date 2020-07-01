@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pelaporan',config('global.active'))
@section('header','Pelaporan')
@section('content')
<div class="jumbotron p-1 bg-dark" style="border-top:3px solid orange;">
    <div class="container">
        <div class="row">
            <div class="col d-flex flex-column justify-content-center text-center">
                <h3>LAPORAN KERUSAKAN PROPERTI</h3>
                <div class="overflow-hidden">
<?php
        if($kuota_laporan == 0)
        {
?>
                    <img src="{{ asset('storage/image_pelaporan/noimage.png') }}" class="mb-4" style="max-height:300px;" id="gambar">
                    <div class="d-flex flex-column justify-content-center">
                    <form action="{{ url('/laporan') }}" id="myform" method="POST" enctype="multipart/form-data">
                        {{ csrf_field() }}
                        <label for="inputan" class="btn btn-info" style="width:200px;">MASUKKAN GAMBAR</label>
                        <input type="file" id="inputan" accept="image/*" name="laporan" style="display:none;">
                        <input type="submit" id="submit" style="display:none;">
                    </form>
                    </div>
                    <textarea name="keluhan" class="w-75 mt-3" form="myform" style="resize:none;color:black;border-radius:8px;border-top:3px solid orange;height:100px;" placeholder="Jelaskan kerusakan properti" maxlength="200"></textarea>
                    <div>
                    <label for="submit" class="btn mt-5" style="{{ config('global.active') }}">SUBMIT</label>
                    </div>
                </div>
<?php
        }
        else
        {
?>  
                    <img src="{{ asset('storage/image_pelaporan/lock.png') }}" style="max-height:300px;">
                    <h5 class="text-info">KUOTA LAPORAN HARI INI TELAH DIGUNAKAN</h5>
                </div>
<?php
        }
?>
                
            </div>
        </div>
    </div>
</div>

<div class="jumbotron pt-5 bg-dark" style="border-top:3px solid orange;">
        <div class="container">
            <div class="row">
                <div class="col">
                <h3 class="text-center">HISTORY LAPORAN</h3>
<?php
        foreach ($laporans as $index => $laporan)
        {
?>       
                <div class="list-group mt-5">
                <div class="list-group-item list-group-item-action flex-column align-items-start bg-info shadow-lg">
                    <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Laporan</h5>
                    <button class="text-light btn btn-sm btn-danger">X</button>
                    </div>
                </div>
                <div class="list-group-item list-group-item-action flex-column align-items-start bg-dark shadow-lg">
                    <div class="d-flex w-100 justify-content-between">
                    </div>
                    <h5>LAPORAN ANDA</h5>
                    <small>{{ $laporan->created_at }}</small>
                    <p class="mb-1">{{ $laporan->keluhan }}</p>
<?php
            if($laporan->image_keluhan != null)
            {
?>
                    <a href="{{ url('storage/image_pelaporan',[$laporan->image_keluhan]) }}" class="btn btn-primary btn-sm mt-4" >GAMBAR</a>
<?php
            }
            else
            {
?>
                   <button class="btn btn-secondary btn-sm mt-4">TIDAK DISERTAKAN GAMBAR</button>
<?php
            }
?>
                    <h5 class="mb-1 mt-3">RESPON ADMIN</h5>
                    <p class="mb-1">{{ $laporan->respon }}</p>
                    
                    <h5 class="mb-1 mt-3">STATUS</h5>
                    <p class="mb-1">{{ strtoupper($laporan->status_keluhan) }}</p>
                </div>
                </div>
<?php
        }
?>
                </div>
            </div>
        </div>
</div>

<?php
        if($kuota_laporan == 0)
        {  
?>
    <script>
        var image = document.getElementById('gambar');
        var input = document.getElementById('inputan');
        input.addEventListener('change',(ev)=>{
                console.log(input.files[0]);
                if(input.files[0].type.indexOf("image/") > -1){
                    image.src = window.URL.createObjectURL(input.files[0]);
                    image.innerHtml = window.URL.createObjectURL(input.files[0]);
                }
            })
    </script>
<?php
        }
?>

@endsection