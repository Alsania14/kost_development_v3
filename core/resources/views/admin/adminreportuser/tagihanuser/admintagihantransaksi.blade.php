@extends('app_layout.admindashboard_layout')
@section('reportadmin',config('global.active'))
@section('header','Tagihan Users / Transaksi')
@section('jumlah',$notification)

@section('content')
<div class="container-fluid p-0">
    <div class="row mb-4 mr-1 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="javascript:history.back()" type="button" class="btn btn-primary">Kembali</a>
    </div>
    </div>
  
    <div class="jumbotron bg-dark p-0" id="searchengine" style="border-top:3px solid orange;overflow:hidden;">
    <div class="row">
        <div class="col-md mt-4">
            <h3 class="text-center">TRANSAKSI TAGIHAN</h3>
            <p class="text-center text-info">Satu tagihan dapat memiliki lebih dari satu transaksi, sesuai dengan jumlah <b class="text-info">CHARGE</b> yang dilakukan user</p>
        </div>
    </div>

    <div class="row m-0 ml-3">
        <table>
            <tr>
                <th style="min-width:160px;">TRANSAKSI TAGIHAN</th>
                <td>: {{ $tagihan->user()->username }}</td>
            </tr>
            <tr>
                <th>BANYAK CHARGE</th>
                <td>: {{$transaksis->count()}}</td>
            </tr>
            <tr>
                <th>PEMBAYARAN KAMAR</th>
                <td>: NOMOR {{ $tagihan->nomor_kamar }}</td>
            </tr>
            <tr>
                <th>TANGGAL AWAL SEWA</th>
                <td>: {{ $tagihan->tgl_awal_sewa }}</td>
            </tr>
            <tr>
                <th>TANGGAL AKHIR SEWA</th>
                <td>: {{ $tagihan->tgl_akhir_sewa }} </td>
            </tr>
            <tr>
                <th>TIPE</th>
                <td>: {{ strtoupper($tagihan->tipe_pembayaran) }} </td>
            </tr>
            <tr>
                <th>NOMINAL TAGIHAN</th>
                <td>: Rp. {{ number_format($tagihan->nominal_pembayaran,0,'.','.') }}</td>
            </tr>
        </table>
    </div>

    <div class="row p-3">
        <div class="col-md mt-4">
            <div class="table-responsive">
            <table class="table table-striped table-sm text-light" style="border-bottom:3px solid #e39414">
                <thead style="{{ config('global.active') }}">
                <tr>
                <th>Nomor</th>
                <th style="min-width:200px;">Order ID</th>
                <th style="min-width:100px;">Methode</th>
                <th style="min-width:100px;">Bukti Transaksi</th>
                <th style="min-width:100px;">VA CODE</th>
                <th style="min-width:100px;">BILL CODE</th>
                <th style="min-width:100px;">Status Pembayaran</th>
                <th style="min-width:200px;">Aksi</th>
                </tr>
            </thead>
            <tbody>
<?php
                foreach ($transaksis as $index => $transaksi)
                {
                $id=Crypt::encryptString($transaksi->id);
?>
                    <tr>
                        <td>{{ ($index+1) }}</td>
                        <td>{{ $transaksi->order_id }}</td>
                        <td>{{ $transaksi->integration_name }}</td>
<?php
                    if($transaksi->bukti_transaksi != null)
                    {
?>
                        <td><a class="btn btn-info btn-sm" href="{{ url('storage/bukti_pembayaran',[$transaksi->bukti_transaksi]) }}">LIHAT BUKTI</a></td>
<?php

                    }
                    else
                    {
?>
                        <td></td>
<?php
                    }
?>
                        <td>{{ $transaksi->field_1 }}</td>
                        <td>{{ $transaksi->field_2 }}</td>
                        <td>{{ $transaksi->status_pembayaran }}</td>
                        <td>
<?php
                        if($transaksi->status_pembayaran != "approved" && $transaksi->status_pembayaran != "rejected" && $transaksi->status_pembayaran != "expired")
                        {
?>
                        <label class="btn btn-sm btn-danger" onclick="peringatan({{ $index }})">REJECT</label>
                        <form action="{{ url('/adminrejecttransaksi',[$id]) }}" style="display:none;" method="POST" id="form_{{ $index }}">
                            {{ csrf_field() }}
                        </form>
                        </td>
<?php
                        }
                        else
                        {
?>
                        <a class="btn btn-sm bg-secondary">REJECT</a>
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
    </div>

    
    </div>
</div>
@endsection

@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN')
@section('isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan reject charge transaksi.</p>
    <ul>
        <li class="text-dark"><b class="text-dark">CHARGE TRANSAKSI</b> yang telah ditarik tidak dapat dikembalikan</li>
        <li class="text-dark">Sistem akan merequest pembatalan transaksi ke midtrans apabila menggunakan <b class="text-dark">CHARGE TRANSAKSI</b> menggunakan integrasi midtrans</li>
        <li class="text-dark"><b class="text-dark">CHARGE TRANSAKSI MANUAL</b> akan langsung dibatalkan tanpa perlu request ke midtrans</li>
        <li class="text-dark">User tidak dapat melanjutkan <b class="text-dark">CHARGE TRANSAKSI</b> yang dibatalkan</li>
        <li class="text-dark">Lapor bila mendapatkan BUG</li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" id="modal_lanjutkan_1" placeholder="PASSWORD ADMIN" form="" name="password" required>
    <input type="submit" id="modal_lanjutkan_2" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="">
    </div>
@endsection

@extends('app_layout/modal_denied')
@section('modal_denied_judul','GAGAL')
@section('modal_denied_isi')
                pastikdan admin memberikan password aktif yang benar, dan juga status CHARGE TRANSAKSI belum dibayar oleh user
@endsection

@section('tambahanbawah')
<script>
    function peringatan(index)
    {   
        console.log('form_'+index);
        $('#modal_lanjutkan_1').attr('form', 'form_'+index);
        $('#modal_lanjutkan_2').attr('form', 'form_'+index);
        $('#modal').modal('show');
    }
</script>
@endsection