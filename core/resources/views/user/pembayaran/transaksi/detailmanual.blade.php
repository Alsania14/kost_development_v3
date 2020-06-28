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
       ONLINE VIRTUAL ACCOUNT PAYMENT</p>
    <p style="font-size:20pt;">
    <b>SUBJECT NOTA</b><br>
    ORDER ID : <br> {{ $transaksi->order_id }} <br><br>
    DATE : <br> {{ $transaksi->created_at }} <br><br>
    DIBERIKAN UNTUK : <br> {{ $user->name }} <br><br>

    <b>PAYMENT METHOD</b><br>
    MANUAL PAYMENT : <br> {{$transaksi->integration_name}} <br><br>

    <b>RANGKUMAN PEMBAYARAN</b><br>
    KAMAR NOMOR {{ $nomor }} <br> QTY 1 <br> TANGGAL SEWA <br> {{ $transaksi->tgl_awal }} S/D {{ $transaksi->tgl_akir }} <br>
    HARGA {{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }}
    <br><br>
    TOTAL {{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }} <br><br>

    <div class="border-bottom justify-content-center" style="overflow:hidden;">
        <p style="font-size:20pt;"><b>BUKTI PEMBAYARAN  :</p> </b>
        <div class="w-100 d-flex justify-content-center">
<?php
            if($transaksi->bukti_transaksi == null)
            {
?>
        <img src="{{ url('storage/bukti_pembayaran/noimage.png') }}" alt="belum ada bukti pembayaran" style="max-width:300px;" id="img_bukti">
        </div>
        
            <form action="{{ url('/uploadbukti',[$id]) }}" method="post" enctype="multipart/form-data" class="d-flex justify-content-center flex-wrap">
                {{ csrf_field() }}
                <label for="inputan" class="btn-sm mt-3 btn-light">Select Image</label>
                <input class="btn-sm text-light w-100" style="visibility:hidden;" type="file" name="bukti" onchange="ganti()" accept="image/*" id="inputan" required>
                <input class="btn-light btn-sm text-dark mt-3" type="submit" value="kirim" style="max-height:30px;">
            </form>
        
<?php       }
            elseif($transaksi->bukti_pembayaran != null)
            {
?>
                <img src="{{ url('storage/bukti_pembayaran',[$transaksi->bukti_pembayaran]) }}" alt="belum ada bukti pembayaran" style="max-width:200px;">
<?php
            }
?>
         
    </div>
    </p>
    <hr class="my-4">
    </span>
    <p class="text-light">Charge pembayaran kost secara manual berhasil dilakukan tolong untuk segera mengupload (mengunggah) bukti pembayaran anda. Setelah mengirim, selama belum diverifikasi oleh admin anda bebas untuk mengganti foto yang telah dikirim melalui halaman ini</p>
    <p class="lead">
        <a class="btn btn-primary btn-lg" href="{{ url('/transaksi') }}" role="button">Halaman Transaksi</a>
    </p>
    </div>

</div>
<!--  AKHIR CONTAINER -- -->
<footer class="row page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>

<script>
    var img = document.getElementById("img_bukti");
    var input = document.getElementById("inputan");
    function ganti()
    {
        img.src = window.URL.createObjectURL(input.files[0]);
    }
</script>


@extends('app_layout/modal')
@section('judul','Charge Berhasil')
@section('isi','Charge Berhasil Silahkan lanjutkan ke tahap selanjutnya')
@endsection