@extends('email.email_layout')
@section('pembuka')
Salam Admin berikut ini merupakan e-mail yang memuat pelaporan yang diajukan oleh user {{ $data['name'] }} dari kamar {{ $data['kamar'] }}.
@endsection 

@section('isi')
<tr>
<td>
Laporan : {{ $data['keluhan'] }}
</td>
</tr>
<tr>
<td>
<a href="{{ url('storage/image_pelaporan',[$data['image']]) }}">
<img src="{{ url('storage/image_pelaporan',[$data['image']]) }}" alt="LAPORAN TIDAK DISERTAKAN GAMBAR" style="max-height:200px;">
</a>
</td>
</tr>
@endsection

@section('penutup')
Terimakasih Atas perhatian admin semoga sukses :)
@endsection