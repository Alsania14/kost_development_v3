@extends('app_layout/dashboard_layout')
@section('username',strtoupper($user->username))
@section('room',$kamar->nomor)
@section('img_user',url('/storage/image_users',[$user->image]))
@section('pembayaran',config('global.active'))
@section('header','Pembayaran Kost \ Transaksi')
@section('content')
<!-- AWAL CONTAINER -->
<div class="container-fluid p-0" style="min-height:550px;">
<p class="text-info">Hai {{ $user->username }}, Halaman ini memuat semua transaksi anda</p>
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
                foreach ($transaksis as $index => $transaksi) {?>
                 <tr>
                    <td>{{ ($index+1) }}</td>
                    <td style="min-width:200px;">{{ $transaksi->order_id }}</td>
                    <td>{{ $transaksi->integration_name }}</td>
                    <td style="min-width:150px;">{{ 'Rp. '.number_format($transaksi->nominal,0,'.','.') }}</td>
                    <td>{{ $transaksi->status_pembayaran }}</td>
                    <td>

                    <?php 
                      if($transaksi->via = 'bank_transaksi')
                      {?>

                        <a href="{{ url('/bank_transfer',[Crypt::encryptString($transaksi->id)]) }}">
                          <button class="btn btn-info">Detail</button>
                        </a>
                        
                    <?php
                      }
                    ?>


                    
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
@section('judul','Charge Gagal')
@section('isi','Charge Berhasil Silahkan lanjutkan ke tahap selanjutnya')


@extends('app_layout/modal_denied')
@section('modal_denied_judul','Charge Gagal')
@section('modal_denied_isi','Mohon Maaf Charge gagal, kemungkinan sedang terjadi gangguan,  silahkan gunakan metode pembayaran yang lain atau hubungi developer')
@endsection