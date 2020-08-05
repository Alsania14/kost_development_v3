@extends('app_layout/admindashboard_layout')
@section('notifikasi',config('global.active'))
@section('header','Notifikasi / Arsip Notifikasi')
@section('content')
<div class="container-fluid p-0">
    <div class="row mb-4 mr-1 justify-content-end">
    <div class="btn-group" role="group" aria-label="Basic example">
      <a href="javascript:history.back()" type="button" class="btn btn-primary">Kembali</a>
    </div>
    </div>
    
    <div class="row">
        <div class="col-md">
        
            <div class="jumbotron bg-dark p-0" style="border-top:3px solid orange;overflow:hidden;max-height:1000px;">
                
                <div class="row">
                    <div class="col-md">
                        <h3 class="text-center mt-5">SEARCH ENGINE</h3>
                    </div>                
                </div>

                    <div class="row p-4 mt-1">
                        <div class="col-md">
                            <form action="{{ url('/adminarsipnotifikasi') }}" method="GET" onsubmit="disablednull()">
                            <label>TYPE</label>
                            <select id="input1" type="text" name="type" class="form-control">
<?php
                            if(isset($input['type']))
                            {
                                if($input['type'] == 'common')
                                {
?>
                                    <option class="text-dark" value=""></option>
                                    <option class="text-dark" value="common" selected>COMMON</option>
                                    <option class="text-dark" value="special">SPECIAL</option>
<?php
                                }
                                else
                                {
?>
                                    <option class="text-dark" value=""></option>
                                    <option class="text-dark" value="common">COMMON</option>
                                    <option class="text-dark" value="special" selected>SPECIAL</option>
<?php
                                }
                            }
                            else
                            {
?>
                                    <option class="text-dark" value=""></option>
                                    <option class="text-dark" value="common">COMMON</option>
                                    <option class="text-dark" value="special">SPECIAL</option>
<?php
                            }
?>
                            </select>
                        </div>
                        <div class="col-md">
                            <label>DARI TANGGAL</label>
                            <input id="input2" type="date" name="tgl_awal" class="form-control"
<?php
                            if(isset($input['tgl_awal']))
                            {
?>
                             value="{{ $input['tgl_awal'] }}"
<?php
                            }
?>
                            >
                        </div>
                        <div class="col-md">
                            <label>SAMPAI TANGGAL</label>
                            <input id="input3" type="date" name="tgl_akhir" class="form-control"
<?php
                            if(isset($input['tgl_akhir']))
                            {
?>
                            value="{{ $input['tgl_akhir'] }}"
<?php
                            }
?>
                            >
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md mb-2">
                            <div class="d-flex justify-content-center m-3">
                                <button class="btn btn-info text-dark font-weight-bold" type="submit"  style="{{ config('global.active') }}min-width:200px;">SEARCH</button>
                            </div>
                        </div>
                    </div>
                    </form>


            </div>
        </div>
    </div>
                {{ $notifications->onEachSide(0)->appends($input)->links() }}
<?php
                foreach ($notifications as $index => $notif) {
?>
                <div class="list-group">
                <div class="list-group-item list-group-item-action flex-column align-items-start bg-dark"
<?php
                if($notif->full_data->type == 'special')
                {
                    echo 'style="'.config('global.active').'"';
                }
?>
                >
                    <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">{{ $notif->full_data->title }}</h5>
                    <small class="text-right">{{ $notif->created_at }}</small>
                    </div>
                    <p class="mb-4">{{ $notif->full_data->text }}</p>
                    <small class="mt-3">System Tirta Aruna Cottage</small>
                </div>
                </div>
<?php
                }
?>

</div>
<footer class="page-footer w-100 m-0 mt-5">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
</footer>


@extends('app_layout/modal')
@section('judul','Mark All Berhasil')
@section('isi','Mark All Berhasil Dilakukan')
@endsection

@section('tambahanbawah')
<script>
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
}
</script>
@endsection