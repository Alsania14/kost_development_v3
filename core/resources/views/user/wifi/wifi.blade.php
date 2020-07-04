@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('jumlah',$notification)
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('wifi',config('global.active'))
@section('header','Wifi')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:600px;">
    <div class="row">
        <div class="col">
            <div class="jumbotron bg-dark" style="border-top:3px solid orange;height:500px;">
                <div class="h2 text-center">WIFI NAME</div>

                <div class="d-flex justify-content-center">
                <label class="bg-light text-dark w-25 font-weight-bold lead text-center" style="min-width:200px;border-top:3px solid orange;border-radius:5px;">
                    {{ $wifi }}
                </label>
                </div>

                <div class="h2 text-center mt-5">WIFI PASSWORD</div>
                <div class="d-flex justify-content-center">
                <label class="bg-light text-dark w-25 font-weight-bold lead text-center" style="min-width:200px;border-top:3px solid orange;border-radius:5px;">
                    {{ $password }}
                </label>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- AKHIR CONTAINER -->
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@extends('app_layout/modal')
@section('judul','UPDATE BERHASIL')
@section('isi','Update berhasil,Pastikan anda memberikan identitas dan dokumen yang valid, apabila anda melakukan perbuhan pada email mohon untuk melakukan verifikasi kembali')


@extends('app_layout/modal_denied')
@section('modal_denied_judul','VERIFIKASI EMAIL')
@section('modal_denied_isi','EMAIL VERIFIKASI TELAH DIKIRIMKAN KE EMAIL ANDA MOHON UNTUK MEMBUKA EMAIL ANDA DAN MENEKAN LINK YANG DIBERIKAN')
@endsection