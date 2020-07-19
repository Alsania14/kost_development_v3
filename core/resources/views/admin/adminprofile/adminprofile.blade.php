@extends('app_layout.admindashboard_layout')
@section('jumlah',$notification)
@section('profile',config('global.active'))
@section('content')
@section('header','Admin Profile')
<div class="container-fluid p-0" style="min-height:555px;">
    
    <div class="jumbotron bg-dark pt-5" style="border-top:3px solid orange;">
        <div class="row">
            <div class="col-md d-flex flex-column text-center">
                <div class="d-flex justify-content-center">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN USERNAME</small>
                </div>
                <div class="d-flex justify-content-center">
                    <div style="font-size:20pt;border-bottom:1px solid white;width:400px;">{{ ($admin->username) }}</div>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN NAME</small>
                </div>
                <div class="d-flex justify-content-center">
                    <div style="font-size:20pt;border-bottom:1px solid white;width:400px;">{{ ($admin->name) }}</div>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN NOMOR HP</small>
                </div>
                <div class="d-flex justify-content-center">
                    <div style="font-size:20pt;border-bottom:1px solid white;width:400px;">{{ ($admin->nomor_hp) }}</div>
                </div>

                <div class="d-flex justify-content-center mt-3">
                    <small class="m-0 text-left" style="width:400px;font-size:8pt;">ADMIN EMAIL</small>
                </div>
                <div class="d-flex justify-content-center">
                    <div style="font-size:20pt;border-bottom:1px solid white;width:400px;">{{ ($admin->email) }}</div>
                </div>

                <div class="d-flex justify-content-center">
                    <div style="width:400px;" class="d-flex justify-content-around">
                    <a href="" class="btn btn-sm mt-5 bg-info font-weight-bold" style="font-size:8pt;">VERIFIKASI EMAIL</a>
                    <a href="{{ url('/admineditprofile') }}" class="btn btn-sm mt-5" style="{{ config('global.active') }}">EDIT PROFILE</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<footer class="page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@extends('app_layout/modal')
@section('judul','UPDATE BERHASIL')
@section('isi','Update berhasil, Pastikan admin memberikan data yang valid')


@endsection