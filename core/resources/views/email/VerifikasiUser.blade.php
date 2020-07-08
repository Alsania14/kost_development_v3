@extends('email/email_layout')
@section('pembuka')
Hai {{ $data['name'] }}, <br>
Berikut ini merupakan link untuk melakukan verifikasi email anda, apabila email tidak diverifikasi dengan benar maka fitur sistem tidak dapat digunakan secara menyeluruh
@endsection

@section('isi')
<a href="{{ url('/verifikasi',[$data['param']]) }}">VERIFIKASI EMAIL ANDA</a>
@endsection

@section('penutup','Terimakasih atas waktu dan perhatian anda')