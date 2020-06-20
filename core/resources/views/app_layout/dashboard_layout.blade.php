<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Dashboard Tirta Aruna Cottage">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>Tirta Aruna Cottage</title>


    <!-- Bootstrap core CSS -->
    <link href="{{ asset('vendor_app/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet">

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
    </style>
    <!-- Custom styles for this template -->
    <link href="{{ asset('vendor_app/dashboard/dashboard.css') }}" rel="stylesheet">
  </head>
  <body style="background:#2e2e2e;">
    <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="{{ url('/dashboard') }}">Tirta Aruna Cottage</a>
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
        <div class="text-center"> 
        <img src="@yield('img_user')" alt="" class="img-thumbnail" style="width:100px;height:100px;border-radius: 50px;">
        <div class="text-light mt-3">@yield('username')</div>
        <p class="text-light">Room : @yield('room')</p>
        </div>
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/dashboard') }}" style="@yield('dashboard')">
              <span data-feather="home"></span>
              Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="{{ url('/profile') }}" style="@yield('profile')">
              Profile User
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('notifikasi')">
              Notifikasi
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('pembayaran')">
              Pembayaran Kost
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('pelaporan')">
              Pelaporan
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('reward')">
              Reward
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('Wifi')">
              Wifi
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-light" href="#" style="@yield('Wifi')">
              Kamar
            </a>
          </li>
        </ul>

      </div>
    </nav>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
        <h1 class="h2 text-light">@yield('header')</h1>
      </div>
      @yield('content')

      <div class="row">
      <div class="col-md text-center text-dark" style="{{ config('global.active') }}">Team IT Tirta Aruna Cottage</div>
      </div>  
    </main>
  </div>
</div>
        <script src="{{ asset('vendor_app/jquery.js') }}" ></script>
        <script src="{{ asset('vendor_app/bootstrap/dist/js/bootstrap.bundle.min.js') }}"></script>
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
</body>
</html>
