@extends('app_layout.admindashboard_layout')
@section('jumlah',$notification)
@section('reportadmin',config('global.active'))
@section('header','Report User \ Validasi Transaksi User')
@section('content')
<div class="container-fluid p-0">
<div class="jumbotron bg-dark p-0 mb-5" id="searchengine" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
    <div class="row">
        <div class="col-md">
            <div class="d-flex justify-content-end">
                <button class="badge" style="background:orange;height:30px;" id="open">OPEN</button>
                <button class="badge" style="background:orange;height:30px;" id="minimize" >MINIMIZE</button>
            </div>
            <h3 class="text-center">SEARCH ENGINE</h3>
        </div>
    </div>
    
    <div class="row p-4 mt-4">
            <div class="col-md-3">
                <form action="{{ url('/adminvalidasitransaksi') }}" method="GET" onsubmit="disablednull()">
                <label>USERNAME</label>
                <input id="input1" type="text" name="user" class="form-control"
<?php
                if(isset($input['user']))
                {
?>
                value="{{ $input['user']}}"
<?php
                }
?>
                >
            </div>
            <div class="col-md-3">
                <label>TAGIHAN ID</label>
                <input id="input2" type="text" name="tagihan_id" class="form-control"
<?php
                if(isset($input['tagihan_id']))
                {
?>
                value="{{ $input['tagihan_id']}}"
<?php
                }
?>
                >
            </div>
            <div class="col-md-3">
                <label>BUKTI TRANSAKSI</label>
                <select name="bukti" id="input3" class="form-control">
<?php
                if(isset($input['bukti']))
                {
                    if($input['bukti'] == 'dikirim')
                    {
?>
                    <option value=""></option>
                    <option value="dikirim" class="text-dark" selected>DIKIRIM</option>
                    <option value="tidak_dikirim" class="text-dark">BELUM DIKIRIM</option>
<?php
                    }
                    else
                    {
?>
                    <option value=""></option>
                    <option value="dikirim" class="text-dark">DIKIRIM</option>
                    <option value="tidak_dikirim" class="text-dark" selected>BELUM DIKIRIM</option>
<?php

                    }
                }
                else
                {
?>
                    <option value=""></option>
                    <option value="dikirim" class="text-dark">DIKIRIM</option>
                    <option value="tidak_dikirim" class="text-dark">BELUM DIKIRIM</option>
<?php
                }
?>                
                </select>
            </div>
            <div class="col-md-3">
                <label>STATUS TRANSAKSI</label>
                <select name="status_pembayaran" id="input4" class="form-control">
                <?php
                if(isset($input['status_pembayaran']))
                {
                    if($input['status_pembayaran'] == 'proses')
                    {
?>
                    <option value=""></option>
                    <option value="proses" class="text-dark" selected>PROSES</option>
                    <option value="pending" class="text-dark">PENDING</option>
                    <option value="approved" class="text-dark">APPROVED</option>
                    <option value="expired" class="text-dark">EXPIRED</option>
<?php
                    }
                    elseif($input['status_pembayaran'] == 'pending')
                    {
?>
                    <option value=""></option>
                    <option value="proses" class="text-dark">PROSES</option>
                    <option value="pending" class="text-dark" selected>PENDING</option>
                    <option value="approved" class="text-dark">APPROVED</option>
                    <option value="expired" class="text-dark">EXPIRED</option>
<?php
                    }
                    elseif($input['status_pembayaran'] == 'approved')
                    {
?>
                    <option value=""></option>
                    <option value="proses" class="text-dark">PROSES</option>
                    <option value="pending" class="text-dark">PENDING</option>
                    <option value="approved" class="text-dark" selected>APPROVED</option>
                    <option value="expired" class="text-dark">EXPIRED</option>
<?php
                    }
                    elseif($input['status_pembayaran'] == 'expired')
                    {
?>
                    <option value=""></option>
                    <option value="proses" class="text-dark">PROSES</option>
                    <option value="pending" class="text-dark">PENDING</option>
                    <option value="approved" class="text-dark">APPROVED</option>
                    <option value="expired" class="text-dark" selected>EXPIRED</option>
<?php
                    }
                }
                else
                {
?>
                    <option value=""></option>
                    <option value="proses" class="text-dark">PROSES</option>
                    <option value="pending" class="text-dark">PENDING</option>
                    <option value="approved" class="text-dark">EXPIRED</option>
                    <option value="expired" class="text-dark">APPROVED</option>
<?php
                }
?>
                </select>
            </div>
    </div>
    <div class="row">
        <div class="col-md">
            <div class="d-flex justify-content-center m-3">
                <button class="btn btn-info text-dark font-weight-bold" type="submit"  style="{{ config('global.active') }}min-width:200px;">SEARCH</button>
            </div>
        </div>
    </div>
    </div>
    </form>



    <div class="jumbotron bg-dark" id="searchengine" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
    <div class="row">
        <div class="col-md">
            <h3 class="text-center mb-5">TRANSAKSI MANUAL</h3>
            {{ $transaksis->links() }}
            <div class="table-responsive">
                <table class="table table-striped table-sm text-light" style="border-bottom:3px solid #e39414">
                    <thead style="{{ config('global.active') }}">
                        <tr>
                        <th>Nomor</th>
                        <th style="min-width:120px;">Username</th>
                        <th style="min-width:100px;">Tagihan ID</th>
                        <th style="min-width:200px;">Nominal Pembayaran</th>
                        <th style="min-width:200px;">Order ID</th>
                        <th style="min-width:100px;">Kamar</th>
                        <th style="min-width:250px;">Tanggal Pembayaran</th>
                        <th style="min-width:100px;">Tipe</th>
                        <th style="min-width:100px;">Status Transaksi</th>
                        <th style="min-width:200px;">Bukti Transaksi</th>
                        <th style="min-width:300px;">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
<?php
                    foreach ($transaksis as $index => $transaksi)
                    {
                        $id = Crypt::encryptString($transaksi->id);
                        if(isset($_GET['page']))
                        {
                            if($_GET['page'] > 1 )
                            {
                                $index += (($_GET['page'] - 1) * 10) + 1;
                
                            }
                            else
                            {
                                $index+=1;
                            }    
                        }
                        else
                        {
                            $index+=1;
                        }
?>
                        <tr>
                            <td>{{ $index }}</td>
                            <td>{{ $transaksi->username }}</td>
                            <td>{{ $transaksi->tagihan_id }}</td>
                            <td>{{ 'Rp. '.number_format($transaksi->nominal_pembayaran,0,'.','.') }}</td>
                            <td>{{ $transaksi->order_id }}</td>
                            <td>{{ 'Kamar '.$transaksi->nomor_kamar }}</td>
                            <td>{!! $transaksi->tgl_awal.'<b> S/D </b>'.$transaksi->tgl_akir !!}</td>
                            <td>{{ $transaksi->tipe_pembayaran }}</td>
<?php
                            if($transaksi->status_pembayaran == 'approved')
                            {
?>
                            <td><div class="badge-pill bg-success">{{ strtoupper($transaksi->status_pembayaran) }}</div></td>
<?php
                            }
                            else
                            {
?>
                            <td>{{ strtoupper($transaksi->status_pembayaran) }}</td>
<?php
                            }

                            if($transaksi->bukti_transaksi != null)
                            {
?>
                            <td>
                                <a style="min-width:200px;" href="{{ url('/storage/bukti_pembayaran',[$transaksi->bukti_transaksi]) }}" target="_top" class="btn btn-info btn-sm">BUKTI PEMBAYARAN</a>
                            </td>
<?php
                            }
                            else
                            {
?>  
                            <td>
                                <a class="btn btn-secondary btn-sm" style="min-width:200px;">TIDAK ADA PEMBAYARAN</a>
                            </td>
<?php
                            }
                            if($transaksi->status_pembayaran == 'pending')
                            {
?>
                        <td >
                            <label onclick="peringatan({{ $index }})" style="width:100px;" class="btn btn-success btn-sm">VERIFIKASI</label>
                            <form action="{{ url('/adminverifikasitransaksi',[$id]) }}" method="POST" id="form_{{ $index }}" style="display:none;">
                                {{ csrf_field() }}
                            </form>

                            <a href="https://api.whatsapp.com/send?phone={{ $transaksi->nomor_hp }}" target="_blank">
                                <label class="btn-sm btn btn-primary">WA USER</label>
                            </a>

                            <label onclick="peringatan2({{ $index }})" style="width:100px;" class="btn btn-danger btn-sm">REJECT</label>
                            <form action="{{ url('/adminrejecttransaksi',[$id]) }}" method="POST" id="form_reject_{{ $index }}" style="display:none;">
                                {{ csrf_field() }}
                            </form>
                        </td>
<?php
                            }
                            elseif($transaksi->status_pembayaran == 'approved')
                            {
?>
                            <td >
                            <label style="width:100px;" class="btn btn-secondary btn-sm" disabled>VERIFIED</label>
                            <form action="{{ url('/adminverifikasitransaksi',[$id]) }}" method="POST" id="form_{{ $index }}" style="display:none;">
                                {{ csrf_field() }}
                            </form>

                            <a href="https://api.whatsapp.com/send?phone={{ $transaksi->nomor_hp }}" target="_blank">
                                <label class="btn-sm btn btn-primary">WA USER</label>
                            </a>

                            <label style="width:100px;" class="btn btn-secondary btn-sm" disabled>REJECT</label>
                            <form action="{{ url('/adminrejecttransaksi',[$id]) }}" method="POST" id="form_reject_{{ $index }}" style="display:none;">
                                {{ csrf_field() }}
                            </form>
                        </td>
<?php
                            }
                            else
                            {
?>
                        <td>
                            <label class="btn btn-secondary btn-sm" style="width:100px;">VERIFIKASI</label>
                            <label class="btn-sm btn btn-primary">WA USER</label>
                            <label onclick="peringatan2({{ $index }})" style="width:100px;" class="btn btn-danger btn-sm">REJECT</label>
                            <form action="{{ url('/adminrejecttransaksi',[$id]) }}" method="POST" id="form_reject_{{ $index }}" style="display:none;">
                                {{ csrf_field() }}
                            </form>
                        </td>
                        
<?php
                        }
                    }
?>                  
                        </tr>
                    </tbody>
            </div>
        </div>
    </div>
    </div>
</div>

@endsection


@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN')
@section('isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan VERIFIKASI atau REJECT.</p>
<p class="text-dark"><b class="text-dark">VERIFIKASI</b>
    <ul>
        <li class="text-dark">Lakukan <b class="text-dark">TRIPLE CHECKS</b> sebelum memverifikasi berkas user. Pertama lihat berkas yang dikirimkan oleh user, kedua tanyakan user apakah benar sudah mengirim bukti pembayaran dan yang terakhir cek saldo atau rekening admin sendiri</li>
        <li class="text-dark" class="text-dark">TRANSAKSI MANUAL yang telah diverifikasi oleh admin akan dinyatakan <b class="text-dark">SELESAI</b> oleh sistem dan tidak dapat dirubah kembali status pembayarannya,jadi pastikan uang yang dikirimkan users benar-benar sudah masuk ke dalam rekening admin</li>
        <li class="text-dark">Apabila Terjadi keanehan dan uang tidak masuk ke dalam rekening admin dimohon untuk berkomunikasi dengan users sebelum mereject transaksi</li>
        <li class="text-danger font-weight-bold">INGAT !! satu TAGIHAN dapat memiliki lebih dari satu CHARGE TRANSAKSI MANUAL, berdasarkan jumlah charge yang dilakukan user. Pastikan admin hanya memverifikasi satu transaksi dari satu TAGIHAN yang memang sudah benar - benar dibayar oleh user. Sistem tidak akan menghapus transaksi dengan ID TAGIHAN yang sama walaupun salah satu CHARGE TRANSAKSI manual TAGIHAN tersebut telah diverifikasi oleh admin. Admin dapat mereject CHARGE TRANSAKSI yang tidak digunakan tersebut secara manual</li>
        <li class="text-dark"> 
            Bila menemukan BUG tolong melapor
        </li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" id="modal_lanjutkan_1" placeholder="PASSWORD ADMIN" form="" name="password" required>
    <input type="submit" id="modal_lanjutkan_2" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="">
    </div>
@endsection

@extends('app_layout/modal_denied')
@section('modal_denied_judul','REJECT TRANSAKSI MANUAL')
@section('modal_denied_isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan REJECT.</p>
    <ul>
        <li class="text-dark">Pastikan Admin me-reject transaksi manual yang benar - benar tidak sesuai dengan kriteria pembayaran, seperti gambar kurang jelas, nominal pembayaran kurang, uang tidak masuk ke dalam rekening admin, keterlambatan pembayaran yang tidak dapat ditolerir dan pelanggaran yang telah di tetapkan oleh admin</li>
        <li class="text-dark">Transaksi yang telah di-REJECT tidak akan dapat dikembalikan.</li>
        <li class="text-dark">Untuk permasalahan yang tidak dapat diselesaikan melalui sistem mohon untuk menghubungi user melalui kontak user</li>
        <li class="text-dark">Lapor bila menemukan BUG</li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" id="modal_peringatan_1" placeholder="PASSWORD ADMIN" form="" name="password" required>
    <input type="submit" id="modal_peringatan_2" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="">
    </div>
@endsection

@extends('app_layout/modal_denied2')
@section('modal_denied2_judul','TERJADI KESALAHAN')
@section('modal_denied2_isi')
<p class="text-dark">
    Pastikan admin memberikan PASSWORD yang benar dan parameter pencarian yang sesuai !
</p>
@endsection

@extends('app_layout/modal2')
@section('judul2','SUCCESS')
@section('isi2')
<p class="text-dark">
    AKSI BERHASIL DILAKUKAN
</p>
@endsection

@section('tambahanbawah')
<script>
    function peringatan(id)
    {
        $('#modal_lanjutkan_1').attr('form', 'form_'+id);
        $('#modal_lanjutkan_2').attr('form', 'form_'+id);
        $('#modal').modal('show');
    }

    function peringatan2(id)
    {
        $('#modal_peringatan_1').attr('form', 'form_reject_'+id);
        $('#modal_peringatan_2').attr('form', 'form_reject_'+id);
        $('#modaldenied').modal('show');
        
    }


$('#minimize').on('click', function() {
  console.log('click');
  // use this instead of using .jumbotron again
  $('#searchengine').animate({
    maxHeight:"100px"
  }, 500);
});

$('#open').on('click', function() {
  console.log('open');
  // use this instead of using .jumbotron again
  $('#searchengine').animate({
    maxHeight:"500px"
  }, 500);
});

function disablednull()
{
    if(document.getElementById('input1').value == '')
    {
        document.getElementById('input1').disabled=true;
    }
    if(document.getElementById('input2').value == '')
    {
        document.getElementById('input2').disabled=true;
    }
    if(document.getElementById('input3').value == '')
    {
        document.getElementById('input3').disabled=true;
    }
    if(document.getElementById('input4').value == '')
    {
        document.getElementById('input4').disabled=true;
    }
}
</script>
@endsection

