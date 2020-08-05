@extends('app_layout.admindashboard_layout')
@section('reportadmin',config('global.active'))
@section('header','Tagihan Users / Edit Tagihan')
@section('jumlah',$notification)

@section('content')
<div class="container-fluid p-0">
    <div class="jumbotron bg-dark p-2" id="searchengine" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
        <div class="row">
            <div class="col-md">
                <h3 class="text-center mt-3 mb-5">EDIT TAGIHAN</h3>
                    <form action="{{ url('/adminedittagihan',[$id]) }}" id="main_form" method="POST">
                    {{ csrf_field() }}
                    <div class="d-flex justify-content-center">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">USERNAME</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="text" class="w-100 bg-secondary" style=";outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" name="mulai" value="{{ $tagihan->user()->username }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required disabled>
                    </div>

                    <div class="d-flex justify-content-center mt-2">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">ID TAGIHAN</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="text" class="w-100 bg-secondary" style=";outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" name="mulai" value="{{ $tagihan->id }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required disabled>
                    </div>

                    <div class="d-flex justify-content-center mt-2">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">TIPE PEMBAYARAN</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="text" class="w-100 bg-secondary" style=";outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;" name="mulai" value="{{ $tagihan->tipe_pembayaran }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required disabled>
                    </div>

                    <div class="d-flex justify-content-center mt-2">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">TANGGAL MULAI SEWA TAGIHAN</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="date" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;cursor:pointer;" name="mulai" value="{{ $tagihan->tgl_awal_sewa }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required>
                    </div>
                    <div class="d-flex justify-content-center text-danger">
<?php
                    if($errors->has('mulai'))
                    {
                        echo $errors->first('mulai');
                    }
?>                  
                    </div>

                    <div class="d-flex justify-content-center mt-3">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">TANGGAL AKHIR SEWA TAGIHAN</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="date" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:400px;cursor:pointer;" name="akhir" value="{{ $tagihan->tgl_akhir_sewa }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required>
                    </div>
                    <div class="d-flex justify-content-center text-danger">
<?php
                    if($errors->has('akhir'))
                    {
                        echo $errors->first('akhir');
                    }
?>                  
                    </div>

                    <div class="d-flex justify-content-center mt-3">
                        <small class="m-0 text-left" style="width:400px;font-size:8pt;">NOMINAL TAGIHAN</small>
                    </div>
                    <div class="d-flex justify-content-center">
                    <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:30px;cursor:pointer;" value="Rp." disabled>
                    <input type="text" class="w-100" style="background:none;outline:none;border:none;border-bottom:1px solid white;font-size:15pt;max-width:370px;" name="harga" value="{{ $tagihan->nominal_pembayaran }}" autocorrect="off" autocapitalize="none" minlength="4" maxlength="50" required id="uang">
                    </div>
                    <div class="d-flex justify-content-center text-danger">
<?php
                    if($errors->has('harga'))
                    {
                        echo $errors->first('harga');
                    }
?>                  
                    </div>

                    <div class="d-flex justify-content-center mb-5">
                    <div style="width:400px;" class="d-flex justify-content-around">
                    <a href="{{ url('/admintagihan') }}" class="btn btn-sm mt-5 bg-danger text-light">CANCEL</a>
                    <button type="button" id="sub" class="btn btn-sm mt-5" style="{{ config('global.active') }}">SUBMIT</button>
                    </div>
                    </div>
                    </form>

            </div>
        </div>
    </div>
</div>


@endsection
@extends('app_layout/modal')
@section('judul','PERINGATAN ADMIN (IMPORTANT)')
@section('isi')
<p class="text-dark"><b class="text-dark">SALAM ADMIN,</b> <br> Berikut ini merupakan efek peringatan yang akan terjadi apabila admin melakukan perubahan terhadap tagihan user.</p>
    <ul>
        <li class="text-dark">Apabila admin mengubah tanggal awal sewa dan tanggal akhir sewa pastikan admin untuk selalu melihat tipe pembayaran user tersebut (bulan atau tahun).</li>
        <li class="text-dark">Pengubahan Tanggal akan mempengaruhi sistem auto bill sistem. Tagihan selanjutnya akan dilakukan setelah <b class="text-dark">Tanggal Akhir</b> yang akan admin inputkan sekarang</li>
        <li class="text-dark">Tanggal yang akan tercantum pada tagihan selanjutnya apabila admin melakukan edit pada tanggal adalah sebagai berikut</li>
                    <ul class="mb-2">
                        <li class="text-dark">Tanggal awal tagihan selanjutnya merupakan tanggal akhir hasil dari edit admin yang akan admin inputkan</li>
                        <li class="text-dark">Sedangkan tanggal akhir sewanya bukanlah tanggal akhir terbaru yang akan admin inputkan sekarang ditambah satu bulan atau satu tahun, melainkan tanggal pertama user masuk kost yang dijadikan patokan untuk pembayaran selanjutnya</li>
                        <li class="text-dark">Apabila admin ingin mengganti tanggal awal masuk kost user maka dapat dilakukan pada halaman kamar user tersebut</li>
                    </ul>
        <li class="text-dark">Sistem hanya akan memvalidasi supaya tanggal awal lebih awal dari pada tanggal akhir sewa, jadi pastikan user bulan mendapatkan sewa sebulan dan user yang menyewa setahun mendapatkan sewa setahun</li>
        <li class="text-dark">Apabila tagihan yang diedit <b class="text-dark">(WALAU TIDAK ADA YANG BERUBAH SAAT DI EDIT)</b> telah memiliki sebuah <b class="text-dark">CHARGE TRANSAKSI</b> baik dengan integrasi midtrans atau manual, maka semua transaksi tersebut akan dibatalkan dan tidak dapat dilanjutkan oleh user</li>
        <li class="text-dark">Apabila tagihan telah dibayar oleh user, aktifitas edit tidak dapat dilakukan</li>
        <li class="text-danger"> <b class="text-danger"> Apabila user memiliki lebih dari satu tagihan (pernah berhutang / telat bayar hingga tagihan selanjutnya keluar) mengedit tagihan tidak akan dapat dilakukan karena dapat menyebabkan tumpang tindih pada sistem</b></li>
        <li class="text-dark">Apabila terjadi bug mohon untuk segera memberikan laporan</li>
    </ul>
<p class="text-dark"><b class="text-dark">TERIMAKASI ADMIN,</b> <br> Demi keamanan, untuk melanjutkan tindakan ini admin diharuskan memasukkan password aktif admin</p>
    <div class="d-flex flex-column">
    <h5 class="text-bold text-dark">PASSWORD</h5>
    <input type="password" class="form-controll text-dark" placeholder="PASSWORD ADMIN" form="main_form" name="password" required>
    <input type="submit" class="btn-info btn mt-3" value="LANJUTKAN" style="position:relative;transform:translateX(-50%);left:50%;" form="main_form">
    </div>
@endsection

@extends('app_layout/modal_denied')
@section('modal_denied_judul','GAGAL')
@section('modal_denied_isi','Pastikan admin memberikan password serta input yang benar, pastikan pula status tagihan belum dibayar oleh user dan user hanya memiliki satu buah tagihan hutang admin hanya dapat mengedit tagihan terbaru untuk mencegah tumpang tindih')

@section('tambahanbawah')
<script src="{{ asset('vendor_app/jQuery_mask/dist/jquery.mask.min.js') }}"></script>
<script>
$('#uang').mask('000.000.000.000.000', {reverse: true});

    document.addEventListener('DOMContentLoaded', (ev)=>{
        let tombol = document.getElementById("sub");

        tombol.addEventListener('click',(ev)=>{
        $('#modal').modal('show');
    })
    })
</script>
@endsection