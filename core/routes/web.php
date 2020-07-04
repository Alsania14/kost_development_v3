<?php

use Illuminate\Support\Facades\Route;

use Illuminate\Support\Facades\DB;

use App\Notifications\UserNotification;
use App\Kamar;
use App\Tagihan;
use App\Setting;
use App\Mail\NotifUser;
use App\Mail\NotifAdmin;
use App\User;

// ROUTE INDEX DAN TESTING

    Route::get('/', function () {
        return view('index');
    });

    Route::get('/test',function(){
        // MENGAMBIL WAKTU SEKARANG
        $current_date = date_create(date('Y-m-d'));
        // AKHIR
         
         // MENGAMBIL SEMUA KAMAR DAN MEMBANDINGKANNYA
             /* APABILA ADA KAMAR YANG TANGGAL 'BAYAR SELANJUTNYA' MELEWATI HARI INI MAKA
             PROGRAM AKAN MENGUBAH BAYAR SELANJUTNYA KE TANGGAL YANG SAMA BULAN DEPAN UNTUK KOST
             BULANAN DAN TAHUN DEPAN TANGGAL YANG SAMA TAHUN DEPAN*/
             
             // GET SEMUA DATA KAMAR DAN MEMBANDINGKAN, SERTA MENGAMBIL DATA TABLE SETTING
                 $kamars = Kamar::whereNotNull('user_id')->orderBy('id')->get();
                 $setting_penagihan = Setting::where('name_setting','hari_penagihan')->first();
                 $setting_deadline = Setting::where('name_setting','deadline_pembayaran')->first();
                 echo "setting penagihan ".$setting_penagihan->value."\n";
                 echo "setting deadline ".$setting_deadline->value."\n";
                 
                 foreach ($kamars as $index => $kamar)
                 {
                     if($kamar->auto_tagih == 'on')
                     {
                         $tgl_kamar = date_create($kamar->tgl_bayar_selanjutnya);    
                         $diff = \date_diff($current_date,$tgl_kamar);
                         $diff = $diff->format('%r%a');
                         
                         /*JIKA DIFF ATAU JARAK LEBIH KECIL DARI 0 MAKA SISTEM AKAN
                         MEMBUAT INVOICE ATAU TAGIHAN PADA TABLE TAGIHANS DATABASE
                         */
                         if($diff < $setting_penagihan->value)
                         {   
                             // MENGAMBIL TANGGAL BAYAR TERAKHIR PENYEWA KOS DAN MEMECAH MENJADI ARRAY
                                 $array_tanggal_awal_sewa = array_map('intval', explode("-",$kamar->tgl_mulai_sewa));
                                 $array_tanggal = array_map('intval', explode("-",$kamar->tgl_bayar_selanjutnya));
                                 // UBAH TANGGAL KE AWAL USER SEWA
                                 $array_tanggal[2] = $array_tanggal_awal_sewa[2];
                             // AKHIR

                             // MENGAMBIL USER KAMAR
                                 $user = $kamar->user();
                             // AKHIR

                             if($kamar->tipe_pembayaran == 'bulan')
                             {
                                 // BULAN SEKARANG DI TAMBAH 1 DAN APABILA BULAN 12, TAHUN DITAMBAH SATU JUGA DAN BULAN JADI 1
                                     if($array_tanggal[1] == 12)
                                     {
                                         $array_tanggal[0] += 1;
                                         $array_tanggal[1] = 1;
                                     }
                                     else
                                     {
                                         $array_tanggal[1] += 1;
                                     }
                                 // AKHIR
                                 
                             }
                             elseif($kamar->tipe_pembayaran == 'tahun')
                             {
                                 // TAHUNAN SIMPLE TINGGAL TAMBAH 1 PADA TAHUN
                                     $array_tanggal[0] += 1;
                                 // AKHIR
                             }
                                 // MENGECEK TANGGAL APAKAH VALID
                                     /* MENGGUNAKAN CHECKDATE SAAT TANGGAL TIDAK VALID SEPERTI TANGGAL 29 FEB YANG MUNCUL
                                     4 TAHUN SEKALI MAKA PROGRAM AKAN MENENTUKAN TANGGAL PEMBAYARAN SELANJUTNYA PADA
                                     TANGGAL SEWA -1 SAMPA TANGGAL ITU VALID*/
                                     while(checkdate($array_tanggal[1],$array_tanggal[2],$array_tanggal[0]) == false)
                                     {
                                         $array_tanggal[2] -= 1;
                                     }
                                 // AKHIR
                             
                                 // PROSES MENGUBAH ARRAY_TANGGAL KE BENTUK STRING DAN AKAN DISIMPAN PADA TABLE KAMAR
                                     $kamar_tgl_bayar_selanjutnya = implode("-",$array_tanggal);
                                 // AKHIR
 
                                 // BUAT INVOICE PADA TABLE INVOICE
                                     $tagihan_baru = new tagihan;
                                     $tagihan_baru->user_id = $kamar->user_id;
                                     $tagihan_baru->kamar_id = $kamar->id;
                                     $tagihan_baru->nomor_kamar = $kamar->nomor; 
                                     $tagihan_baru->tipe_pembayaran = $kamar->tipe_pembayaran;
                                     $tagihan_baru->tgl_awal_sewa = $kamar->tgl_bayar_selanjutnya;
                                     $tagihan_baru->tgl_akhir_sewa = $kamar_tgl_bayar_selanjutnya;
                                     $tagihan_baru->status_tagihan = 'hutang';
                                     $tagihan_baru->nominal_pembayaran = $kamar->harga;
                                     $tagihan_baru->created_by = 'system';
                                     $tagihan_baru->save();
                                 // AKHIR
 
                                 // PERBARUI TABLE KAMARS
                                     $kamar->tgl_awal_sewa = $kamar->tgl_bayar_selanjutnya;
                                     $kamar->tgl_bayar_selanjutnya = $kamar_tgl_bayar_selanjutnya;
                                     $kamar->status_pembayaran = 'hutang';
                                     $kamar->save();
                                 // AKHIR
                                 
                                 // MEMBERIKAN NOTIFIKASI KEPADA USERS
                                     $text = '{"title" : "Tagihan Kamar","text" : "Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran", "type" : "common"}';
         
                                     $user->notify(new UserNotification($text));
                                 // AKHIR
                                 
                                 // PEMBUATAN NOTIFIKASI EMAIL UNTUK USER
                                     $data = [
                                         'name' => $user->name,
                                         'kamar' => $kamar->nomor,
                                         'tgl_awal' => $tagihan_baru->tgl_awal_sewa,
                                         'tgl_akhir' => date('Y-m-d',strtotime($tagihan_baru->tgl_akhir_sewa)),
                                         'harga' => $kamar->harga,
                                         'deadline' => date('Y-m-d', strtotime($tagihan_baru->tgl_awal_sewa.' +'.$setting_deadline->value.' days')),
                                     ];
                                     
                                     \Mail::to($user->email)->send(new NotifUser($data));
                                     sleep(1);
                                     
                                     echo "sukses ".$index."USER ".$user->username." \n";
                                     
                                 // AKHIR

                                 // MEMASUKKAN DATA USER YANG DIBERIKAN TAGIHAN KE VARIABLE SUKSES YANG AKAN DIBERIKAN KE PADA ADMIN
                                     $sukses[] = $data;
                                 // AKHIR
                         }
                     }
               }
                 // MENGIRIMKAN EMAIL KE PADA ADMIN
                     // MENCARI ADMIN
                         $admin = User::where('role','admin')->first();

                         \Mail::to($admin->email)->send(new NotifAdmin($sukses));
                         sleep(1);
                         echo "\n SUKSES KIRIM KE ADMIN ".$admin->name;
                     // AKHIR
                 // AKHIR
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

        
        
