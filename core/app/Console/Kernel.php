<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\DB;

use App\Kamar;
use App\Tagihan;

// MEMASTIKAN MENGGUNAKAN WAKTU WITA

class Kernel extends ConsoleKernel
{
    
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        //
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {   
        // MEMASTIKAN ZONA WAKTU YANG DIGUNAKAN ASIA MAKASSAR (WITA)
            date_default_timezone_set(config('global.timezone'));

        $schedule->call(function()
        {   
            
            // MENGAMBIL WAKTU SEKARANG
            $current_date = date_create('2021-03-01');
            // AKHIR
            
            // MENGAMBIL SEMUA KAMAR DAN MEMBANDINGKANNYA
                /* APABILA ADA KAMAR YANG TANGGAL 'BAYAR SELANJUTNYA' MELEWATI HARI INI MAKA
                PROGRAM AKAN MENGUBAH BAYAR SELANJUTNYA KE TANGGAL YANG SAMA BULAN DEPAN UNTUK KOST
                BULANAN DAN TAHUN DEPAN TANGGAL YANG SAMA TAHUN DEPAN*/
                
                // GET SEMUA DATA KAMAR DAN MEMBANDINGKAN
                    $kamars = Kamar::whereNotNull('user_id')->orderBy('id')->get();
                    
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
                            if($diff < 0 )
                            {   
                                // MENGAMBIL TANGGAL BAYAR TERAKHIR PENYEWA KOS DAN MEMECAH MENJADI ARRAY
                                    $array_tanggal_awal_sewa = array_map('intval', explode("-",$kamar->tgl_mulai_sewa));
                                    $array_tanggal = array_map('intval', explode("-",$kamar->tgl_bayar_selanjutnya));
                                    // UBAH TANGGAL KE AWAL USER SEWA
                                    $array_tanggal[2] = $array_tanggal_awal_sewa[2];
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
                                    // TAHUNAN SIMPLE TINGGAL TAMBAH 1
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
                                        $tagihan_baru->tipe_pembayaran = $kamar->tipe_pembayaran;
                                        $tagihan_baru->tgl_awal_sewa = $kamar->tgl_awal_sewa;
                                        $tagihan_baru->tgl_akhir_sewa = $kamar->tgl_bayar_selanjutnya;
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
                            }
                        }
                        echo "sukses ".$index." \n";
                    }

        });
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
