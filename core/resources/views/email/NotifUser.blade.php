@extends('email.email_layout')
@section('pembuka')
Hai {{ $data['name'] }} Tagihan sewa kamar kost anda dengan kamar nomor {{ $data['kamar'] }} dan tanggal sewa {{ $data['tgl_awal'] }} s/d {{ $data['tgl_akhir'] }} telah dibentuk dengan nominal {{ 'Rp '.number_format($data['harga'],0,'.','.') }} silahkan untuk segera melakukan pembayaran sebelum batas pembayaran pada tanggal <b>{{ $data['deadline'] }} </b>, pembayaran dapat dilakukan melalui sistem dengan beberapa metode pembayaran berikut ini
@endsection

@section('isi')
<tr>
    <td colspan="7" style="border:none;">
        <ul style="text-align:left;">
            <li>BNI BANK TRANSFER</li>
            <li>BCA BANK TRANSFER</li>
            <li>MANDIRI BANK TRANSFER</li>
            <li>PERMATA BANK TRANSFER</li>
            <li>INDOMARET MINIMARKET PAYMENT</li>
            <li>ALFAMART MINIMARKET PAYMENT</li>
            <li>MANUAL PAYMENT</li>
        </ul>
    </td>
</tr>
@endsection

@section('penutup')
Dimohon untuk user segera melakukan pembayaran, apabila melewati waktu yang telah ditentukan maka sistem akan memblokir akses pengguna dan dianggap tidak melankutkan sewa. Sekian dari system terimakasih atas perhatiannya, have a good day
@endsection