@extends('email/email_layout')
@section('content')
<h4>SUBJECT : LAPORAN PEMBERIAN TAGIHAN</h4>
<h4>Hai Admin,</h4>
<p>Berikut merupakan laporan tagihan yang telah diberikan oleh sistem kepada user/penyewa kos.</p>

<table>
    <thead>
        <tr>
            <th>Nomor</th>
            <th>Nama</th>
            <th>Kamar</th>
            <th>Tgl Awal Sewa</th>
            <th>Tgl Akhir Sewa</th>
            <th>deadline Pembayaran</th>
            <th>Harga</th>
        </tr>
    </thead>
    <tbody>
<?php
    foreach ($sukses as $index => $data) {
?>
    <tr>
        <td>{{ $index+1 }}</td>
        <td>{{ $data['name'] }}</td>
        <td>{{ $data['kamar'] }}</td>
        <td>{{ $data['tgl_awal'] }}</td>
        <td>{{ $data['tgl_akhir'] }}</td>
        <td>{{ $data['deadline'] }}</td>
        <td>{{ 'Rp. '.number_format($data['harga'],0,'.','.') }}</td>
    </tr>
<?php
  }
?>
    </tbody>

</table>

<p>apabila admin ingin mematikan fitur auto minta secara spesifik dapat dilakukan pada halaman setting admin</p>

<p><b>BIG REGRADS</b></p><br><br>
<p><b>THE SYSTEM</b></p>
@endsection