<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TIRTA ARUNA COTTAGE</title>
    <link href="{{ asset('vendor_app/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet">

</head>
<body class="bg-dark">
    <div class="container">
        <div class="jumbotron bg-dark m-0" style="height:800px;">
            <div class="w-100 d-flex justify-content-center">
                <p class="text-light h3">AKSES DITOLAK</p>
            </div>
            <div class="w-100 d-flex justify-content-center">
                <p class="text-light text-center">AKSES ANDA KE HALAMAN INI TIDAK TERSEDIA SAMPAI ANDA MEMENUHI SYARAT DIBAWAH INI.</p>
            </div>

            <div class="w-100 d-flex justify-content-center">
                <ul class="text-light">
                    <li>MEMILIKI KAMAR KOST YANG TELAH DITETAPKAN OLEH ADMIN</li>
                    <li>MEMENUHI SEMUA DATA DIRI PADA HALAMAN PROFILE</li>
                    <li>MEMVERIFIKASI EMAIL YANG DIINPUTKAN PADA HALAMAN PROFILE</li>
                    <li>MEMBERIKAN FOTO KTP</li>

                </ul>
            </div>
            <div class="w-100 d-flex justify-content-center">
                <a href="{{ url('/dashboard') }}" class="bg-info btn btn-lg" style="max-width:200px;">DASHBOARD</a>
            </div>
            <div class="w-100 d-flex justify-content-center">
                <img src="{{ url('storage/image_pelaporan/lock.png') }}" style="max-width:400px;">
            </div>
        </div>
    </div>
</body>
</html>