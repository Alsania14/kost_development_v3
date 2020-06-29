@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('jumlah',$notification)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
<div class="row m-0 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="{{ url('/dashboard') }}" type="button" class="btn btn-primary">Kembali</a>
      <a href="{{ url('/arsiptagihan') }}" type="button" class="btn btn-primary">Lihat Arsip</a>
    </div>
  </div>
<p class="text-info">Hai {{ $user->username }}, Jika belum memahami alur dan methode pembayaran, kamu dapat melihat halaman pedoman pembayaran pada menu pembayaran kost</p>
      <div class="table-responsive">
      <table class="table table-striped table-sm text-light" style="border-bottom:3px solid #e39414">
          <thead style="{{ config('global.active') }}">
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
                foreach ($tagihans as $index => $tagihan) {
                  $encrypt = Crypt::encryptString($tagihan->id);
?>
                    <tr>
                        <td>{{ ($index+1) }}</td>
                        <td style="min-width:100px;">{{ 'KAMAR '.$tagihan->nomor_kamar }}</td>
                        <td style="min-width:250px;">{{ $tagihan->tgl_awal_sewa.' s/d '.$tagihan->tgl_akhir_sewa }}</td>
                        <td style="min-width:150px;">{{ 'Rp. '.number_format($tagihan->nominal_pembayaran,0,'.','.') }}</td>
<?php
                        if($tagihan->status_tagihan == 'hutang')
                        {
?>                          
                        <td>BELUM LUNAS</td>
                        <td>
                                <a href="{{ url('/pilihpembayaran',[$encrypt]) }}">
                                    <button class="btn btn-sm btn-info">Charge</button>
                                </a>
                                <button class="btn btn-sm btn-secondary m-0" style="display:inline-block;" disabled>Struk</button>
                                <button class="btn btn-sm btn-secondary m-0" style="display:inline-block;" disabled>Arsip</button>
                        </td>
<?php
                        }
                        else
                        {
?>
                        <td>LUNAS</td>
                        <td>
                              <button class="btn btn-sm btn-secondary" disabled>Charge</button>
                              <form action="{{ url('/struk',[$encrypt]) }}" class="m-0 p-0" style="display:inline-block;" method="POST">
                                {{ csrf_field() }}
                                <button class="btn btn-sm btn-success m-0" type="submit" style="display:inline-block;">Struk</button>
                              </form>
                              <form action="{{ url('/arsiptagihan',[$encrypt]) }}" class="m-0 p-0" style="display:inline-block;" method="POST">
                                {{ csrf_field() }}
                                {{ method_field('put') }}
                                <button class="btn-sm btn-danger" type="submit">Arsip</button>
                              </form>
                        </td>
<?php
                        }
?>
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
@section('judul','Charge Berhasil')
@section('isi','Charge Berhasil Silahkan lanjutkan ke tahap selanjutnya')


@extends('app_layout/modal_denied')
@section('modal_denied_judul','Charge Gagal')
@section('modal_denied_isi','Mohon Maaf Charge gagal, kemungkinan sedang terjadi gangguan,  silahkan gunakan metode pembayaran yang lain atau hubungi developer')
@endsection