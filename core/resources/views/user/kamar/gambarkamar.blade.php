@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('jumlah',$notification)
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('kamar',config('global.active'))
@section('header','Kamar / Gambar Kamar')
@section('content')

<!-- AWAL CONTAINER -->
<div class="container-fluid p-0">
<div class="row m-0 mb-3 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="{{ url('/kamar') }}" type="button" class="btn btn-primary">Kembali</a>
    </div>
  </div>
    <div class="row">
        <div class="col">
            <div class="jumbotron m-0 text-center bg-dark d-flex justify-content-center flex-column" style="border-top: 3px solid orange;">
            <h3 class="mb-4">GAMBAR KAMAR {{ $kamar_single->nomor }}</h3>
            <div class="container d-flex justify-content-center flex-wrap">
<?php
            foreach ($gambars as $key)
            {
?>
            <a href="{{ url('storage/kamar',[$key->image]) }}">
            <img src="{{ url('storage/kamar',[$key->image]) }}" class="m-1 img-thumbnail" alt="Ops Something Wrong" style="max-height:300px;">
            </a>
<?php
            }
?>
            </div>
            </div>
        </div>
    </div>    
</div>
<!-- AKHIR CONTAINER -->
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@endsection