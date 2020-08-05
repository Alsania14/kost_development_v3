@extends('app_layout.admindashboard_layout')
@section('jumlah',$notification)
@section('reportadmin',config('global.active'))
@section('header','Report Admin \ Exporting Report')
@section('content')
<div class="container-fluid p-0">
<div class="jumbotron bg-dark p-0 mb-5" id="searchengine" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
<div class="row">
        <div class="col-md">
            <h3 class="text-center mt-3">EXPORT TAGIHAN</h3>

<form action="{{ url('/adminexportingtagihan') }}" method="POST">
            {{ csrf_field() }}
            <div class="row p-4 mt-4">
                <div class="col-md mt-3">
                    <label>Dari Tanggal</label>
                    <input type="date" class="form-control" name="tgl_awal" id="awalan">
                </div>
                <div class="col-md mt-3">
                    <label>Sampai Tanggal</label>
                    <input type="date" class="form-control" name="tgl_akhir" id="akhiran">
                </div>
            </div>
            
            <div class="row p-4 mt-4">
                <div class="col-md mt-3 flex-column justify-content-center">

                    <div class="d-flex justify-content-center">
                        <input type="submit" class="btn btn-sm text-dark font-weight-bold" style="{{ config('global.active') }};width:200px;" value="EXPORT & DOWNLOAD">
                    </div>
</form>
                    
                    <div class="d-flex justify-content-center">
                        <form action="{{ url('/adminpreviewtagihan') }}" method="GET" target="_blank">
                        <input type="submit" class="btn btn-sm btn-info text-dark font-weight-bold mt-2" value="PREVIEW" style="width:200px;">
                        <input type="hidden" name="tgl_awal" id="form2_awalan">
                        <input type="hidden" name="tgl_akhir" id="form2_akhiran">
                        </form>
                        </a>
                    </div>

                    <div class="d-flex justify-content-center text-center mt-3">
                        <p class="text-info">Untuk melakukan EXPORT semua data tagihan tanpa parameter, admin bisa langsung menekan tombol EXPORT & DOWNLOAD</p>
                    </div>
                </div>
            </div>


        </div>
    </div>
    </div>
</div>

@endsection


@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN')
@section('isi')
@endsection

@extends('app_layout/modal_denied')
@section('modal_denied_judul','REJECT TRANSAKSI MANUAL')
@section('modal_denied_isi')
@endsection

@extends('app_layout/modal_denied2')
@section('modal_denied2_judul','TERJADI KESALAHAN')
@section('modal_denied2_isi')
@endsection

@extends('app_layout/modal2')
@section('judul2','SUCCESS')
@section('isi2')
@endsection

@section('tambahanbawah')
<script>
    let tgl_awal = document.getElementById('awalan');
    let tgl_akhir = document.getElementById('akhiran')

    tgl_awal.addEventListener('change',(ev)=>{
        document.getElementById('form2_awalan').value = tgl_awal.value;
    })

    tgl_akhir.addEventListener('change',(ev)=>{
        document.getElementById('form2_akhiran').value = tgl_akhir.value;
    })
</script>
@endsection

