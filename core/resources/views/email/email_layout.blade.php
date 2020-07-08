<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TIRTA ARUNA COTTAGE</title>
    <style>
        table,th,td {
            text-align:center;
            background:#f3ffc9;
            padding:3px;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <th colspan="7" style="{{ config('global.active') }}">
                <h1>
                TIRTA ARUNA COTTAGE <br>
                E-MAIL
                </h1>
                <P>
                Jln.Banteng No.16 <br>
                Nomor Hp 081246082357
                </P>
            </th>
        </tr>
        
        <tr>
            <th colspan="7" >
                <p>@yield('pembuka')</p>
            </th>
        </tr>
                    @yield('isi')
        <tr>
            <td colspan="7" >
                <p>@yield('penutup')</p>
            </td>
        </tr>
        
        <tr>
            <td colspan="7" style="text-align:right;padding-right:100px;{{ config('global.active') }}">
                <p style="margin-bottom:20px;">Big Regrads</p>
                <p>The System</p>
            </td>
        </tr>

    </table>
</body>
</html>