<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TIRTA ARUNA COTTAGE</title>

    <style>
    table,tr,th,td{
        border:1px solid black;
        width:100%;
    }
    </style>
</head>
<body>
    
    <div class="container" style="width:600px;text-align:center;position:relative;left:50%;transform:translateX(-50%);border:2px solid black;">
        <h1 style="width:100%;">TIRTA ARUNA COTTAGE</h1>
        <p>Jalan : Iman Bonjol nomor 5 X</p>
        <p>Kontak : 08129381XXXX</p>
        <hr style="border:1px solid black;">
        <div style="text-align:left;padding:5px;width:100%;">
        <h3 style="width:100%;">Penyewa : {{ $data['name'] }}</h3>
        <h3 style="width:100%;">Username : {{ $data['username'] }}</h3>
        <h3 style="width:100%;">Nomor Kamar : {{ $data['kamar'] }}</h3>
        <h3 style="width:100%;">Tanggal Struk : {{ $data['tanggal'] }}</h3>
        <h3 style="width:100%;">Order ID : {{ $data['order_id'] }}</h3>
        </div>
        <hr style="border:1px solid black;">

        <table>
            <tr>
                <th colspan="2" style="font-size:15pt;">RANGKUMAN PEMBAYARAN</th>
            </tr>
            <tr>
                <th style="width:50%;font-size:15pt;">Item</th>
                <th style="width:50%;font-size:15pt;">Harga</th>
            </tr>
            <tr style="text-align:center;">
                <th style="width:100%;">Pembayaran Sewa Kamar Nomor {{ $data['kamar'] }} Tanggal {{ $data['tgl_awal_sewa'] }} sampai {{ $data['tgl_akhir_sewa'] }}</th>
                <td>Rp. {{ number_format($data['harga'],0,'.','.') }}</td>
            </tr>
            <tr style="text-align:center;">
                <th style="width:50%;">-</th>
                <td>-</td>
            </tr>
            <tr style="text-align:center;">
                <th style="width:50%;">-</th>
                <td>-</td>
            </tr>
            <tr>
                <th style="width:50%;font-size:15pt;">TOTAL</th>
                <th style="width:50%;font-size:15pt;">Rp. {{ number_format($data['harga'],0,'.','.') }}</th>
            </tr>
            <tr>
                <th colspan="2" style="font-size:15pt;">STATUS PEMBAYARAN</th>
            </tr>
            <tr>
                <th colspan="2" style="font-size:50pt;">-{{ strtoupper($data['status']) }}-</th>
            </tr>
        </table>
        
        <div style="width:100%;height:100px; text-align:right;padding-right:150px;margin-bottom:20px;box-sizing:border-box;">
            <p style="width:100%;"><b>Big regrads,</b></p><br><br>

            <b>The System</>

        </div>
        
    </div>
</body>
</html>