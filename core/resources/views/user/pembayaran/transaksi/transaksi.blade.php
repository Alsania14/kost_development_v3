@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Transaksi')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
  <div class="row m-0 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="{{ url('/dashboard') }}" type="button" class="btn btn-primary">Kembali</a>
      <a href="{{ url('/arsiptransaksi') }}" type="button" class="btn btn-primary">Lihat Arsip</a>
    </div>
  </div>
<p class="text-info mt-1">Hai {{ $user->username }}, Halaman ini memuat semua transaksi anda</p>
      <div class="table-responsive">
      <table class="table table-striped table-sm text-light" style="border-bottom:3px solid #e39414">
          <thead style="{{ config('global.active') }}">
            <tr>
              <th>Nomor</th>
              <th>Order ID</th>
              <th>Metode</th>
              <th>Total</th>
              <th>Status Transaksi</th>
              <th>Aksi</th>
            </tr>
          </thead>
          <tbody>
<?php
                foreach ($transaksis as $index => $transaksi) {
?>
                 <tr>
                    <td>{{ ($index+1) }}</td>
                    <td style="min-width:200px;">{{ $transaksi->order_id }}</td>
                    <td>{{ strtoupper($transaksi->integration_name) }}</td>
                    <td style="min-width:150px;">{{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }}</td>
                    <td>{{ strtoupper($transaksi->status_pembayaran) }}</td>
                    <td>

<?php 
                      $encrypt = Crypt::encryptString($transaksi->id);
                      if($transaksi->via == 'bank_transfer')
                      {
?>

                        <a href="{{ url('/bank_transfer',[$encrypt]) }}">
                          <button class="btn-sm btn-info" style="display:inline-block;">Detail Bank Transfer</button>
                        </a>
<?php
                      }
                      elseif($transaksi->via == 'kedai')
                      {
?>
                        <a href="{{ url('/kedai',[$encrypt]) }}">
                          <button class="btn-sm btn-info" style="display:inline-block;">Detail Toko Transfer</button>
                        </a>
<?php
                      }
                      elseif($transaksi->via == 'manual')
                      {
?>
                        <a href="{{ url('/manual',[$encrypt]) }}">
                          <button class="btn-sm btn-info" style="display:inline-block;">Detail Manual Transfer</button>
                        </a>
<?php
                      }
?>
                        <form action="{{ url('/refresh',[$encrypt]) }}" class="m-0" style="display:inline-block;" method="POST">
                          {{ csrf_field() }}
                          {{ method_field('PUT') }}
<?php
                            if($transaksi->status_pembayaran == 'approved')
                            {
?>
                                  <input class="btn-sm btn-secondary" type="submit" value="Refresh" disabled>
<?php
                            }
                            else
                            {
?>
                                  <input class="btn-sm btn-primary" type="submit" value="Refresh">
<?php
                            }
?>
                          </form>
                          <form action="{{ url('/arsiptransaksi',[$encrypt]) }}" class="m-0" style="display:inline-block;" method="POST">
                            {{ csrf_field() }}
                            {{ method_field('put') }}
                            <input class="btn-sm btn-danger" type="submit" value="Arsip">
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
@extends('app_layout/modal')
@section('judul','Refresh Berhasil')
@section('isi','Refresh Berhasil !')

@extends('app_layout/modal_denied')
@section('modal_denied_judul','Refresh Gagal')
@section('modal_denied_isi','Mohon Maaf Refresh gagal, kemungkinan sedang terjadi gangguan atau masalah jaringan, Silahkan buat charge baru atau laporkan kepada developer')
@endsection