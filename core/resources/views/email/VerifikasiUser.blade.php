@extends('email/email_layout')
@section('content')
<h4>SUBJECT : TAGIHAN KAMAR KOST</h4>
<h4>Hai {{ $data['name'] }},</h4>
<p>Berikut ini merupakan link untuk melakukan verifikasi email anda, apabila email tidak diverifikasi dengan benar maka fitur sistem tidak dapat digunakan secara menyeluruh</p>

<a href="{{ url('/verifikasi',[$data['param']]) }}">VERIFIKASI EMAIL ANDA</a>

<p>Verifikasi harus dilakukan supaya anda dapat menggunakan fitur sistem secara keseluruhan, terimakasih atas waktunya</p>

<p><b>BIG REGRADS</b></p><br><br>
<p><b>THE SYSTEM</b></p>
@endsection