@extends('app_layout/reglog')

@section('judul','LOGIN')
@section('keterangan','LOGIN SISTEM TIRTA ARUNA COTTAGE')

@section('content')
<div class="d-flex justify-content-center">
    <form action="{{ url('/login') }}" method="POST" class="w-50">
        {{csrf_field()}}
        <h2 class="mt-3 text-left text-light">INPUT CREDENTIALS</h2>
        
        <input type="text" class="form-control mt-2" placeholder="username" name="username" required minlength="4" maxlength="50" value="{{ old('username') }}" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                if($errors->has('username')){
                    echo $errors->first('username');
                }
            ?>
        </p>
        
        <input type="password" class="form-control mt-2" placeholder="password" name="password" required minlength="4" maxlength="50" value="{{ old('password') }}" autocorrect="off" autocapitalize="none">
        <p class="text-danger text-center">
            <?php
                $system = Session::get('system');
                
                if($errors->has('password')){
                    echo '<p class="text-danger text-center">'.$errors->first('password').'</p>';
                }

                if($system == 'false')
                {
                    echo '<p class="text-danger text-center">Username atau Password salah</p>';
                }
            ?>
        </p>
      
        <div class="w-100 d-flex justify-content-center">
            <button class="btn-info bg-dark mt-5 mb-3 w-50 text-center" style="outline:none;max-width:200px;">SUBMIT</button>
        </div>
    </form>
    </div>

<!-- MODAL SUCCESS -->
    @extends('app_layout/modal')
    @section('judul','REGISTRASI BERHASIL')
    @section('isi','Anda dapat login ke dalam sistem setelah akun diverifikasi admin')

<!-- MODAL DENIED -->
    @extends('app_layout/modal_denied')
    @section('modal_denied_judul','ACCESS DENIED')
    @section('modal_denied_isi','Akses anda ditolah oleh sistem')

@endsection