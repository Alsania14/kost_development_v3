@extends('app_layout.admindashboard_layout')
@section('reportadmin',config('global.active'))
@section('header','Tagihan Users')
@section('jumlah',$notification)

@section('content')
<div class="container-fluid p-0">
    <div class="jumbotron bg-dark p-0" id="searchengine" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
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
                <form action="{{ url('/admintagihan') }}" method="GET" onsubmit="disablednull()">
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
                <label>NOMOR KAMAR</label>
                <input id="input2" type="text" name="nomor_kamar" class="form-control"
<?php
                if(isset($input['nomor_kamar']))
                {
?>
                value="{{ $input['nomor_kamar']}}"
<?php
                }
?>
                >
            </div>
            <div class="col-md-3">
                <label>TIPE</label>
                <select name="tipe" id="input3" class="form-control">
<?php
                if(isset($input['tipe']))
                {
                    if($input['tipe'] == 'bulan')
                    {
?>
                    <option value=""></option>
                    <option value="bulan" class="text-dark" selected>BULAN</option>
                    <option value="tahun" class="text-dark">TAHUN</option>
<?php
                    }
                    else
                    {
?>
                    <option value=""></option>
                    <option value="bulan" class="text-dark">BULAN</option>
                    <option value="tahun" class="text-dark" selected>TAHUN</option>
<?php

                    }
                }
                else
                {
?>
                    <option value=""></option>
                    <option value="bulan" class="text-dark">BULAN</option>
                    <option value="tahun" class="text-dark">TAHUN</option>
<?php
                }
?>                
                </select>
            </div>
            <div class="col-md-3">
                <label>STATUS TAGIHAN</label>
                <select name="status_tagihan" id="input4" class="form-control">
                <?php
                if(isset($input['status_tagihan']))
                {
                    if($input['status_tagihan'] == 'hutang')
                    {
?>
                    <option value=""></option>
                    <option value="hutang" class="text-dark" selected>HUTANG</option>
                    <option value="lunas" class="text-dark">LUNAS</option>
<?php
                    }
                    else
                    {
?>
                    <option value=""></option>
                    <option value="hutang" class="text-dark">HUTANG</option>
                    <option value="lunas" class="text-dark" selected>LUNAS</option>
<?php

                    }
                }
                else
                {
?>
                    <option value=""></option>
                    <option value="hutang" class="text-dark">HUTANG</option>
                    <option value="lunas" class="text-dark">LUNAS</option>
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
    <div class="jumbotron bg-dark pt-5" style="border-top:3px solid orange;">
    <h3 class="text-center">TAGIHAN</h3>
    {{ $tagihans->appends($input)->links() }}
    <div class="table-responsive">
      <table class="table table-striped table-sm text-light" style="border-bottom:3px solid #e39414">
          <thead style="{{ config('global.active') }}">
            <tr>
              <th>Nomor</th>
              <th style="min-width:120px;">Username</th>
              <th style="min-width:50px;">ID Tagihan</th>
              <th style="min-width:100px;">Kamar</th>
              <th style="min-width:100px;">Tgl Pembayaran</th>
              <th style="min-width:100px;">Tipe</th>
              <th style="min-width:100px;">Status Tagihan</th>
              <th style="min-width:100px;">Generate By</th>
              <th style="min-width:200px;">Aksi</th>
            </tr>
          </thead>
          <tbody>
<?php
    foreach ($tagihans as $index => $tagihan) {
        $id = Crypt::encryptString($tagihan->id);
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
                <td>{{ $tagihan->user()->username }}</td>
                <td>{{ $tagihan->id }}</td>
                <td>Kamar {{ $tagihan->nomor_kamar }}</td>
                <td>{!! $tagihan->tgl_awal_sewa.' <b>s/d</b> '.$tagihan->tgl_akhir_sewa !!}</td>
                <td>{{ $tagihan->tipe_pembayaran }}</td>
<?php
                if($tagihan->status_tagihan == 'hutang')
                {
?>
                <td class="text-center"><div class="badge bg-danger text-light" style="font-size:12pt;">{{ $tagihan->status_tagihan }}</div></td>
<?php

                }
                elseif($tagihan->status_tagihan == 'lunas')
                {
?>
                <td class="text-center"><div class="badge bg-success text-light" style="font-size:12pt;">{{ $tagihan->status_tagihan }}</div></td>
<?php
                }
?>
                <td>{{ strtoupper($tagihan->created_by) }}</td>
                <td style="d-flex justify-content-center">
                
<?php
                if($tagihan->status_tagihan ==  'hutang')
                {
?>
                <a href="{{ url('/adminedittagihan',[$id]) }}">
                    <label class="btn btn-sm btn-info">EDIT TAGIHAN</label>
                </a>

                <label id="label_peringatan" class="btn btn-sm btn-danger" onclick="peringatan({{ $index }})">TARIK TAGIHAN</label>
                <form action="{{ url('/admintariktagihan',[$id]) }}" id="form_{{ $index }}" method="POST" style="display:none;">
                    {{ csrf_field() }}
                </form>
<?php
                }
                elseif($tagihan->status_tagihan ==  'lunas')
                {
?>
                <label class="btn btn-sm btn-secondary" disabled>EDIT TAGIHAN</label>
                <label id="label_peringatan" class="btn btn-sm btn-secondary" disabled>TARIK TAGIHAN</label>
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
</div>
@endsection

@section('tambahanbawah')
<script>
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

function peringatan(id)
{   
    $('#modal_lanjutkan_1').attr('form', 'form_'+id);
    $('#modal_lanjutkan_2').attr('form', 'form_'+id);
    $('#modal').modal('show');
}

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
@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN')
@section('isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan penarikan tagihan.</p>
    <ul>
        <li class="text-dark">Apabila admin menarik tagihan yang telah dibentuk dan user telah membuat sebuah <b class="text-dark">CHARGE</b> dengan menggunakan integrasi midtrans, maka sistem akan menarik semua transaksi hasil <b class="text-dark">CHARGE</b> user dari tagihan tersebut. User tidak dapat mengakses VA / CODE BILL yang telah dibuat.</li>
        <li class="text-dark">Menarik tagihan yang dilakukan menggunakan sistem pembayaran manual tidak memerlukan request ke pihak midtrans, namun apabila pembayar sudah membayar dan admin melakukan pembatalan maka permasalahan harap diselesaikan dengan user dari pihak admin sendiri</li>
        <li class="text-dark">Tagihan yang telah ditarik admin <b class="text-dark">tidak dapat </b> dikembalikan kembali</li>
        <li class="text-dark">Apabila admin ingin mematikan fitur auto bill aplikasi dapat dilakukan pada halaman sistem</li>
        <li class="text-dark">Apabila terjadi bug mohon untuk segera memberikan laporan</li>
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
@section('modal_denied_isi','SOMETHING WRONG')