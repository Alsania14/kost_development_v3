@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('jumlah',$notification)
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('kamar',config('global.active'))
@section('header','Kamar')
@section('content')

<!-- AWAL CONTAINER -->
<div class="container-fluid p-0">
    <div class="row">
        <div class="col">
            <div class="jumbotron m-0 text-center bg-dark d-flex justify-content-around flex-wrap" style="border-top: 3px solid orange;">
<?php
            foreach ($kamar_all as $index => $kamar_single)
            {
?>
            <div class="card mt-3" style="max-width:330px;background:#FEE6A8;">
            <img class="card-img-top" src="{{ asset('storage\kamar\kamar_1.jpg') }}" alt="Card image cap" style="max-height:150px;opacity:1;" >
            <div class="card-body">
                <h5 class="card-title m-0 text-dark">KAMAR</h5>
                <h1 class="card-title m-0 text-dark" style="font-size:40pt;">{{ $kamar_single->nomor }}</h1>
                <h5 class="card-title m-0 mt-2 text-dark">FASILITAS</h5>
                <p class="card-text m-0 text-dark">{{ $kamar_single->fasilitas }}</p>
                <h5 class="card-title m-0 mt-2 text-dark">STATUS</h5>
<?php
                if($kamar_single->user_id != null)
                {
?>
                <p class="card-text m-0 badge badge-success mt-2" style="font-size:12pt;">TERISI</p>
<?php
                }
                else
                {
?>
                <p class="card-text m-0 badge badge-danger mt-2" style="font-size:12pt;">KOSONG</p>
<?php
                }
?>
                <h5 class="card-title m-0 mt-2 text-dark">HARGA</h5>
                <p class="card-text text-dark">Rp. {{ number_format($kamar_single->harga,0,'.','.') }}/{{ $kamar_single->tipe_pembayaran }}</p>
                <a href="{{ url('/kamar',[Crypt::encryptString($kamar_single->id)]) }}" class="btn btn-info">GAMBAR</a>
            </div>
            </div>
<?php
                }
?>
            </div>
        </div>
    </div>
</div>
<!-- AKHIR CONTAINER -->
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@endsection