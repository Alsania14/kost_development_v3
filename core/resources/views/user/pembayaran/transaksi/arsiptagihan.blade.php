@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda \ Arsip Tagihan')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
<div class="row m-0 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="{{ url('/tagihan') }}" type="button" class="btn btn-primary">Kembali</a>
    </div>
  </div>
<p class="text-info">Hai {{ $user->username }}, Berikut ini merupakan arsip dari tagihan sebelumnya</p>
      <div class="table-responsive">
      <table class="table table-striped table-sm text-light" style="border-bottom:3px solid rgb(58,83,180);">
          <thead style="{{ config('global.arsip') }}">
            <tr>
              <th>Nomor</th>
              <th>Pembayaran</th>
              <th>Tanggal Sewa</th>
              <th>Harga</th>
              <th>Status Tagihan</th>
              <th>Aksi</th>
            </tr>
          </thead>
          <tbody>
<?php 
                foreach ($tagihans as $index => $tagihan) 
                {
                  $encrypt = Crypt::encryptString($tagihan->id);
?>
                    <tr>
                        <td>{{ ($index+1) }}</td>
                        <td style="min-width:100px;">{{ 'Kamar '.$tagihan->kamar()->nomor }}</td>
                        <td style="min-width:250px;">{{ $tagihan->tgl_awal_sewa.' s/d '.$tagihan->tgl_akhir_sewa }}</td>
                        <td style="min-width:150px;">{{ 'Rp. '.number_format($tagihan->nominal_pembayaran,0,'.','.') }}</td>
                        <td>{{ $tagihan->status_tagihan }}</td>
                            <td>
                                <a>
                                    <button class="btn btn-sm btn-success" style="display:inline-block;">Struct</button>
                                </a>
                                
                                <form action="{{ url('/keluarkanarsiptagihan',[$encrypt]) }}" class="m-0" style="display:inline-block;" method="POST">
                                  {{ csrf_field() }}
                                  {{ method_field('put') }}
                                  <input class="btn-sm btn-danger" type="submit" value="Keluarkan arsip">
                                </form>
                            </td>
                    </tr>
<?php
                }
?>
          
          </tbody>
        </table>
        </div>

</div>
<!--  AKHIR CONTAINER -- -->
<footer class="row page-footer w-100 m-0 pt-4">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>
@endsection