<table>
    <thead>
        <tr>
            <th colspan="11" style="font-weight:bold;text-align:center;font-size:20pt;height:30px;">TIRTA ARUNA COTTAGE REPORT</th>
        </tr>

        <tr>
            <th colspan="11" style="font-weight:bold;text-align:center;font-size:20pt;">REPORT TAGIHAN</th>
        </tr>

        <tr>
            <th colspan="11" style=;text-align:center;font-size:15pt;height:30px;">Tanggal Cetak : {{ date('Y-m-d H:i:s') }}</th>
        </tr>

        <tr>
        <th style="width:7px;background-color: #a6a6a6;">Nomor</th>
        <th style="width:20px;background-color: #a6a6a6;">ID TAGIHAN</th>
        <th style="width:30px;background-color: #a6a6a6;">NAMA USER</th>
        <th style="width:20px;background-color: #a6a6a6;">Nomor HP</th>
        <th style="width:30px;background-color: #a6a6a6;">E-mail</th>
        <th style="width:20px;background-color: #a6a6a6;">Nomor Kamar</th>
        <th style="width:20px;background-color: #a6a6a6;">Tgl Awal Sewa</th>
        <th style="width:20px;background-color: #a6a6a6;">Tgl Akhir Sewa</th>
        <th style="width:10px;background-color: #a6a6a6;">Tipe</th>
        <th style="width:15px;background-color: #a6a6a6;">Nominal</th>
        <th style="width:15px;background-color: #a6a6a6;">Status Tagihan</th>
        </tr>
    </thead>
    <tbody>
<?php
    $terbayar = 0;
    $belum_terbayar = 0;
    foreach ($tagihans as $index => $tagihan) {
        if($tagihan->status_tagihan == 'lunas')
        {

            $terbayar += $tagihan->nominal_pembayaran;
        }
        else
        {
            $belum_terbayar += $tagihan->nominal_pembayaran;
        }

        if($tagihan->status_tagihan == 'hutang')
        {
?>
        <tr>
        <td style="text-align:center;background-color: #ffcccc;">{{ $index+1 }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->tagihan_idnya }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->name }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->nomor_hp }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->email }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->nomor_kamar }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->tgl_awal_sewa }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->tgl_akhir_sewa }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->tipe_pembayaran }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ 'Rp. '.number_format($tagihan->nominal_pembayaran,0,'.','.') }}</td>
        <td style="text-align:center;background-color: #ffcccc;">{{ $tagihan->status_tagihan }}</td>
        </tr>
<?php
        }
        else
        {
?>
        <tr>
        
        <td style="text-align:center;">{{ $index+1 }}</td>
        <td style="text-align:center;">{{ $tagihan->tagihan_idnya }}</td>
        <td style="text-align:center;">{{ $tagihan->name }}</td>
        <td style="text-align:center;">{{ $tagihan->nomor_hp }}</td>
        <td style="text-align:center;">{{ $tagihan->email }}</td>
        <td style="text-align:center;">{{ $tagihan->nomor_kamar }}</td>
        <td style="text-align:center;">{{ $tagihan->tgl_awal_sewa }}</td>
        <td style="text-align:center;">{{ $tagihan->tgl_akhir_sewa }}</td>
        <td style="text-align:center;">{{ $tagihan->tipe_pembayaran }}</td>
        <td style="text-align:center;">{{ 'Rp. '.number_format($tagihan->nominal_pembayaran,0,'.','.') }}</td>
        <td style="text-align:center;">{{ $tagihan->status_tagihan }}</td>

        </tr>
<?php
        }
        }
?>
        <tr>
            <td colspan="10" style="text-align:right;">TOTAL TERBAYAR :</td>
            <td colspan="1" style="text-align:center;">{{ 'Rp. '.number_format($terbayar,0,'.','.') }}</td>
        </tr>

        <tr>
            <td colspan="10" style="text-align:right;">TOTAL BELUM TERBAYAR :</td>
            <td colspan="1" style="text-align:center;">{{ 'Rp. '.number_format($belum_terbayar,0,'.','.') }}</td>
        </tr>

        <tr>
            <td colspan="11" style="text-align:center">GENERATE BY SYSTEM TIRTA ARUNA COTTAGE</td>
        </tr>

    </tbody>
</table>