@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda \ Pilih Pembayaran')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
    
    <div class="jumbotron m-0 text-center bg-dark" style="border-top: 3px solid orange;">
        <div class="h4">ONLINE PAYMENT</div>
        
        <div class="row">
        <div class="col-sm-3 mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background: rgb(1,94,109);background: linear-gradient(90deg, rgba(1,94,109,1) 11%, rgba(40,179,201,1) 100%);">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\BNI.jpg') }}" alt="Card image cap" style="height:150px;" >
            <div class="card-body">
                <h5 class="card-title">BANK BNI</h5>
                <p class="card-text">Pembayaran menggunakan Virtual Account Bank BNI, Transaksi akan langsung terdeteksi sistem tanpa menunggu verifikasi admin</p>
                <form action="{{ url('/onlinebni') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{$id}}">
                <input type="submit" class="btn mt-2 font-weight-bold" value="CHARGE" style="{{ config('global.active') }}">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background: rgb(1,4,255);background: linear-gradient(90deg, rgba(1,4,255,1) 0%, rgba(64,66,255,1) 100%);">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\BCA.jpg') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">BANK BCA</h5>
                <p class="card-text">Pembayaran Menggunakan Virtual Account BCA, transaksi akan langsung terdeteksi sistem tanpa memerlukan verifikasi admin</p>
                <form action="{{ url('/onlinebca') }}" method="POST">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{$id}}">
                 <input type="submit" class="btn mt-2 font-weight-bold" value="CHARGE" style="{{ config('global.active') }}">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background:#1d2f61;">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\MANDIRI.png') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">BANK MANDIRI</h5>
                <p class="card-text">Pembayaran menggunakan Billing Code dan Bill Key Bank Mandiri. Transaksi akan langsung terdeteksi tanpa verifikasi admin</p>
                <form action="{{ url('/onlinemandiri') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{$id}}">
                 <input type="submit" class="btn mt-2 font-weight-bold" value="CHARGE" style="{{ config('global.active') }}">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm-3 mt-4 d-flex justify-content-center">
            <div class="card " style="max-width:300px;background:#c23917;">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\PERMATA.png') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">BANK PERMATA</h5>
                <p class="card-text">Pempabayaran menggunakan Virtual Account Bank Permata yang akan langsung terdeteksi sistem tanpa perlu verifikasi admin</p>
                <form action="{{ url('/onlinepermata') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{ $id }}">
                 <input type="submit" class="btn mt-2 font-weight-bold" value="CHARGE" style="{{ config('global.active') }}">
                </form>
            </div>
            </div>
        </div>

        </div>
        
    </div>


    <div class="jumbotron m-0 text-center bg-dark mt-5" style="border-top: 3px solid orange;">
        <div class="h4">MINIMARKET PAYMENT</div>
        
        <div class="row">
        <div class="col-sm mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background: rgb(47,58,139);background: linear-gradient(90deg, rgba(47,58,139,1) 25%, rgba(0,2,255,1) 94%);">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\indomaret.png') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">INDOMARET</h5>
                <p class="card-text">Pembayaran melalui toko indomaret terdekat, dengan memberikan indomaret Payment Code untuk validasi pembayaran</p>
                <form action="{{ url('/tokoindomaret') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{ $id }}">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>
        <div class="col-sm mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background:#ea081c;">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\alfamart.jpg') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">ALFAMART</h5>
                <p class="card-text">Pembayaran melalui toko alfamart terdekat, dengan memberikan alfamart Payment Code untuk validasi pembayaran</p>
                <form action="{{ url('/tokoalfamart') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{$id}}">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE">
                </form>
            </div>
            </div>
        </div>
        </div>
    </div>

    <div class="jumbotron m-0 text-center bg-dark mt-5" style="border-top: 3px solid orange;">
        <div class="h4">MANUAL PAYMENT</div>
        
        <div class="row">
        <div class="col-sm mt-4 d-flex justify-content-center">
            <div class="card" style="max-width:300px;background: brown;">
            <img class="card-img-top" src="{{ asset('vendor_app\img_web\manual.png') }}" alt="Card image cap" style="height:150px;">
            <div class="card-body">
                <h5 class="card-title">MANUAL PAYMENT</h5>
                <p class="card-text">Pembayaran dengan metode upload bukti pembayaran sehingga diperlukan waktu untuk memproses bukti yang dikirim valid atau tidak oleh admin sistem</p>
                <form action="{{ url('/manual') }}" method="post">
                {{ csrf_field() }}
                <input type="hidden" name="tagihan" value="{{ $id }}">
                <input type="submit" class="btn btn-secondary mt-2" value="CHARGE" style="{{ config('global.active') }}">
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
@endsection