@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda \ Pilih Pembayaran \ Charge Success')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">

    <div class="jumbotron bg-dark pt-4" style="border-top:3px solid orange;">
    <h1 class="display-4 mb-5">Charge Success</h1>
    <span style="font-family:courier new;">
    <p class="lead border-top border-bottom text-center">
       MERCHANT ONLINE PAYMENT</p>
    <p style="font-size:15pt;">
    <b>SUBJECT NOTA</b><br>
    ORDER ID : <br> {{ $transaksi->order_id }} <br><br>
    DATE : <br> {{ $transaksi->created_at }} <br><br>
    DIBERIKAN UNTUK : <br> {{ $user->name }} <br><br>

    <b>PAYMENT METHOD</b><br>
    MERCHANT PAUMENT : <br> Merchant Payment {{$transaksi->integration_name}} <br><br>

    <b>RANGKUMAN PEMBAYARAN</b><br>
    KAMAR NOMOR {{ $nomor }} <br> QTY 1 <br> TANGGAL SEWA {{ $transaksi->tgl_awal }} S/D {{ $transaksi->tgl_akir }} <br>
    HARGA {{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }}
    <br><br>
    TOTAL {{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }} <br><br>
    
<?php
        if($transaksi->integration_name != 'mandiri')
        {
?>
            <div class="border-top border-bottom" style="font-size:20pt;">
                <b>CODE PAYEMENT</b><br>
                CODE PAYMENT : {{ $transaksi->field_1 }}
            </div>
<?php
        }
        else
        {
?>
            <div class="border-top border-bottom" style="font-size:20pt;">
                <b>BILL CODE</b><br>
                BILL KEY : {{ $transaksi->field_1 }} <br>
                BILLER CODE : {{ $transaksi->field_2 }}
            </div>
<?php
        }
?>
    </p>
    <hr class="my-4">
    </span>
    <p class="text-light">Charge pembayaran kost berhasil dilakukan, silahkan lanjutkan untuk melakukan pembayaran menggunakan CODE PAYMENT diatas. Anda bebas untuk meninggalkan halaman ini, informasi diatas dapat anda lihat kembali pada halaman pembayaran kost -> transaksi</p>
    <p class="lead">
        <a class="btn btn-primary btn-lg" href="{{ url('/transaksi') }}" role="button">Halaman Transaksi</a>
    </p>
    </div>

</div>
<!--  AKHIR CONTAINER -- -->
<footer class="row page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@extends('app_layout/modal')
@section('judul','Charge Berhasil')
@section('isi','Charge Berhasil Silahkan lanjutkan ke tahap selanjutnya')
@endsection