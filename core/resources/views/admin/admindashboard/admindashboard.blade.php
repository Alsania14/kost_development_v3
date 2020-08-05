@extends('app_layout.admindashboard_layout')
@section('headtambahan')
<link rel="stylesheet" href="{{ asset('/vendor_app/admindashboard/admindashboard.css') }}">
@endsection
@section('dashboard',config('global.active'))

@section('content')
<div class="container-fluid p-0 pl-1">
    
        <div class="row p-2">
            <div class="col-md d-flex justify-content-center mb-5" >
                <div class="col-md d-flex justify-content-center" id="logo" style="border-radius:50%;max-width:400px;">
                    <img  class="img-fluid mb-3" src="{{ asset('vendor_app/logo/logo.png') }}" alt="SIGNAL BURUK">
                </div>
            </div>
        </div>
        
        <div class="row mb-5 p-3">
            <div class="col-md d-flex justify-content-center">
                <div class="text-center p-2 w-100" style="font-size:15pt;transition:2s;" id="kata_bijak">{!! $bijak !!}</div>
            </div>
        </div>
    
    <div class="jumbotron bg-dark pt-5" style="border-top:3px solid orange;">
        <div class="d-flex flex-column justify-content-center">
            <h3 class="text-center">TOP LEVEL REPORT</h3>

            <div class="row text-center mt-5">
                <div class="col-md">
                    <h3 class="badge badge-primary w-100" style="font-size:20pt;">USERS</h3>
                </div>
            </div>
            <div class="row m-0 shadow-lg">
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-male" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">USER DI DALAM SISTEM</h6>
                    <h4>{{ $users }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-walking" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">USER AKTIF</h6>
                    <h4>{{ $user_aktif }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-street-view" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">USER DENIED</h6>
                    <h4>{{ $user_denied }}</h4>
                </div>
            </div>

            <div class="row text-center mt-5">
                <div class="col-md">
                    <h3 class="badge badge-primary w-100" style="font-size:20pt;">KAMAR</h3>
                </div>
            </div>
            <div class="row m-0 shadow-lg">
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-hotel" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">BANYAK KAMAR</h6>
                    <h4>{{ $kamars }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-invoice-dollar" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">KAMAR DISEWA</h6>
                    <h4>{{ $kamar_disewa }}</h4>
                </div>
            </div>

            <div class="row text-center mt-5">
                <div class="col-md">
                    <h3 class="badge badge-primary w-100" style="font-size:20pt;">TAGIHAN</h3>
                </div>
            </div>
            <div class="row m-0 shadow-lg">
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-invoice" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">TAGIHAN DIBUAT</h6>
                    <h4>{{ $tagihans }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-invoice-dollar" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">TAGIHAN DIBAYAR</h6>
                    <h4>{{ $tagihan_terbayar }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-excel" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">TAGIHAN BELUM DIBAYAR</h6>
                    <h4>{{ $tagihan_hutang }}</h4>
                </div>
            </div>

            <div class="row text-center mt-5">
                <div class="col-md">
                    <h3 class="badge badge-primary w-100" style="font-size:20pt;">PEMASUKAN</h3>
                </div>
            </div>
            <div class="row m-0 shadow-lg">
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-invoice" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">PEMASUKAN YANG SUDAH DIBAYAR USER</h6>
                    <h4>{{ 'Rp. '.number_format($pemasukans[0]->total_pemasukan,0,'.','.') }}</h4>
                </div>
                <div class="col-md mt-3 d-flex flex-column justify-content-center text-center">
                    <i class="fas fa-file-contract" style="font-size:120pt;left:50%;transform:translateX(-50%);position:relative;"></i>
                    <h6 class="mt-2">PEMASUKAN YANG BELUM DIBAYAR USER</h6>
                    <h4>{{ 'Rp. '.number_format($pemasukan_belum_dibayar[0]->total_pemasukan_belum_dibayar,0,'.','.') }}</h4>
                </div>
            </div>

        </div>
    </div>

</div>
@endsection

@section('tambahanbawah')
<script type="text/javascript" src="{{ asset('vendor_app/fontawesome/js/all.min.js') }}"></script>

<script type="text/javascript">
var block = 'open';
    $('#logo').on('click', function() {
    if(block == 'open'){
        bijaksana(block);
        block='close';
        $('#logo').css('animation','mymove2 7s');
        
        setTimeout("$('#logo').css('animation','mymove 20s infinite')", 7000);
        setTimeout("block='open'", 7000);
        
    }

    });

function  bijaksana(block)
{
    if(block == 'open')
    {
    var xhttp = new XMLHttpRequest();
    
    xhttp.onreadystatechange = function(){
        if(this.readyState == 4 && this.status == 200){
            document.getElementById("kata_bijak").innerHTML=this.responseText;
        }
    }
    xhttp.open("GET","{{ url('/adminbijak') }}");
    xhttp.send();
    };
}
</script>
@endsection