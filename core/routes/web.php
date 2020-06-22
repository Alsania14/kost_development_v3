<?php

use Illuminate\Support\Facades\Route;

// ROUTE INDEX DAN TESTING

    Route::get('/', function () {
        return view('index');
    });

    Route::get('/test',function(){
        date_default_timezone_set(config('global.timezone'));

        return date('Y-m-d H:i:s');
    });

// AKHIR

// ROUTE REGISTER DAN LOGIN USER

    Route::get('/register','register\RegisterController@viewregister');
    Route::post('/register','register\RegisterController@postregister');

    Route::get('/login','login\LoginController@viewlogin');
    Route::post('/login','login\LoginController@postlogin');

// AKHIR

// ROUTE DASHBOARD USER
    // MIDDLEWARE USER AUTHENTICATION

        /*SELAIN USER TIDAK ADA YANG BISA MENGAKSES HALAMAN INI
        TERMASUK ADNIM SEKALIPUN */
        Route::middleware('userauthentication')->group(function(){
            // INDEX DASHBOARD
                Route::get('/dashboard','dashboard\DashboardController@index');
            // AKHIR

            // HALAMAN PROFILE USER
                Route::get('/profile','dashboard\ProfileController@index');
                Route::get('/edit/{id}','dashboard\ProfileController@edit');
                Route::put('/edit/{id}','dashboard\ProfileController@update');
            // AKHIR
            
            // HALAMAN NOTIFIKASI USER
                Route::get('/notifikasi','dashboard\NotifikasiController@index');
                Route::patch('/markall/{id}','dashboard\NotifikasiController@markall');
            // AKHIR

            // USER DAPAT LOGOUT SETELAH MASUK KE DALAM SISTEM
                Route::get('/logout','login\LoginController@logout');
            // AKHIR
        });

// AKHIR

        
        
