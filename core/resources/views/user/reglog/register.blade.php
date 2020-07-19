@extends('app_layout/reglog')

@section('judul','REGISTER')
@section('keterangan','REGISTER SISTE TIRTA ARUNA COTTAGE')

@section('content')
    <div class="d-flex justify-content-center">
    <form action="{{ url('/register') }}" method="POST" class="w-50" autocomplete="off">
        {{csrf_field()}}
        <h2 class="mt-3 text-left text-light">INPUT CREDENTIALS</h2>
        
        <input type="text" class="form-control mt-2" placeholder="Real Name" name="name" required minlength="4" maxlength="50" value="{{ old('name') }}" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                if($errors->has('name')){
                    echo $errors->first('name');
                }
            ?>
        </p>
        
        <input type="email" class="form-control mt-2" placeholder="email" name="email" required minlength="4" maxlength="50" value="{{ old('email') }}" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                if($errors->has('email')){
                    echo $errors->first('email');
                }
            ?>
        </p>

        <input type="text" class="form-control mt-2" placeholder="Username" name="username" required minlength="4" maxlength="20" value="{{ old('username') }}" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                if($errors->has('username')){
                    echo $errors->first('username');
                }
            ?>
        </p>

        <input type="password" class="form-control mt-2" placeholder="Password" name="password" required minlength="4" maxlength="50" >
        <p class="text-danger text-center" autocorrect="off" autocapitalize="none">
            <?php
                if($errors->has('password')){
                    echo $errors->first('password');
                }
            ?>
        </p>

        <input type="password" class="form-control mt-2" placeholder="Confirmation" name="password_confirmation" required minlength="4" maxlength="50" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                if($errors->has('password_confirmation')){
                    echo $errors->first('password_confirmation');
                }
            ?>
        </p>

        <div class="w-100 d-flex justify-content-center">
            <button class="btn-info bg-dark mt-5 mb-3 w-50 text-center" style="outline:none;">SUBMIT</button>
        </div>
        <p class="text-info text-center">Akun baru dapat digunakan setelah disetujui admin, info akan dikirimkan ke email anda</p>
    </form>
    </div>
@endsection