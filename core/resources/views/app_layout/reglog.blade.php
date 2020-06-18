<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Elements</title>
	<link href="https://fonts.googleapis.com/css?family=Oswald:300,400,500" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:300i,400,500" rel="stylesheet">
	
	<link rel="stylesheet" href="{{ asset('vendor_app/sprash/vendor/themify-icons/themify-icons.css') }}">
	<link rel="stylesheet" href="{{ asset('vendor_app/sprash/vendor/owl-carousel/owl.theme.default.min.css') }}">
	<link rel="stylesheet" href="{{ asset('vendor_app/sprash/vendor/owl-carousel/owl.carousel.min.css') }}">
	<link rel="stylesheet" href="{{ asset('vendor_app/sprash/vendor/bootstrap/bootstrap.min.css') }}">
  	<link rel="stylesheet" href="{{ asset('vendor_app/sprash/css/style.css') }}">
	
</head>
<body>

	<!-- ================Offcanvus Menu Area =================-->
	<div class="side_menu">
			<ul class="list menu_right">
				<li>
					<a href="{{ url('/') }}">Home</a>
				</li>
				<li>
					<a href="{{ url('/login') }}">Login</a>
				</li>
				<li>
					<a href="{{ url('/register') }}">Register</a>
				</li>
				<li>
					<a href="{{ url('/developer') }}">Developer</a>
				</li>
				<li>
					<a href="#">Pages</a>
					<ul class="list">
						<li>
							<a href="elements.html">Elements</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="#">Blog</a>
					<ul class="list">
						<li>
							<a href="blog.html">Blog</a>
						</li>
						<li>
							<a href="single-blog.html">Blog Details</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="contact.html">Contact</a>
				</li>
			</ul>
	</div>
	<!--================End Offcanvus Menu Area =================-->

	<!--================Canvus Menu Area =================-->
	<div class="canvus_menu">
		<div class="container">
			<div class="float-right">
				<div class="toggle_icon" title="Menu Bar">
					<span></span>
				</div>
			</div>
		</div>
	</div>
	<!--================End Canvus Menu Area =================-->
  <header class="hero-banner project-bg">
    <a class="navbar-brand" href="index.html">
      <img src="{{ asset('vendor_app/sprash/img/logo.png') }}" alt="">
    </a>
    <div class="container w-100 bg-none">
      <h2 class="section-intro__subtitle font-weight-bold">@yield('judul')</h2>
	  <p class="text text-light">@yield('keterangan')</p>
  </header>
	@yield('content')
	<footer class="footer footer-bg">
			<div class="container">
				<div class="row">
					<div class="col-sm-4 col-lg-2 mb-4 mb-lg-0 text-center text-sm-left">
						<h3 class="footer__title">ALL ABOUT QUALITY !</h3>
						<ul class="footer__link">
							<li><a href="#/">LOKASI STRATEGIS</a></li>
							<li><a href="#/">HARGA TERJANGKAU</a></li>
							<li><a href="#/">FASILITAS LENGKAP</a></li>
							<li><a href="#/">READY WIFI 24/7</a></li>
							<li><a href="#/">TERINTEGRASI WEB</a></li>
						</ul>
					</div>
				
			
					<div class="col-sm-8 col-lg-4 mb-4 mb-lg-0 text-center text-sm-left">
						<h3 class="footer__title">MORE INFORMATION</h3>
						<p>Berikan alamat E-mail anda,Sistem akan memberikan Informasi lebih lanjut</p>
						<form action="" class="form-subscribe">
							<div class="input-group">
								<input type="email" class="form-control" placeholder="Your email address" required>
								<div class="input-group-append">
									<button class="btn-append" type="submit"><i class="lnr lnr-arrow-right"></i></button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="d-sm-flex justify-content-between footer__bottom top-border">
					<p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
					<ul class="social-icons mt-2 mt-sm-0">
						<li><a href="#/"><i class="fab fa-facebook-f"></i></a></li>
						<li><a href="#/"><i class="fab fa-twitter"></i></a></li>
						<li><a href="#/"><i class="fab fa-dribbble"></i></a></li>
						<li><a href="#/"><i class="fab fa-behance"></i></a></li>					
					</ul>
				</div>
			</div>
		</footer>
	<!-- End footer Area -->
	<script type="text/javascript" src="{{ asset('vendor_app/jquery.js') }}"></script>
	<script type="text/javascript" src="{{ asset('vendor_app/bootstrap/dist/js/bootstrap.min.js') }}"></script>
	<script src="{{ asset('vendor_app/sprash/vendor/owl-carousel/owl.carousel.min.js') }}"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
	<!-- MODAL EXECUTOR -->
	<?php
		
        $system = Session::get('system');
        if($system == 'success'){
            echo "<script>$('#modal').modal('show');</script>";
        }elseif ($system == 'denied') {
            echo "<script>$('#modaldenied').modal('show');</script>";
        }
    
    ?>
	<!-- MODAL EXECUTOR -->
	<script>
		

		var heroCarousel = $('.heroCarousel');
		heroCarousel.owlCarousel({
		loop:true,
		margin:10,
		nav: false,
		startPosition: 1,
		responsiveClass:true,
		responsive:{
			0:{
				items:1
			}
		}
		});

		var dropToggle = $('.menu_right > li').has('ul').children('a');
		dropToggle.on('click', function() {
			dropToggle.not(this).closest('li').find('ul').slideUp(200);
			$(this).closest('li').children('ul').slideToggle(200);
			return false;
		});

		$( ".toggle_icon" ).on('click', function() {
			$( 'body' ).toggleClass( "open" );
		});

		$('select').niceSelect();


	</script>
	
</body>

</html>