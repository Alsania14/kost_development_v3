<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TIRTA ARUAN COTTAGE EMAIL</title>
    <style>
        .container{
            position:relative;
            left:50%;
            transform:translateX(-50%);
            width:700px;
            height:auto;
            border:3px solid black;
            padding:10px;
        }

        .head {
            position:relative;
            left:50%;
            transform:translateX(-50%);
            width:auto;
            display:flex;
            flex-direction:column;
            justify-content:center;
        }

        .body {
            position:relative;
            left:50%;
            transform:translateX(-50%);
            width:auto;
            display:flex;
            flex-direction:column;
            justify-content:center;
        }

        table,tr,td,th {
            text-align:center;
        }
    
    </style>
</head>
<body>
    <div class="container">
        <div class="head" style="text-align:center;">
            <h1>TIRTA ARUNA COTTAGE EMAIL</h1>
            <h5>ALAMAT: BLA BLA  XXXX</h5>
            <h5>KONTAK: 08192749XXXXX</h5>
        </div>
        <hr style="border:2px solid black;">
        <div class="body">
            @yield('content')
        </div>
    </div>
</body>
</html>