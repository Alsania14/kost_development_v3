@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('notifikasi',config('global.active'))
@section('header','Notifikasi')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
<form action="{{ url('/markall',[Crypt::encryptString($user->id)]) }}" method="POST">
{{ csrf_field() }}
{{ method_field('PATCH') }}
<button type="submit" class="btn btn-info mb-3">Mark as Read All</button>
</form>
<?php
    
    if(!($notif_model->all() == null))
    {
    foreach ($notif_model as $index => $notif) { ?>        
    
        <div class="list-group">
        <div class="list-group-item list-group-item-action flex-column align-items-start bg-dark"
            <?php
                if($notif->full_data->type == 'special')
                {
                    echo 'style="'.config('global.active').'"';
                }
            ?>
        >
            <div class="d-flex w-100 justify-content-between">
            <h5 class="mb-1">{{ $notif->full_data->title }}</h5>
            <small class="text-right">{{ $notif->created_at }}</small>
            </div>
            <p class="mb-4">{{ $notif->full_data->text }}.</p>
            <small class="mt-3">System Tirta Aruna Cottage</small>
        </div>
        </div>

<?php    }
    }
    else
    {?>
        <div class="row d-flex justify-content-center">
            <div class="col-md text-center">
                <img class="img" src="{{ asset('vendor_app/img_web/no_notifikasi.png') }}" style="max-height:400px;" alt="">
            </div>
        </div>
<?php
    }
?>
<!-- footer -->
</div>
<footer class="row page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
<!-- AKHIR CONTAINER -->
@extends('app_layout/modal')
@section('judul','Mark All Berhasil')
@section('isi','Mark All Berhasil Dilakukan')
@endsection