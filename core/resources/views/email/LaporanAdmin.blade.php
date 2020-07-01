@extends('email/email_layout')
@section('content')
<h4>SUBJECT : LAPORAN KELUHAN KERUSAKAN PROPERTI</h4>
<h4>Hai Admin,</h4>
<p>Berikut ini merupakan keluhan kerusakan properti yang dikirimkan oleh user kost. Berikut sistem berikan informasinya</p>
<p>PENGIRIM : {{ $data['name'] }} <br></p>
<p>KAMAR : {{ $data['kamar'] }} <br></p>
<p>KELUHAN : <br></p>
<p>{{ $data['keluhan'] }}</p>

<a href="{{ url('storage/image_pelaporan',[$data['image']]) }}">
<img src="{{ url('storage/image_pelaporan',[$data['image']]) }}" alt="LAPORAN TIDAK DISERTAKAN GAMBAR" style="max-height:200px;">
</a>
<p>KLIK GAMBAR UNTUK PERBESAR</p>

<p>Sekian saja laporan dari sistem, mohon untuk segera dibalas laporan dari user, saat admin membalas sistem akan mengirimkan email ke user secara real time</p>

<p><b>BIG REGRADS</b></p><br><br>
<p><b>THE SYSTEM</b></p>
@endsection