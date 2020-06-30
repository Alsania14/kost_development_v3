@extends('email/email_layout')
@section('content')
<h4>SUBJECT : TAGIHAN KAMAR KOST</h4>
<h4>Hai {{ $data['name'] }},</h4>
<p>Tagihan sewa kamar kost anda dengan kamar nomor {{ $data['kamar'] }} dan tanggal sewa {{ $data['tgl_awal'] }} s/d {{ $data['tgl_akhir'] }} telah dibentuk silahkan untuk segera melakukan pembayaran sebelum batas pembayaran pada tanggal <b>{{ $data['deadline'] }} </b>, pembayaran dapat dilakukan melalui sistem dengan beberapa metode pembayaran berikut ini</p>
<ul>
    <li>BNI BANK TRANSFER</li>
    <li>BCA BANK TRANSFER</li>
    <li>MANDIRI BANK TRANSFER</li>
    <li>PERMATA BANK TRANSFER</li>
    <li>INDOMARET MINIMARKET PAYMENT</li>
    <li>INDOMARET MINIMARKET PAYMENT</li>
    <li>MANUAL PAYMENT</li>
</ul>
<p>dimohon untuk segera melakukan pembayaran dengan metode yang telah disediakan diatas, untuk info lebih lanjut bisa dilihat di aplikasi, terimakasih :)</p>

<p><b>BIG REGRADS</b></p><br><br>
<p><b>THE SYSTEM</b></p>
@endsection