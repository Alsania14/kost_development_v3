<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Dashboard Tirta Aruna Cottage">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>Tirta Aruna Cottage (ADMIN)</title>


    <!-- Bootstrap core CSS -->
    <link href="{{ asset('vendor_app/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet">

    @yield('headtambahan')

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      *{
          color:white;
      }

      /* width */
    ::-webkit-scrollbar {
      width: 10px;
    }

    /* Track */
    ::-webkit-scrollbar-track {
      background: #f1f1f1;
    }

    /* Handle */
    ::-webkit-scrollbar-thumb {
      background: #888;
    }

    /* Handle on hover */
    ::-webkit-scrollbar-thumb:hover {
      background: #555;
    }
    </style>
    <!-- Custom styles for this template -->
    <link href="{{ asset('vendor_app/dashboard/dashboard.css') }}" rel="stylesheet">
  </head>
  <body style="background:#2e2e2e;">
    <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="{{ url('/dashboard') }}">Tirta Aruna Cottage <sup style="font-size:8pt;" class="badge-pill bg-warning text-dark">Alpha</sup></a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <ul class="navbar-nav px-3">
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="{{ url('/logout') }}">Sign out</a>
    </li>
  </ul>
</nav>

<div class="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
      <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/admindashboard') }}" style="@yield('dashboard')">
              <span data-feather="home"></span>
              Dashboard Admin
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/adminprofile') }}" style="@yield('profile')">
              Profile Admin
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light d-flex justify-content-between" href="{{ url('/adminnotifikasi') }}" style="@yield('notifikasi')">
              Notifikasi<span class="badge badge-info text-dark badge-pill" style="font-size:9pt;{{ config('global.active') }}">@yield('jumlah')</span>
            </a>
          </li>
          <li class="nav-item" id="dropin" style="height:35px;overflow:hidden;transition:0.5s" id="atas">
            <a class="nav-link text-light d-flex justify-content-between" style="@yield('reportadmin');cursor:pointer;" onclick="sentuh()">
              <span>Report Admin</span> <span> &#x25BC; </span>
            </a>  
                    <a class="pl-5 nav-link text-light" href="{{ url('/admintagihan') }}" style="cursor:pointer;">
                      Tagihan Users
                    </a>
                    <a class="pl-5 nav-link text-light" href="{{ url('/transaksi') }}" style="cursor:pointer;">
                      Transaksi Users
                    </a>
                    <a class="pl-5 nav-link text-light" style="cursor:pointer;">
                      belum
                    </a>
          </li>
          <li class="nav-item" id="bawah" >
            <a class="nav-link text-light" href="{{ url('/laporan') }}" style="@yield('pelaporan')">
              Pelaporan
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('reward')">
              Reward
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/wifi') }}" style="@yield('wifi')">
              Wifi
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/kamar') }}" style="@yield('kamar')">
              Kamar
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
        <h1 class="h5 text-light">@yield('header')</h1>
      </div>
      @yield('content')
    </main>
  </div>
</div>
        <script src="{{ asset('vendor_app/jquery.js') }}" ></script>
        <script src="{{ asset('vendor_app/bootstrap/dist/js/bootstrap.bundle.min.js') }}"></script>
        <script>
            var drop = document.getElementById("dropin");
            var atas = document.getElementById("atas");
            var bawah = document.getElementById("bawah");

            var status = "open";

            function sentuh()
            {
              console.log(status);
              if(status == "open")
              {
                drop.style.height="150px";
                status = "close";
              }
              else if(status == "close")
              {
                drop.style.height="35px";
                status="open";
              }
              console.log(status);
            }
        </script>

        <?php
            $system = Session::get('system');

            if($system == 'success')
            {
                echo "<script>$('#modal').modal('show');</script>";
            }
            elseif($system == 'denied')

            {
                echo "<script>$('#modaldenied').modal('show');</script>";
            }
        ?>

        @yield('tambahanbawah')
</body>
</html>
