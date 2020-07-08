@extends('email.email_layout')
@section('pembuka')
Salam Admin, Berikut ini merupakan laporan dari sistem. Sistem telah mengirimkan tagihan kepada user kost dengan rincian sebagai berikut
@endsection

@section('isi')
<tr>
            <th>Nomor</th>
            <th>Nama</th>
            <th>Kamar</th>
            <th>Tgl Awal Sewa</th>
            <th>Tgl Akhir Sewa</th>
            <th>deadline Pembayaran</th>
            <th>Harga</th>
        </tr>
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
@endsection

@section('penutup')
Terimakasih Atas perhatian admin semoga sukses :)
@endsection