@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda \ Pilih Pembayaran')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
    
    <div class="container-fluid pb-3 m-0 text-center bg-dark" style="border-top:3px solid orange;border-bottom:3px solid orange;">
        <div class="h4 pt-3">ONLINE PAYMENT</div>
        
        <div class="row">
        <div class="col-sm-3 mt-2 d-flex justify-content-center">
            <div class="card" style="max-width:300px;{{ config('global.active') }}">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\img3.jpg') }}" alt="Card image cap" >
            <div class="card-body">
                <h5 class="card-title">BANK BNI</h5>
                <p class="card-text">Pembayaran menggunakan Virtual Account Bank BNI, Transaksi akan langsung terdeteksi sistem tanpa menunggu verifikasi admin</p>
                <form action="#" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="metode" value="online">
                <input type="hidden" name="bank" value="permata">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-2 d-flex justify-content-center">
            <div class="card bg-dark " style="max-width:300px;{{ config('global.active') }}">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\img2.jpg') }}" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title">BANK BCA</h5>
                <p class="card-text">Pembayaran Menggunakan Virtual Account BCA, transaksi akan langsung terdeteksi sistem tanpa memerlukan verifikasi admin</p>
                <form action="#" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="metode" value="online">
                <input type="hidden" name="bank" value="permata">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-2 d-flex justify-content-center">
            <div class="card bg-dark " style="max-width:300px;{{ config('global.active') }}">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\img2.jpg') }}" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title">BANK MANDIRI</h5>
                <p class="card-text">Pembayaran menggunakan Billing Code dan Bill Key Bank Mandiri. Transaksi akan langsung terdeteksi sistem</p>
                <form action="#" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="metode" value="online">
                <input type="hidden" name="bank" value="permata">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-2 d-flex justify-content-center">
            <div class="card bg-dark " style="max-width:300px;{{ config('global.active') }}">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\img2.jpg') }}" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title">BANK PERMATA</h5>
                <p class="card-text">Pempabayaran menggunakan Virtual Account Bank Permata yang akan langsung terdeteksi sistem tanpa perlu verifikasi admin</p>
                <form action="#" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="metode" value="online">
                <input type="hidden" name="bank" value="permata">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>

        
        </div>
        
        
        
    </div>


</div>
<!--  AKHIR CONTAINER -- -->
<footer class="row page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@extends('app_layout/modal')
@section('judul','Mark All Berhasil')
@section('isi','Mark All Berhasil Dilakukan')
@endsection