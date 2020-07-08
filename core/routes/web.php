<?php

use Illuminate\Support\Facades\Route;

// ROUTE INDEX DAN TESTING

    Route::get('/', function () {
        return view('index');
    });

    Route::get('/test',function(){
        return view('email/ujicoba');
    });

// AKHIR

// ROUTE REGISTER DAN LOGIN USER

    // REGISTER
        Route::get('/register','register\RegisterController@viewregister');
        Route::post('/register','register\RegisterController@postregister');
    // AKHIR
    
    // LOGIN
        Route::get('/login','login\LoginController@viewlogin');
        Route::post('/login','login\LoginController@postlogin');
    // AKHIR

    // VERIFIKASI EMAIL
        Route::get('/verifikasi/{email}','register\RegisterController@verifikasiemail');
    // AKHIR

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

                Route::get('/verifikasiintern/{email}','dashboard\ProfileController@verifikasi');
            // AKHIR
            
            // HALAMAN NOTIFIKASI USER
                Route::get('/notifikasi','dashboard\NotifikasiController@index');
                Route::patch('/markall/{id}','dashboard\NotifikasiController@markall');
            // AKHIR

            // PEMBAYARAN KOST
                // HALAMAN PEMBAYARAN USER
                    Route::get('/tagihan','dashboard\tagihan\TagihanController@index');
                    Route::get('/pilihpembayaran/{id}','dashboard\tagihan\TagihanController@pilihpembayaran');

                    // PEMBAYARAN ONLINE
                        // PEMBAYARAN BANK BNI
                            // CHARGE
                                Route::post('/onlinebni','dashboard\tagihan\online\BniController@charge');
                                Route::post('/onlinebca','dashboard\tagihan\online\BcaController@charge');
                                Route::post('/onlinemandiri','dashboard\tagihan\online\MandiriController@charge');
                                Route::post('/onlinepermata','dashboard\tagihan\online\PermataController@charge');
                            // AKHIR
                        // AKHIR

                        // PEMBAYARAN INDOMARET DAN ALFAMART
                            // CHARGE
                                Route::post('/tokoindomaret','dashboard\tagihan\toko\IndomaretController@charge');
                                Route::post('/tokoalfamart','dashboard\tagihan\toko\AlfamartController@charge');
                            // AKHIR
                        // AKHIR

                        // PEMBAYARAN MANUAL
                            // CHARGE
                                Route::post('/manual','dashboard\tagihan\manual\ManualController@charge');
                            // AKHIR
                        // AKHIR
                    // AKHIR

                    // AKSI HALAMAN TAGIHAN
                        Route::get('/arsiptagihan','dashboard\tagihan\TagihanController@indexarsip');
                        Route::put('/arsiptagihan/{id}','dashboard\tagihan\TagihanController@arsiptagihan');
                        Route::post('/struk/{id}','dashboard\tagihan\StructController@index');
                    // AKHIR

                    // HLAMAN INDEX ARSIP TAGIHAN
                        // AKSI KELUARKAN TAGIHAN
                            Route::put('/keluarkanarsiptagihan/{id}','dashboard\tagihan\TagihanController@keluarkanarsip');
                        // AKHIR
                    // AKHIR
                // AKHIR

                // TRANSAKSI USERS
                    // HALAMAN INDEX TRANSAKSI 
                        Route::get('/transaksi','dashboard\transaksi\TransaksiController@index');
                        // BANK TRANSFER
                            Route::get('/bank_transfer/{id}','dashboard\transaksi\TransaksiController@detailtransaksionline');
                        // AKHIR

                        // MERCHANT PAYMENT
                            Route::get('/kedai/{id}','dashboard\transaksi\TransaksiController@detailtransakitoko');
                        // AKHIR

                        // MANUAL PAYMENT
                            Route::get('/manual/{id}','dashboard\tagihan\manual\ManualController@detailtransaksimanual');
                            Route::post('/uploadbukti','dashboard\tagihan\manual\ManualController@uploadbukti');
                        // AKHIR

                        // AKSI HALAMAN TRANSAKSI
                            Route::get('/arsiptransaksi','dashboard\transaksi\TransaksiController@indexarsip');
                            Route::put('/refresh/{id}','dashboard\transaksi\TransaksiController@refreshtransaksi');
                            Route::put('/arsiptransaksi/{id}','dashboard\transaksi\TransaksiController@arsiptransaksi');
                        // AKHIR
                    // AKHIR

                    // HALAMAN INDEX ARSIP TRANSAKSI
                        // AKSI HALAMAN INDEX ARSIP TRANSAKSI
                            Route::put('/keluarkanarsiptransaksi/{id}','dashboard\transaksi\TransaksiController@keluarkanarsip');
                        // AKHIR
                    // AKHIR
                    
                // AKHIR
            // AKHIR

            // HALAMAN PELAPORAN
                // INDEX
                    Route::get('/laporan','dashboard\PelaporanController@index');
                // AKHIR

                // CREATE
                    Route::post('/laporan','dashboard\PelaporanController@create'); 
                // AKHIR

                // DELETE BY ADMIN
                    Route::post('/delete','dashboard\PelaporanController@create');
                // AKHIR
            // AKHIR

            // HALAMAN WIFI
                Route::get('/wifi','dashboard\FeatureController@index');
            // AKHIR

            // HALAMAN KAMAR USERS
                Route::get('/kamar','dashboard\KamarController@index');
                Route::get('/kamar/{id}','dashboard\KamarController@gambar');
            // AKHIR

            // USER DAPAT LOGOUT SETELAH MASUK KE DALAM SISTEM
                Route::get('/logout','login\LoginController@logout');
            // AKHIR
        });
    // AKHIR

    // MIDTRANS NOTIFICATION HANDLER
        /*DILETAKKAN DILUAR MIDDLEWARE SUPAYA DAPAT DIAKSES MIDTRANS*/
        Route::post('/notification','dashboard\transaksi\NotificationController@index');
    // AKHIR
// AKHIR

        
        
