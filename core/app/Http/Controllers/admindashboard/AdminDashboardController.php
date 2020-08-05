<?php

namespace App\Http\Controllers\admindashboard;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\User;
use App\Kamar;
use App\Tagihan;

class AdminDashboardController extends Controller
{
    public function index()
    {   
        // MENGAMBIL DATA USER DI DALAM SISTEM
            $users = User::all();
            $user_aktif = $users->where('deleted_by_admin',0)->where('role','user')->count();
            $user_denied = $users->where('deleted_by_admin',1)->where('role','user')->count();
            $users = $users->where('deleted_by_admin',0)->where('role','user')->count();
        // AKHIR

        // MENGAMBIL DATA KAMAR DI DALAM SISTEM
            $kamars = Kamar::all();
            $kamar_disewa = $kamars->where('user_id','!=',null)->count();
            $kamars = $kamars->count();
        // AKHIR

        // DATA TAGIHAN
            $tagihans =  Tagihan::all();
            $tagihan_hutang = $tagihans->where('status_tagihan','hutang')->count();
            $tagihan_terbayar = $tagihans->where('status_tagihan','lunas')->count();
            $tagihans = $tagihans->count();
        // AKHIR

        // PEMASUKAN
            $pemasukans = DB::select('SELECT SUM(nominal_pembayaran) as total_pemasukan FROM tagihans WHERE tagihans.`status_tagihan` = "lunas"');
            $pemasukan_belum_dibayar = DB::select('SELECT SUM(nominal_pembayaran) as total_pemasukan_belum_dibayar FROM tagihans WHERE tagihans.`status_tagihan` = "hutang"');
        // AKHIR

        // KATA BIJAK HEHE
            $array_kata = [
                '"Setiap fase yang kamu jalani harus bisa mendatangkan pelajaran untuk naik ke fase berikutnya" <br><br> - Merry Riana -',

                '"Keuntungan dan kerugian adalah dua sisi dari satu koin yang sama. Terlalu takut rugi sama dengan menjauhi keuntungan." <br><br> - Mario Teguh -',

                '"Saya tidak berbicara dengan kata mungkin" <br><br> - Abdurahman Wahid -',

                '"Anda tidak bisa pergi dari tanggungjawab esok hari dengan menghindarinya hari ini" <br><br> - Abraham Lincoln -',

                '"Anda ingin mengetahui siapa diri Anda? Jangan bertanya. Beraksilah!" <br><br> - Thomas Jefferson -',

                '"Arahkan mata Anda pada bintang-bintang dengan kaki tetap berpijak pada tanah." <br><br> - Theodore Roosevelt -',

                '"Pekerjaan-pekerjaan kecil yg selesai dilakukan lebih baik daripada rencana-rencana besar yg hanya didiskusikan." <br><br> - Peter Marshall -',

                '"Sukses adalah saat persiapan dan kesempatan bertemu.." <br><br> - Bobby Unser -',
                '"Sebuah mangga dinilai bukan dari bentuknya tapi dari rasanya" <br><br> -{Mahabharata} Bisma Yang Agung -',
                '"Sebuah pemikiran menghasilkan keputusan, sebuah sumpah menghasilkan kesetiaan." <br><br> -{Mahabharata} Putri Ghandari -',
                '"Dedaunan yang rontok tidak memastikan pohon itu mati." <br><br> -{Mahabharata} Raja Pandu -',

                '"Cinta seorang suami kepada istrinya terhubung dengan adanya keturunan." <br><br> -{Mahabharata} Raja Drestarasta -',
                '"Seorang anak adalah hasil dari buah cinta bukan hasil dari jatuh cinta." <br><br> -{Mahabharata} Raja Pandu -',
                '"Semakin lama sebuah pohon disinari matahari maka buahnya pun semakin manis." <br><br> -{Mahabharata} Pangeran Sangkuni -',
                '"Dedaunan yang rontok tidak memastikan pohon itu mati." <br><br> -{Mahabharata} Raja Pandu -',

                '"Air yang mengalir begitu deras, airnya tidak dapat diminum. Orang yang diselimuti kemarahan hatinya diselimuti dendam." <br><br> -{Mahabharata} Bisma Yang Agung -',
                '"Masalah dan solusi berkembang bersamaan." <br><br> -{Mahabharata} Krisna -',
                '"Akar yang terkubur di dalam tanah dan mencoba naik kepermukaan dia akan lenyap. Akar tidak mungkin menjadi pohon." <br><br> -{Mahabharata} Ucapan kaum ksatria -',
                '"Keahlian tanpa mempunyai strata akan sia-sia." <br><br> -{Mahabharata} Bisma Yang Agung -',
                '"Saat mutiara telah matang kerang akan membuka sendiri cangkangnya." <br><br> -{Mahabharata} Bisma Yang Agung -',

                '"i know what it\'s like to lose. to feel so desperately that you\'re right, yet to  Fail nonetheless. Dread it. Run from it. Destiny still arrives. Or should i say, i have ?" <br><br> -{Avengers infinity wars} Thanos -',
                '"The hardest choices require the strongest wills" <br><br> -{Avengers infinity wars} Thanos -',
                '"I ignored my destiny once i can not do that again. even for you im sorry little one" <br><br> -{Avengers infinity wars} Thanos -',
                '"Today i lost more than you can know, but now is not the time to mourn, now is not time at all" <br><br> -{Avengers infinity wars} Thanos -',
                '"I Love you 3000" <br><br> -{Avengers} Iron Man -',
                '"Target saya sekarang ada tiga. Uang, uang dan uang" <br><br> -Kang siomay-',
            ];

            $random_keys=array_rand($array_kata,1);
            $bijak = $array_kata[$random_keys];

        return view('admin/admindashboard/admindashboard',compact('user_aktif','users','user_denied','kamars','kamar_disewa','tagihans','tagihan_hutang','tagihan_terbayar','pemasukans','pemasukan_belum_dibayar','bijak'));
    }

    public function bijak()
    {
        // KATA BIJAK HEHE
        $array_kata = [
            '"Setiap fase yang kamu jalani harus bisa mendatangkan pelajaran untuk naik ke fase berikutnya" <br><br> - Merry Riana -',

            '"Keuntungan dan kerugian adalah dua sisi dari satu koin yang sama. Terlalu takut rugi sama dengan menjauhi keuntungan." <br><br> - Mario Teguh -',

            '"Saya tidak berbicara dengan kata mungkin" <br><br> - Abdurahman Wahid -',

            '"Anda tidak bisa pergi dari tanggungjawab esok hari dengan menghindarinya hari ini" <br><br> - Abraham Lincoln -',

            '"Anda ingin mengetahui siapa diri Anda? Jangan bertanya. Beraksilah!" <br><br> - Thomas Jefferson -',

            '"Arahkan mata Anda pada bintang-bintang dengan kaki tetap berpijak pada tanah." <br><br> - Theodore Roosevelt -',

            '"Pekerjaan-pekerjaan kecil yg selesai dilakukan lebih baik daripada rencana-rencana besar yg hanya didiskusikan." <br><br> - Peter Marshall -',

            '"Sukses adalah saat persiapan dan kesempatan bertemu.." <br><br> - Bobby Unser -',
            '"Sebuah mangga dinilai bukan dari bentuknya tapi dari rasanya" <br><br> -{Mahabharata} Bisma Yang Agung -',
            '"Sebuah pemikiran menghasilkan keputusan, sebuah sumpah menghasilkan kesetiaan." <br><br> -{Mahabharata} Putri Ghandari -',
            '"Dedaunan yang rontok tidak memastikan pohon itu mati." <br><br> -{Mahabharata} Raja Pandu -',

            '"Cinta seorang suami kepada istrinya terhubung dengan adanya keturunan." <br><br> -{Mahabharata} Raja Drestarasta -',
            '"Seorang anak adalah hasil dari buah cinta bukan hasil dari jatuh cinta." <br><br> -{Mahabharata} Raja Pandu -',
            '"Semakin lama sebuah pohon disinari matahari maka buahnya pun semakin manis." <br><br> -{Mahabharata} Pangeran Sangkuni -',
            '"Dedaunan yang rontok tidak memastikan pohon itu mati." <br><br> -{Mahabharata} Raja Pandu -',

            '"Air yang mengalir begitu deras, airnya tidak dapat diminum. Orang yang diselimuti kemarahan hatinya diselimuti dendam." <br><br> -{Mahabharata} Bisma Yang Agung -',
            '"Masalah dan solusi berkembang bersamaan." <br><br> -{Mahabharata} Krisna -',
            '"Akar yang terkubur di dalam tanah dan mencoba naik kepermukaan dia akan lenyap. Akar tidak mungkin menjadi pohon." <br><br> -{Mahabharata} Ucapan kaum ksatria -',
            '"Keahlian tanpa mempunyai strata akan sia-sia." <br><br> -{Mahabharata} Bisma Yang Agung -',
            '"Saat mutiara telah matang kerang akan membuka sendiri cangkangnya." <br><br> -{Mahabharata} Bisma Yang Agung -',

            '"i know what it\'s like to lose. to feel so desperately that you\'re right, yet to  Fail nonetheless. Dread it. Run from it. Destiny still arrives. Or should i say, i have ?" <br><br> -{Avengers infinity wars} Thanos -',
            '"The hardest choices require the strongest wills" <br><br> -{Avengers infinity wars} Thanos -',
            '"I ignored my destiny once i can not do that again. even for you im sorry little one" <br><br> -{Avengers infinity wars} Thanos -',
            '"Today i lost more than you can know, but now is not the time to mourn, now is not time at all" <br><br> -{Avengers infinity wars} Thanos -',
            '"I Love you 3000" <br><br> -{Avengers} Iron Man -',
            '"Target saya sekarang ada tiga. Uang, uang dan uang" <br><br> -Kang siomay-',
        ];

        $random_keys=array_rand($array_kata,1);
        $bijak = $array_kata[$random_keys];

        return $bijak;
    }
}
