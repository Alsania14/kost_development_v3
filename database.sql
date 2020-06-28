/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.1.38-MariaDB : Database - db_kost_development
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `dummies` */

DROP TABLE IF EXISTS `dummies`;

CREATE TABLE `dummies` (
  `text` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `dummies` */

/*Table structure for table `kamars` */

DROP TABLE IF EXISTS `kamars`;

CREATE TABLE `kamars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `nomor` tinyint(4) NOT NULL,
  `tipe_pembayaran` enum('bulan','tahun') DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `tgl_mulai_sewa` date NOT NULL,
  `tgl_awal_sewa` date DEFAULT NULL,
  `tgl_bayar_selanjutnya` date DEFAULT NULL,
  `status_pembayaran` enum('lunas','hutang') DEFAULT NULL,
  `keluhan` enum('ada','tidak') DEFAULT 'tidak',
  `auto_tagih` enum('on','off') DEFAULT 'on',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `kamars_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `kamars` */

insert  into `kamars`(`id`,`user_id`,`nomor`,`tipe_pembayaran`,`harga`,`tgl_mulai_sewa`,`tgl_awal_sewa`,`tgl_bayar_selanjutnya`,`status_pembayaran`,`keluhan`,`auto_tagih`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,1,'bulan',500001,'2020-01-02','2020-02-02','2020-03-02','hutang','tidak','on','2020-06-18 17:44:30','2020-06-27 12:34:46',NULL),
(2,2,2,'bulan',500002,'2020-01-31','2020-02-29','2020-03-31','hutang','tidak','on','2020-06-19 20:53:37','2020-06-27 12:34:47',NULL),
(3,3,3,'bulan',500003,'2020-01-15','2020-02-15','2020-03-15','hutang','tidak','on','2020-06-25 11:51:37','2020-06-27 12:34:47',NULL),
(4,4,4,'bulan',500004,'2020-01-31','2020-02-29','2020-03-31','hutang','tidak','on','2020-06-25 11:52:45','2020-06-27 12:34:47',NULL),
(5,5,5,'bulan',500005,'2020-01-16','2020-02-16','2020-03-16','hutang','tidak','on',NULL,'2020-06-27 12:34:47',NULL);

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2020_06_17_085717_create_notifications_table',1);

/*Table structure for table `reward_payment` */

DROP TABLE IF EXISTS `reward_payment`;

CREATE TABLE `reward_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reward_id` int(11) NOT NULL,
  `nominal` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updateed_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reward_payment` */

/*Table structure for table `rewards` */

DROP TABLE IF EXISTS `rewards`;

CREATE TABLE `rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `status_claim` enum('empty','claimable','claimed','pending','rejected') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rewards` */

/*Table structure for table `tagihans` */

DROP TABLE IF EXISTS `tagihans`;

CREATE TABLE `tagihans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `kamar_id` int(11) NOT NULL,
  `tipe_pembayaran` enum('bulan','tahun') NOT NULL,
  `tgl_awal_sewa` date NOT NULL,
  `tgl_akhir_sewa` date NOT NULL,
  `status_tagihan` enum('hutang','lunas') DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `nominal_pembayaran` int(11) DEFAULT NULL,
  `created_by` enum('admin','system') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by_user` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `kamar_id` (`kamar_id`),
  CONSTRAINT `tagihans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tagihans_ibfk_2` FOREIGN KEY (`kamar_id`) REFERENCES `kamars` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

/*Table structure for table `transaksis` */

DROP TABLE IF EXISTS `transaksis`;

CREATE TABLE `transaksis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) NOT NULL,
  `transaction_id` varchar(200) DEFAULT NULL,
  `tagihan_id` int(11) NOT NULL,
  `tgl_awal` date NOT NULL,
  `tgl_akir` date NOT NULL,
  `nominal` int(11) NOT NULL,
  `via` enum('manual','bank_transfer','kedai') NOT NULL,
  `integration_name` enum('mandiri','bca','permata','bni','indomaret','alfamart','manual') DEFAULT NULL,
  `status_pembayaran` enum('proses','pending','expired','rejected','approved') DEFAULT NULL,
  `bukti_transaksi` varchar(200) DEFAULT NULL,
  `field_1` varchar(100) DEFAULT NULL,
  `field_2` varchar(100) DEFAULT NULL,
  `tgl_lunas` date DEFAULT NULL,
  `developer_information_charge` text,
  `developer_information_finish` text,
  `developer_information_last_notification` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by_user` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `transaksis` */

/*Table structure for table `user_notifications` */

DROP TABLE IF EXISTS `user_notifications`;

CREATE TABLE `user_notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_notifications` */

insert  into `user_notifications`(`id`,`type`,`notifiable_type`,`notifiable_id`,`data`,`read_at`,`created_at`,`updated_at`) values 
('0084656a-3c18-4120-8d2d-8a948810d676','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:35:18','2020-06-26 22:35:18'),
('01679a13-aa45-4a9e-80ee-9c490ff97329','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00016  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 21:56:19','2020-06-26 21:22:40','2020-06-26 21:56:19'),
('020b0d0a-ebdb-4936-a5e2-b60fd78ed9dc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:15:46','2020-06-26 22:15:46'),
('0d77fc17-8b62-4470-9640-463b20ec6737','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VII-00024  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:49:04','2020-06-27 11:49:04'),
('1660f515-903b-46d0-8c9f-1c5f2b2bfca3','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00004  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:44:58','2020-06-26 22:27:43'),
('1a7da97a-af3d-42d3-909d-6962e2dbb0e4','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00013  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:44:12','2020-06-26 22:44:12'),
('211a28af-2c68-43ee-998d-cfb15a295774','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00016  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 10:51:28','2020-06-27 10:51:28'),
('26f17444-3514-455f-be98-ac23d0f8906d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00004  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:43:54','2020-06-26 22:27:43'),
('2894c06f-1822-45c1-aa8b-f185863aed5a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00007  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:52:28','2020-06-26 22:27:43'),
('28d8721b-9a06-4a7b-a6e9-de8eb3b9992b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00009  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:24:19','2020-06-26 22:12:09'),
('2bf10ea3-5841-4a5d-9133-1b2e3256f64e','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00006  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-06-26 22:27:43','2020-06-26 19:50:44','2020-06-26 22:27:43'),
('2e771a9a-f581-4646-b2c8-c520c41a5b62','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00014  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-06-26 22:12:09','2020-06-26 20:38:12','2020-06-26 22:12:09'),
('305d85ba-47fc-4276-8fd0-55b34f834e3e','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00018  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-06-26 21:56:19','2020-06-26 21:22:59','2020-06-26 21:56:19'),
('34a7a07c-39cd-46ba-bf62-b69fb716a7af','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00009  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:30:41','2020-06-26 22:30:41'),
('36813638-a211-4036-b89e-0eefffc25c68','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-06-27 12:34:47','2020-06-27 12:34:47'),
('38054e10-a254-496f-aba6-edbe6b357675','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00013  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:43:03','2020-06-26 22:43:03'),
('3a78d29d-1fe0-49c1-8991-b3eb353a9a53','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-06-27 12:34:47','2020-06-27 12:34:47'),
('3b3e701f-7e95-4032-a891-fed152ac73d8','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00002  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:00:17','2020-06-26 22:00:17'),
('3c7f3c50-45a0-443e-963b-41e002d822e0','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 19:40:38','2020-06-26 19:18:19','2020-06-26 19:40:38'),
('405b03ca-5658-4425-a0ec-35f06c2bb9e0','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00014  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 23:30:19','2020-06-26 23:30:19'),
('422bd7fe-94d8-4f6c-b38f-7f6f51cd96de','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00011  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:37:19','2020-06-26 22:12:09'),
('45217148-0da5-4398-b43b-70892a2303ba','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00012  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:39:26','2020-06-26 22:39:26'),
('46b82068-b94e-406f-aa2f-cc9e44455ef6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:44:05','2020-06-26 22:27:43'),
('472176d9-22cc-4cc5-941c-51ed241ab262','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00014  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:37:26','2020-06-26 22:12:09'),
('4a436a9f-79da-4d32-8b26-aff35cd0d59f','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00017  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 21:56:19','2020-06-26 21:23:10','2020-06-26 21:56:19'),
('4b8f6d35-1a3e-46aa-acaf-5382387c7363','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:50:28','2020-06-26 22:27:43'),
('4d0c34a9-4a4c-43ef-8590-65a13c22f1c8','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00017  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 21:56:19','2020-06-26 21:22:11','2020-06-26 21:56:19'),
('5a0f2c3c-df56-4994-aed8-9f4a14cb5187','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00006  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:16:18','2020-06-26 22:16:18'),
('5ac0cebf-c0c9-4795-a413-16380824b6e5','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VII-00021  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:39:06','2020-06-27 11:39:06'),
('5afcddac-c4ea-4741-9beb-81fbc67e3169','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00005  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:45:08','2020-06-26 22:27:43'),
('5ee5106f-e0d3-4801-a876-917547e312d1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:37:29','2020-06-26 22:37:29'),
('63e6ea16-f350-4b42-8a10-f06d507f036b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:29:32','2020-06-26 22:29:32'),
('680b8358-6fde-43e6-b74f-c1adce7c3788','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00012  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:37:19','2020-06-26 22:12:09'),
('6b0367f0-d7f1-4f41-8283-74e262701319','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00010  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:30:29','2020-06-26 22:12:09'),
('6d17da07-98be-4b13-9bfd-e4b424c52a5e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00005  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:13:21','2020-06-26 22:13:21'),
('6ea187e2-67d6-4511-9ef4-58abf194689a','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00012  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:36:12','2020-06-26 22:12:09'),
('73c0c0f4-9965-44c2-962e-c2d5a8531c91','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-06-27 12:34:47','2020-06-27 12:34:47'),
('76b5fb3b-8eaa-44dc-82e4-45091f4eb045','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 21:20:22','2020-06-26 16:45:07','2020-06-26 21:20:22'),
('7de1171a-a387-47d8-bb84-899be52089e7','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00008  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:23:30','2020-06-26 22:23:30'),
('7ec1b88e-f430-4eba-8e36-5087dd3acf3b','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VI-00019  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:11:15','2020-06-27 11:11:15'),
('828b75d1-fbe7-45fd-9aea-0ad75f04205d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-06-27 12:34:47','2020-06-27 12:34:47'),
('838c31d8-3a55-47c8-a8c2-8dbdc85c0150','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00010  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:35:39','2020-06-26 22:35:39'),
('86e2cd6d-24f2-4ce4-9ec3-3138af7a48a4','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00001  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 21:59:40','2020-06-26 21:59:40'),
('8bedcf2e-4901-4a33-a627-dba2e17be21a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-II-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 21:20:22','2020-06-26 16:42:54','2020-06-26 21:20:22'),
('8c2c1b70-8fdc-4e30-ac17-86cdcc912cfd','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:36:11','2020-06-26 22:12:09'),
('8df68688-d893-4406-88c6-995e9acdbb8f','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:18:41','2020-06-26 22:18:41'),
('90332581-c154-4048-bc4d-29e150b2ddc9','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:12:18','2020-06-26 22:12:18'),
('910b60f8-9e58-4073-a555-137446a9431d','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00014  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 23:29:58','2020-06-26 23:29:58'),
('924131c3-961c-4593-9717-27b2167b75ab','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00012  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:39:42','2020-06-26 22:39:42'),
('97f015d5-52ee-4ff8-8b0e-30c9b91498ea','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:23:03','2020-06-26 22:23:03'),
('9a188ffa-452e-4f8f-85d7-86584e7c8ebc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00007  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:19:40','2020-06-26 22:19:40'),
('9a638024-1d27-4c1a-917b-c0e7d6e0bdca','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00017  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 10:55:20','2020-06-27 10:55:20'),
('9c424dbd-1cb3-4ede-b36b-6be9ef47c34f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-III-00008  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-06-26 22:27:43','2020-06-26 19:59:24','2020-06-26 22:27:43'),
('9e08f4ab-b294-47d8-83de-5ca96a06a91a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:51:19','2020-06-26 22:27:43'),
('a1e1aa07-d4ed-4af1-89c0-9e81a0127671','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VI-00018  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:09:36','2020-06-27 11:09:36'),
('a348fe10-fddd-4e32-8c07-98dc6249c975','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID 00020  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:23:47','2020-06-27 11:23:47'),
('ad51a5dd-b59b-4948-9008-08284b8d227b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:27:43','2020-06-26 19:59:09','2020-06-26 22:27:43'),
('b177b91d-34d6-4f6c-a8a8-f8de93f156bc','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:02:55','2020-06-26 22:02:55'),
('b4f0726c-a973-418d-8960-dfc2faaf8eab','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00018  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 21:56:19','2020-06-26 21:22:32','2020-06-26 21:56:19'),
('b6465279-4de6-418a-8efa-a35cccff9e10','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:36:12','2020-06-26 22:12:09'),
('c20f41a3-9353-4fe1-9ba1-9aa31e9671fb','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00004  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:06:08','2020-06-26 22:06:08'),
('c4d49986-5c60-4e17-8b96-9655fc6a59d5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00011  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:38:31','2020-06-26 22:38:31'),
('c4e05d4d-a477-4369-bb28-598b57fb8384','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-VII-00022  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-27 11:42:02','2020-06-27 11:42:02'),
('c6226067-b385-44f3-b4df-7ab802e0b80f','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00015  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-06-26 22:12:09','2020-06-26 20:46:47','2020-06-26 22:12:09'),
('cc3ddd53-c160-44d3-b5da-59fa5e238595','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-VII-00024  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-27 11:49:31','2020-06-27 11:49:31'),
('ce47f6be-9f2b-45fb-9a6e-b4184562892c','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00015  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:46:22','2020-06-26 22:12:09'),
('cfef1ac8-8d7c-4f76-ae6c-419b080c3b6b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00003  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-26 22:04:01','2020-06-26 22:04:01'),
('d11f09d6-1ca9-4ae8-a3ef-dd6b4f5b0e0c','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VII-00022  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:40:57','2020-06-27 11:40:57'),
('d273a973-c40b-46c2-a125-631e3d33460a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00004  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 22:06:22','2020-06-26 22:06:22'),
('d80a84f3-6fdf-4a08-b502-2542cb4f96e1','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-IV-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:29:21','2020-06-26 22:12:09'),
('dbfd908d-e4bd-414e-9262-3e2022014d17','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00015  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 23:47:30','2020-06-26 23:47:30'),
('dcdbbdf4-4a84-4031-bc0b-cc83fbeeeb83','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-V-00015  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-06-26 23:47:46','2020-06-26 23:47:46'),
('de296721-7fe9-40c7-ac85-41604806e399','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00016  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 21:56:19','2020-06-26 21:21:36','2020-06-26 21:56:19'),
('eb63c86f-4fb1-435c-9154-1972a86234ce','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 22:00:04','2020-06-26 22:00:04'),
('ef1bb3c2-6cf8-4563-8f98-92319f6e0252','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-III-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:23:15','2020-06-26 22:12:09'),
('f44fcc64-d919-49a3-a5ed-74572afe8de7','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-V-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-26 21:58:36','2020-06-26 21:58:36'),
('f48bd8df-7928-4aa5-a685-b0493308e48e','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-VII-00023  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-27 11:41:55','2020-06-27 11:41:55'),
('f4938ae5-f078-4f17-b90a-96906c63f70e','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-06-27 12:34:47','2020-06-27 12:34:47'),
('f858d691-4165-4718-a316-7d2a45dd8ed3','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-VII-00023  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-06-27 11:43:02','2020-06-27 11:43:02'),
('fec7e50d-cfdb-491a-9621-64c9557c3a29','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-IV-00011  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-06-26 22:12:09','2020-06-26 20:37:19','2020-06-26 22:12:09');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `pelaporan` tinyint(4) NOT NULL DEFAULT '0',
  `kode_invitation` varchar(10) NOT NULL,
  `reward` tinyint(4) NOT NULL DEFAULT '0',
  `verify_admin` tinyint(4) DEFAULT '0',
  `image` varchar(200) DEFAULT 'default.png',
  `nomor_hp` varchar(20) DEFAULT NULL,
  `ktp` varchar(150) DEFAULT 'ktp_default.jpg',
  `role` enum('user','admin') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`email`,`password`,`pelaporan`,`kode_invitation`,`reward`,`verify_admin`,`image`,`nomor_hp`,`ktp`,`role`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'user 1','user_1','user_1@gmail.com','$2y$10$kGbW4KKow.8DfBwGUz8VA.5IaSIbyopxBAXftBUNjwnHDcPWo4qZa',0,'ce572',0,1,'default.png',NULL,'ktp_default.jpg','user','2020-06-25 03:38:01','2020-06-25 03:38:01',NULL),
(2,'user 2','user_2','user_2@gmail.com','$2y$10$ESUdj.MMLK7LDqZdCOfoQ.k5y5sFmPHwu8A9GWs5etRiIhURNl4wq',0,'1b4r4',0,1,'default.png',NULL,'ktp_default.jpg','user','2020-06-25 03:38:32','2020-06-25 03:38:32',NULL),
(3,'user 3','user_3','user_3@gmail.com','$2y$10$dGkKi2/csJhdapLWr1HVMOA7BH/61ITaQAy8TywNFNDA3iE9Ur6G.',0,'n0x0a',0,1,'default.png',NULL,'ktp_default.jpg','user','2020-06-25 03:39:04','2020-06-25 03:39:04',NULL),
(4,'user 4','user_4','user_4@gmail.com','$2y$10$xBWsx0AxxIw2YMckOioHIeA31v8ioxH/tVWZ9hWl761mNLhwVI9FW',0,'cjtj9',0,1,'default.png',NULL,'ktp_default.jpg','user','2020-06-25 03:39:36','2020-06-25 03:39:36',NULL),
(5,'user 5','user_5','user_5@gmail.com','$2y$10$0io2WQCJ4sgEzPUt7BidTecBSJsPeCxsta7apZ9ekKnLBI1KZXneO',0,'asui9',0,1,'default.png',NULL,'ktp_default.jpg','user','2020-06-25 03:40:13','2020-06-25 03:40:13',NULL),
(6,'alsan','alsan','alsan@gmail.com','$2y$10$eLpPrQzAMeo208WGeJ.Gau2kAgmmCKWTC1ERiZeLBccSyeBHJ0eDe',0,'seclx',0,1,'default.png',NULL,'ktp_default.jpg','admin','2020-06-25 03:40:49','2020-06-25 03:40:49',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
