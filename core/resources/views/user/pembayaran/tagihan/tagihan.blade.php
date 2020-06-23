@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Tagihan Anda')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
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
                foreach ($tagihans as $index => $tagihan) {?>
                    <tr>
                        <td>{{ ($index+1) }}</td>
                        <td style="min-width:100px;">{{ 'Kamar '.$tagihan->kamar()->nomor }}</td>
                        <td style="min-width:250px;">{{ $tagihan->tgl_awal_sewa.' s/d '.$tagihan->tgl_akhir_sewa }}</td>
                        <td style="min-width:150px;">{{ 'Rp. '.number_format($tagihan->kamar()->harga,0,'.','.') }}</td>
                        <td>{{ $tagihan->status_tagihan }}</td>
                        <?php
                        if($tagihan->status_tagihan == 'hutang')
                        {?>
                            <td>
                                <a href="{{ url('/pilihpembayaran',[Crypt::encryptString($tagihan->id)]) }}">
                                    <button class="btn btn-sm btn-info">Charge</button>
                                </a>
                            </td>
                        <?php
                        }
                        elseif($tagihan->status_tagihan == 'lunas')
                        {?>
                            <td>
                                <a>
                                    <button class="btn btn-sm btn-success">Struct</button>
                                </a>
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
@section('judul','Mark All Berhasil')
@section('isi','Mark All Berhasil Dilakukan')
@endsection