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
        if($kuota_laporan != 0)
        {
?>
                    <img src="{{ asset('storage/image_pelaporan/noimage.png') }}" style="max-height:300px;">
                    <div class="d-flex flex-column justify-content-center">
                    <form action="#" id="myform">
                        <label for="inputan" class="btn btn-info" style="width:200px;">MASUKKAN GAMBAR</label>
                        <input type="file" id="inputan" name="laporan" style="display:none;">
                        <input type="submit" id="submit" style="display:none;">
                    </form>
                    </div>
                    <textarea name="keluhan" class="w-75 mt-3" form="myform" style="resize:none;color:white;border-radius:3px;border-top:3px solid orange;height:100px;" placeholder="Jelaskan kerusakan properti" maxlength="200"></textarea>
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
@endsection