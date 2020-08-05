@extends('app_layout.admindashboard_layout')
@section('jumlah',$notification)
@section('adminpelaporan',config('global.active'))
@section('header','Report Admin \ Exporting Report')
@section('content')
<div class="container-fluid p-0">
<div class="jumbotron bg-dark p-0 mb-5" id="searchengine" style="border-top:3px solid orange;overflow:hidden;">
    <div class="row">
        <div class="col-md">
            <h3 class="text-center mt-3">PELAPORAN</h3>
        </div>
    </div>

    <div class="row">
        <div class="col-md">
            <div class="list-group mt-5 p-2 shadow-lg">
                
                
<?php              
                
                foreach ($laporans as $index => $laporan) {
                $id = Crypt::encryptString($laporan->id);
?>                 
                
                <div class="list-group-item list-group-item-action flex-column align-items-start bg-info shadow-lg">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">Laporan {{ $laporan->id }}</h5>
                    </div>

                </div>
                <div class="list-group-item list-group-item-action flex-column align-items-start bg-dark shadow-lg mb-3">
                    <div class="d-flex w-100 justify-content-between">
                    </div>
                    <h5>USER : {{ $laporan->user()->first()->username }}</h5>
                    <p class="mb-3">{{ $laporan->created_at }}</p>
                    <p class="mb-3 bg-light text-dark">{{ $laporan->keluhan }}</p>
                    
                    <p class="mb-3">RESPON ADMIN</p>
                    <p class="mb-3 bg-light text-dark">{{ $laporan->respon }}</p>
<?php
                    if($laporan->status_keluhan == 'terkirim')
                    {
?>
                        <p class="mb-1">STATUS KELUHAN SAAT INI : DITERIMA ADMIN</p>
                        <button class="btn btn-sm btn-warning" onclick="peringatan2({{ $index }})">TANGANI & TANGGAPI</button>
                        <form action="{{ url('/admintanggapan',[$id]) }}" style="display:none;" method="POST" id="form_tanggapan_{{ $index }}">
                            {{ csrf_field() }}
                        </form>
<?php
                    }
                    elseif($laporan->status_keluhan == 'proses')
                    {
?>
                        <p class="mb-1">STATUS KELUHAN SAAT INI : DIPROSES ADMIN</p>
                        <button class="btn btn-sm btn-warning" onclick="peringatan2({{ $index }})">ULANG MENANGGAPI</button>
                        <form action="{{ url('/admintanggapan',[$id]) }}" style="display:none;" method="POST" id="form_tanggapan_{{ $index }}" >
                            {{ csrf_field() }}
                        </form>
<?php
                    }
                    elseif($laporan->status_keluhan == 'selesai')
                    {
?>
                        <p class="mb-1">STATUS KELUHAN SAAT INI : SELESAI </p>
                        <button class="btn btn-sm btn-secondary" disabled>TANGANI & TANGGAPI</button>
<?php
                    }
?>
<?php
                    if($laporan->image_keluhan != null)
                    {
?>
                    <a href="{{ url('storage/image_pelaporan',[$laporan->image_keluhan]) }}" target="_blank">
                        <button class="btn btn-sm btn-info" style="width:180px;">GAMBAR</button>
                    </a>
<?php
                    }
                    else
                    {
?>
                    <button class="btn btn-sm btn-secondary" style="width:180px;" disabled>TIDAK DISERTAI GAMBAR</button>                  
<?php
                }
?>  
                    <a href="https://api.whatsapp.com/send?phone={{ $laporan->user()->first()->nomor_hp }}" target="_blank">
                                <button class="btn-sm btn btn-primary">WA USER</button>
                    </a>

                    <button class="btn-danger btn btn-sm" onclick="peringatan({{$index}})">HAPUS</button>
                    <form action="{{ url('/adminhapuslaporan',[$id]) }}" method="POST" id="form_{{ $index }}" style="display:none;">
                    {{ csrf_field() }}
                    {{ method_field('PUT') }}
                    </form>
                    
                </div>
<?php
                }
?>
                
            </div>
        </div>
    </div>
</div>
</div>
@endsection


@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN')
@section('isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan HAPUS LAPORAN.</p>
    <ul>
        <li class="text-dark">Pastikan admin menghapus laporan yang telah selesai diproses (supaya tidak memenuhi halaman) atau laporan yang memang tidak termasuk tanggung jawab admin dan laporan yang tidak sesuai dengan ketentuan yang telah ditetapkan admin</li>
        <li class="text-dark">Laporan yang telah dihapus tidak akan dapat dikembalikan</li>
        <li class="text-dark">Laporan yang dihapus akan hilang dari halaman pelaporan user</li>
        <li class="text-dark">Lapor bila menemukan BUG</li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" id="modal_peringatan_1" placeholder="PASSWORD ADMIN" form="" name="password" required>
    <input type="submit" id="modal_peringatan_2" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="">
    </div>
@endsection

@extends('app_layout/modal_denied')
@section('modal_denied_judul','GAGAL')
@section('modal_denied_isi')
PATIKAN ADMIN MEMBERIKAN PASSWORD YANG BENAR, DAN MEMBERIKAN INPUT RESPON
@endsection

@extends('app_layout/modal_denied2')
@section('modal_denied2_judul','PERINGATAN ADMIN')
@section('modal_denied2_isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan peringatan efek apa yang akan terjadi pada sistem apabila admin melakukan TANGANI DAN TANGGAPAN.</p>
    <ul>
        <li class="text-dark">Memberikan tanggapan maka status dari LAPORAN akan berubah menjadi proses</li>
        <li class="text-dark">Apabila laporan merupakan diluar tanggung jawab admin maka admin dapat chat user terlebih dahulu untuk memberikan penjelasan dan menghapus laporan setelahnya</li>
        <li class="text-dark">Admin diharuskan memberikan respon kepada user saat menangani laporan</li>
        <li class="text-dark">Notifikasi akan ditambahkan kepada user</li>
        <li class="text-dark">Lapor bila menemukan BUG</li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">RESPON ADMIN</h5>
    <input type="text" class="form-controll text-dark" id="modal_tanggapan_1" placeholder="RESPON" form="" name="respon" minlength="4" maxlength="200" required>
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" id="modal_tanggapan_2" placeholder="PASSWORD ADMIN" form="" name="password" required>
    <input type="submit" id="modal_tanggapan_3" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="">
    </div>
@endsection

@extends('app_layout/modal2')
@section('judul2','SUCCESS')
@section('isi2')
@endsection

@section('tambahanbawah')
<script>
function peringatan(id)
    {
        $('#modal_peringatan_1').attr('form', 'form_'+id);
        $('#modal_peringatan_2').attr('form', 'form_'+id);
        $('#modal').modal('show');
    }

function peringatan2(id)
    {
        $('#modal_tanggapan_1').attr('form', 'form_tanggapan_'+id);
        $('#modal_tanggapan_2').attr('form', 'form_tanggapan_'+id);
        $('#modal_tanggapan_3').attr('form', 'form_tanggapan_'+id);
        $('#modaldenied2').modal('show');
    }
</script>
@endsection

