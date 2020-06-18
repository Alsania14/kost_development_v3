@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('dashboard',config('global.active'))
@section('header','Dashboard')
@section('content')

<div id="carouselExampleIndicators" class="carousel slide mb-3" data-ride="carousel" style="border-bottom:3px solid orange;border-top:3px solid orange;">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
        
        <img class="d-block w-100" src="{{ asset('vendor_app/img_web/img1.jpg') }}" alt="First slide" style="max-height:300px;">
        <div class="carousel-caption  d-md-block">
        <h5>Tirta Aruna Cottage</h5>
        <p>Selamat Datang {{ $user->name }} ! Sistem sangat senang bisa bertemu dengan mu</p>
        </div>
    </div>
    <div class="carousel-item">
    
        <img class="d-block w-100" src="{{ asset('vendor_app/img_web/img2.jpg') }}" alt="First slide" style="max-height:300px;">
        <div class="carousel-caption  d-md-block">
        <h5>Tirta Aruna Cottage</h5>
        <p>Ini merupakan sistem terintegrasi WEB Tirta Aruna Cottage, Kamu bisa melakukan pembayaran melewati sistem ini</p>
        </div>
    </div>
    <div class="carousel-item">
    
        <img class="d-block w-100" src="{{ asset('vendor_app/img_web/img3.jpg') }}" alt="First slide" style="max-height:300px;">
        <div class="carousel-caption  d-md-block">
        <h5>Tirta Aruan Cottage</h5>
        <p>JIka kamu masih bingung untuk menggunakan sistem silahkan hubungi developer di menu developer :)</p>
        </div>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<h2 class="text-light mb-5">Next Payment</h2>
    <div class="container p-3">
      <div class="row m-0 mb-5 d-flex justify-content-center">
        <div class="col-md-2 text-center border-bottom" style="font-size:40pt;">
            <span id="hari">0</span> <span style="font-size:20pt">Hari</span>
        </div>
        <div class="col-md-2 text-center border-bottom" style="font-size:40pt;">
            <span id="jam">0</span> <span style="font-size:20pt">Jam</span>
        </div>
        <div class="col-md-2 text-center border-bottom" style="font-size:40pt;">
        <span id="menit">0</span> <span style="font-size:13pt">Menit</span>
        </div>
        <div class="col-md-2 text-center border-bottom" style="font-size:40pt;">
        <span id="detik">0</span> <span style="font-size:13pt">Detik</span>
        </div>
      </div>
    </div>
    
    <div class="row bg-warning">
      <div class="col-md text-center" style="{{ config('global.active') }}">Dibuat dengan bangga oleh Team IT Tirta Aruna Cottage</div>
    </div>
    <script type="text/javascript" src="{{ asset('vendor_app/dashboard/dashboard.js') }}"></script>

    <!-- FUNGSI HITUNG MUNDUR JAVASCRIPT -->
    <script>
      <?php
        if($kamar->tgl_bayar_selanjutnya != null)
        {
          echo 'hitungmundur("'.$kamar->tgl_bayar_selanjutnya.'")';
        }
      ?>
    </script>
      

@endsection