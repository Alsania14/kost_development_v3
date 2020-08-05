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

/*Table structure for table `features` */

DROP TABLE IF EXISTS `features`;

CREATE TABLE `features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `features` */

insert  into `features`(`id`,`name`,`value`) values 
(1,'wifi_name','wifi@id'),
(2,'wifi_pass','hehe123');

/*Table structure for table `kamarimages` */

DROP TABLE IF EXISTS `kamarimages`;

CREATE TABLE `kamarimages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kamar_id` int(11) NOT NULL,
  `image` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by_admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `kamar_id` (`kamar_id`),
  CONSTRAINT `kamarimages_ibfk_1` FOREIGN KEY (`kamar_id`) REFERENCES `kamars` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `kamarimages` */

insert  into `kamarimages`(`id`,`kamar_id`,`image`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_admin`) values 
(1,1,'kamar_1.jpg','2020-07-06 12:41:43','2020-07-06 12:41:46',NULL,0),
(2,1,'kamar_2.jpg',NULL,NULL,NULL,0),
(3,1,'kamar_3.jpg',NULL,NULL,NULL,0),
(4,1,'kamar_4.jpg',NULL,NULL,NULL,0),
(5,1,'kamar_1.jpg',NULL,NULL,NULL,0);

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
  `auto_tagih` enum('on','off') DEFAULT 'on',
  `fasilitas` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `kamars_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `kamars` */

insert  into `kamars`(`id`,`user_id`,`nomor`,`tipe_pembayaran`,`harga`,`tgl_mulai_sewa`,`tgl_awal_sewa`,`tgl_bayar_selanjutnya`,`status_pembayaran`,`auto_tagih`,`fasilitas`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,1,'bulan',500001,'2020-01-02','2020-03-02','2020-04-02','hutang','on','Kamar Mandi Dalam, AC, TV, Wifi','2020-06-18 17:44:30','2020-07-27 13:07:07',NULL),
(2,2,2,'bulan',500002,'2020-01-31','2020-03-31','2020-04-30','hutang','on','Kamar Mandi Dalam, AC, TV, Wifi','2020-06-19 20:53:37','2020-07-27 13:07:18',NULL),
(3,3,3,'bulan',500003,'2020-01-15','2020-03-15','2020-04-15','hutang','on','Kamar Mandi Dalam, AC, TV, Wifi','2020-06-25 11:51:37','2020-07-27 13:07:32',NULL),
(4,4,4,'bulan',500004,'2020-01-31','2020-03-31','2020-04-30','hutang','on','Kamar Mandi Dalam, AC, TV, Wifi','2020-06-25 11:52:45','2020-07-27 13:07:53',NULL),
(5,5,5,'bulan',500005,'2020-01-16','2020-03-16','2020-04-16','hutang','on','Kamar Mandi Dalam, AC, TV, Wifi','2020-06-30 14:55:54','2020-07-27 13:08:03',NULL),
(6,NULL,6,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(7,NULL,7,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(8,NULL,8,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(9,NULL,9,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(10,NULL,10,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(11,NULL,11,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL),
(12,NULL,12,'tahun',9800000,'0000-00-00',NULL,NULL,NULL,'on','Kamar Mandi Dalam, AC, TV, Wifi',NULL,NULL,NULL);

/*Table structure for table `laporans` */

DROP TABLE IF EXISTS `laporans`;

CREATE TABLE `laporans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kamar_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `keluhan` varchar(200) DEFAULT NULL,
  `respon` varchar(200) DEFAULT 'belum ada respon',
  `status_keluhan` enum('terkirim','proses','selesai') DEFAULT NULL,
  `image_keluhan` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by_users` tinyint(4) DEFAULT '0',
  `deleted_by_admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `kamar_id` (`kamar_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `laporans_ibfk_1` FOREIGN KEY (`kamar_id`) REFERENCES `kamars` (`id`),
  CONSTRAINT `laporans_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `laporans` */

insert  into `laporans`(`id`,`kamar_id`,`user_id`,`keluhan`,`respon`,`status_keluhan`,`image_keluhan`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_users`,`deleted_by_admin`) values 
(1,4,4,'asdadasdasd','belum ada respon','terkirim','I2p5gdgSdX0GpfYIzC9BNZFBlKRTIGNWq3TiIsjW.jpeg','2020-07-01 13:31:31','2020-07-01 13:31:31',NULL,0,0),
(2,4,4,'adadawdwada','belum ada respon','terkirim','bMXtpCuWOM223BYm9Cz2F71dC1rmBX2cZFmD6mk0.jpeg','2020-07-01 13:38:43','2020-07-01 13:38:43',NULL,0,0),
(3,4,4,'asdasdasdasd','belum ada respon','terkirim',NULL,'2020-07-01 13:42:21','2020-07-01 13:42:21',NULL,0,0),
(4,4,4,NULL,'belum ada respon','terkirim',NULL,'2020-07-01 20:23:11','2020-07-01 20:23:11',NULL,0,0),
(5,4,4,'aku lagi pengeng','belum ada respon','terkirim',NULL,'2020-07-01 20:27:24','2020-07-01 20:27:24',NULL,0,0),
(6,4,4,'pengen eskrim min','belum ada respon','terkirim','lg9fPT6Qw3NKPD9FYi0sif19EMtHdbiASpGZU1hO.jpeg','2020-07-01 20:43:09','2020-07-01 20:43:09',NULL,0,0),
(7,4,4,'pengen banget eskrim min','belum ada respon','terkirim','iXmLTTLKBPdQnqcelOwOVSqrUIb1Fhs25OLNPHeK.jpeg','2020-07-01 20:45:30','2020-07-01 20:45:30',NULL,0,0),
(8,4,4,'pengen <','belum ada respon','terkirim','RKkv5TAgrivfTU7uUhhlgDEex0sTm4MNIslMWabP.jpeg','2020-07-01 20:46:16','2020-07-01 20:46:16',NULL,0,0),
(9,4,4,'pingin eskrim ini min','belum ada respon','terkirim','jauGikNbL0faFoXvMn4SrR1mwmnwjd59An3Xa5bT.jpeg','2020-07-01 20:58:01','2020-07-01 20:58:01',NULL,0,0),
(10,4,4,'asdasdad','belum ada respon','terkirim','RlWfE5spZJ7vBirQznXd9Bn7VIYR0dsz2dg5xTP8.jpeg','2020-07-01 21:00:31','2020-07-01 21:00:31',NULL,0,0),
(11,4,4,'adasdasd','belum ada respon','terkirim','AEUZFcZMOPPiGHoHWVjyynTJoJ1WcGVgs9nMk2DJ.jpeg','2020-07-01 21:01:11','2020-07-01 21:01:11',NULL,0,0),
(12,4,4,'adasdadad','belum ada respon','terkirim','4eXLQAAJqwbQtWJLswNBlRbwTZ2TaeTXRNTVSrzW.jpeg','2020-07-01 21:01:58','2020-07-01 21:01:58',NULL,0,0),
(13,4,4,'adasdasdsa','belum ada respon','terkirim','U5bnJsJlHO4vFfWKlvlHw1wUswAQAeGMTign45BE.jpeg','2020-07-01 21:03:06','2020-07-01 21:03:06',NULL,0,0),
(14,4,4,'adsadasdas','belum ada respon','terkirim',NULL,'2020-07-01 21:04:12','2020-07-01 21:04:12',NULL,0,0),
(15,4,4,'asdasdasd','belum ada respon','terkirim',NULL,'2020-07-01 21:07:41','2020-07-01 21:07:41',NULL,0,0);

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

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_setting` varchar(50) NOT NULL,
  `value` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `settings` */

insert  into `settings`(`id`,`name_setting`,`value`) values 
(1,'hari_penagihan',0),
(2,'deadline_pembayaran',5);

/*Table structure for table `tagihans` */

DROP TABLE IF EXISTS `tagihans`;

CREATE TABLE `tagihans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `kamar_id` int(11) NOT NULL,
  `tipe_pembayaran` enum('bulan','tahun') NOT NULL,
  `nomor_kamar` tinyint(4) DEFAULT NULL,
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
  `deleted_by_admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `kamar_id` (`kamar_id`),
  CONSTRAINT `tagihans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tagihans_ibfk_2` FOREIGN KEY (`kamar_id`) REFERENCES `kamars` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

insert  into `tagihans`(`id`,`user_id`,`kamar_id`,`tipe_pembayaran`,`nomor_kamar`,`tgl_awal_sewa`,`tgl_akhir_sewa`,`status_tagihan`,`tgl_pembayaran`,`nominal_pembayaran`,`created_by`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_user`,`deleted_by_admin`) values 
(1,1,1,'bulan',1,'2020-02-02','2020-03-02','lunas','2020-07-25',500001,'system','2020-07-23 14:56:16','2020-07-25 14:14:19',NULL,0,0),
(2,2,2,'bulan',2,'2020-02-29','2020-03-31','hutang',NULL,500002,'system','2020-07-23 14:56:20','2020-07-24 12:30:21',NULL,0,0),
(3,3,3,'bulan',3,'2020-02-15','2020-03-15','hutang',NULL,500003,'system','2020-07-23 14:56:24','2020-07-23 14:56:24',NULL,0,0),
(4,4,4,'bulan',4,'2020-02-29','2020-03-31','lunas','2020-07-25',500004,'system','2020-07-23 14:56:28','2020-07-25 14:36:32',NULL,0,0),
(5,5,5,'bulan',5,'2020-02-16','2020-03-16','hutang',NULL,500005,'system','2020-07-23 14:56:33','2020-07-24 12:35:18',NULL,0,0),
(6,1,1,'bulan',1,'2020-03-02','2020-04-02','hutang',NULL,500001,'system','2020-07-27 13:07:07','2020-07-27 13:07:07',NULL,0,0),
(7,2,2,'bulan',2,'2020-03-31','2020-04-30','hutang',NULL,500002,'system','2020-07-27 13:07:18','2020-07-27 13:07:18',NULL,0,0),
(8,3,3,'bulan',3,'2020-03-15','2020-04-15','hutang',NULL,500003,'system','2020-07-27 13:07:32','2020-07-27 13:07:32',NULL,0,0),
(9,4,4,'bulan',4,'2020-03-31','2020-04-30','hutang',NULL,500004,'system','2020-07-27 13:07:53','2020-07-27 13:07:53',NULL,0,0),
(10,5,5,'bulan',5,'2020-03-16','2020-04-16','hutang',NULL,500005,'system','2020-07-27 13:08:03','2020-07-27 13:08:03',NULL,0,0);

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
  `deleted_by_admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tagihan_id` (`tagihan_id`),
  CONSTRAINT `transaksis_ibfk_1` FOREIGN KEY (`tagihan_id`) REFERENCES `tagihans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `transaksis` */

insert  into `transaksis`(`id`,`order_id`,`transaction_id`,`tagihan_id`,`tgl_awal`,`tgl_akir`,`nominal`,`via`,`integration_name`,`status_pembayaran`,`bukti_transaksi`,`field_1`,`field_2`,`tgl_lunas`,`developer_information_charge`,`developer_information_finish`,`developer_information_last_notification`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_user`,`deleted_by_admin`) values 
(1,'TAC-ALPHA-I-III-00001','ca4a69e4-235f-4453-bcfc-8aa6a9c292d1',1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197456100821',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"ca4a69e4-235f-4453-bcfc-8aa6a9c292d1\",\"order_id\":\"TAC-ALPHA-I-III-00001\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-23 13:57:44\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197456100821\"}],\"fraud_status\":\"accept\"}',NULL,'{\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197456100821\"}],\"payment_amounts\":[],\"transaction_time\":\"2020-07-23 13:57:44\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"order_id\":\"TAC-ALPHA-I-III-00001\",\"payment_type\":\"bank_transfer\",\"signature_key\":\"1ba00ef81cca6656bfe1014ac761e2214f2b7ce536e677ee42e518842501aed89b9ecb7a549008c3015602f804c257cddb50fa9fdacbd94317fbbe58c71ef3ec\",\"status_code\":\"201\",\"transaction_id\":\"ca4a69e4-235f-4453-bcfc-8aa6a9c292d1\",\"transaction_status\":\"pending\",\"fraud_status\":\"accept\",\"status_message\":\"Success, transaction is found\",\"merchant_id\":\"G356931974\"}','2020-07-23 14:57:42','2020-07-24 12:45:37',NULL,0,1),
(2,'TAC-ALPHA-I-III-00002','41cf02c7-1309-42b7-b942-9eb58c223ef1',1,'2020-02-02','2020-03-02',500001,'bank_transfer','bca','rejected',NULL,'31974613235',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"41cf02c7-1309-42b7-b942-9eb58c223ef1\",\"order_id\":\"TAC-ALPHA-I-III-00002\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-23 13:57:49\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bca\",\"va_number\":\"31974613235\"}],\"fraud_status\":\"accept\"}',NULL,'{\"va_numbers\":[{\"va_number\":\"31974613235\",\"bank\":\"bca\"}],\"transaction_time\":\"2020-07-23 13:57:49\",\"transaction_status\":\"cancel\",\"transaction_id\":\"41cf02c7-1309-42b7-b942-9eb58c223ef1\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"202\",\"signature_key\":\"eb7f2fae88254cb37aed9a1d0716db487b4f332c9d32aa7e5a3083bce96515a6ba83bee7dd1e1844b8401c4e560e828bd78b9961d65de8f6a8d58a652e2f026d\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"TAC-ALPHA-I-III-00002\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','2020-07-23 14:57:47','2020-07-24 12:49:37',NULL,0,1),
(3,'TAC-ALPHA-I-III-00003','3baf1f0c-f66c-4321-93df-a01d40d6308d',1,'2020-02-02','2020-03-02',500001,'kedai','alfamart','rejected',NULL,'3569137582155930',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, cstore transaction is successful\",\"transaction_id\":\"3baf1f0c-f66c-4321-93df-a01d40d6308d\",\"order_id\":\"TAC-ALPHA-I-III-00003\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"cstore\",\"transaction_time\":\"2020-07-23 13:57:54\",\"transaction_status\":\"pending\",\"fraud_status\":\"accept\",\"payment_code\":\"3569137582155930\",\"store\":\"alfamart\"}',NULL,'{\"transaction_time\":\"2020-07-23 13:57:54\",\"transaction_status\":\"cancel\",\"transaction_id\":\"3baf1f0c-f66c-4321-93df-a01d40d6308d\",\"store\":\"alfamart\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"202\",\"signature_key\":\"149aab59a51caf6b46b8f389fc18d9c3ee3f1b0cac1a8cde32fadb598ba6898353ae9c8c42b7878198027e6dd2233c5b342ff347d50fd128b43c600a5e2b24e9\",\"payment_type\":\"cstore\",\"payment_code\":\"3569137582155930\",\"order_id\":\"TAC-ALPHA-I-III-00003\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','2020-07-23 14:57:53','2020-07-24 12:50:30',NULL,0,1),
(4,'TAC-ALPHA-I-III-M-00004',NULL,1,'2020-02-02','2020-03-02',500001,'manual','manual','pending','7cj1mMgAmTGBfZl6htHDr822r5z10Xa2EGTLDhLE.jpeg',NULL,NULL,NULL,NULL,NULL,NULL,'2020-07-23 14:57:57','2020-07-24 13:08:06',NULL,0,1),
(5,'TAC-ALPHA-I-III-00005','dfefdace-57a8-441e-911d-537f97fd08ab',1,'2020-02-02','2020-03-02',500001,'bank_transfer','mandiri','pending',NULL,'39658715853','70012',NULL,'{\"status_code\":\"201\",\"status_message\":\"OK, Mandiri Bill transaction is successful\",\"transaction_id\":\"dfefdace-57a8-441e-911d-537f97fd08ab\",\"order_id\":\"TAC-ALPHA-I-III-00005\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"echannel\",\"transaction_time\":\"2020-07-23 13:58:35\",\"transaction_status\":\"pending\",\"fraud_status\":\"accept\",\"bill_key\":\"39658715853\",\"biller_code\":\"70012\"}',NULL,'{\"payment_type\":\"echannel\",\"bill_key\":\"39658715853\",\"biller_code\":\"70012\",\"transaction_time\":\"2020-07-23 13:58:35\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"order_id\":\"TAC-ALPHA-I-III-00005\",\"signature_key\":\"6a3de2cd8dee397457e4e27ce104eedefd3ed3e3e9df138af3e34c4c011efbcc536e0f70871b5985909eadc0170c2ac487d0cc0d8d415cdc1c22f2460eeab2b5\",\"status_code\":\"201\",\"transaction_id\":\"dfefdace-57a8-441e-911d-537f97fd08ab\",\"transaction_status\":\"pending\",\"fraud_status\":\"accept\",\"status_message\":\"Success, transaction is found\",\"merchant_id\":\"G356931974\"}','2020-07-23 14:58:34','2020-07-25 13:51:29',NULL,0,1),
(6,'TAC-ALPHA-I-III-00006','af683246-6f29-4bf6-8382-f11d3601aa66',1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','approved',NULL,'9883197469979114',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"af683246-6f29-4bf6-8382-f11d3601aa66\",\"order_id\":\"TAC-ALPHA-I-III-00006\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-25 13:06:14\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197469979114\"}],\"fraud_status\":\"accept\"}','{\"va_numbers\":[{\"va_number\":\"9883197469979114\",\"bank\":\"bni\"}],\"transaction_time\":\"2020-07-25 13:06:14\",\"transaction_status\":\"settlement\",\"transaction_id\":\"af683246-6f29-4bf6-8382-f11d3601aa66\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"7b0f32d3d3c74dfb7befca8c8a5508c18de097bc52601c27e2ac43cd9268c0c424d15ed5a782092d24971b7e0b6188143224df390f890614c2a580d6c8fccf82\",\"settlement_time\":\"2020-07-25 13:14:18\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[{\"paid_at\":\"2020-07-25 13:14:17\",\"amount\":\"500001.00\"}],\"order_id\":\"TAC-ALPHA-I-III-00006\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','{\"va_numbers\":[{\"va_number\":\"9883197469979114\",\"bank\":\"bni\"}],\"transaction_time\":\"2020-07-25 13:06:14\",\"transaction_status\":\"settlement\",\"transaction_id\":\"af683246-6f29-4bf6-8382-f11d3601aa66\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"7b0f32d3d3c74dfb7befca8c8a5508c18de097bc52601c27e2ac43cd9268c0c424d15ed5a782092d24971b7e0b6188143224df390f890614c2a580d6c8fccf82\",\"settlement_time\":\"2020-07-25 13:14:18\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[{\"paid_at\":\"2020-07-25 13:14:17\",\"amount\":\"500001.00\"}],\"order_id\":\"TAC-ALPHA-I-III-00006\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','2020-07-25 14:06:14','2020-07-25 14:14:19',NULL,0,0),
(7,'TAC-ALPHA-I-III-00007','227bb0bc-2a9f-4320-bea4-97b1a0c7ee9d',1,'2020-02-02','2020-03-02',500001,'bank_transfer','bca','approved',NULL,'31974635646',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"227bb0bc-2a9f-4320-bea4-97b1a0c7ee9d\",\"order_id\":\"TAC-ALPHA-I-III-00007\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-25 13:11:00\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bca\",\"va_number\":\"31974635646\"}],\"fraud_status\":\"accept\"}',NULL,'{\"va_numbers\":[{\"va_number\":\"31974635646\",\"bank\":\"bca\"}],\"transaction_time\":\"2020-07-25 13:11:00\",\"transaction_status\":\"cancel\",\"transaction_id\":\"227bb0bc-2a9f-4320-bea4-97b1a0c7ee9d\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"202\",\"signature_key\":\"10f387c633f3e1b7a784c9357fa7dea2ee2f4a2825a5dcab7613f0a060a1b46653504ec8d51ae648c34953027dbfe1c2349022e780fba9e61d92907a1c3d9d06\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"TAC-ALPHA-I-III-00007\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','2020-07-25 14:11:00','2020-07-25 14:16:22',NULL,0,1),
(8,'TAC-ALPHA-I-III-00008','d069e3e6-24e1-4754-b6ae-ce25f18cb340',4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','pending',NULL,'9883197465487921',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"d069e3e6-24e1-4754-b6ae-ce25f18cb340\",\"order_id\":\"TAC-ALPHA-I-III-00008\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-25 13:34:48\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197465487921\"}],\"fraud_status\":\"accept\"}',NULL,'{\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197465487921\"}],\"payment_amounts\":[],\"transaction_time\":\"2020-07-25 13:34:48\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"order_id\":\"TAC-ALPHA-I-III-00008\",\"payment_type\":\"bank_transfer\",\"signature_key\":\"d96ae4ca3514a5f826def0c495ac6e8a1ea1bb5508969dd91917235b48cb4cbfdd03673516db8758596b7fc4d26bef750b6c347dd8059f37871bed5ab85ea4ce\",\"status_code\":\"201\",\"transaction_id\":\"d069e3e6-24e1-4754-b6ae-ce25f18cb340\",\"transaction_status\":\"pending\",\"fraud_status\":\"accept\",\"status_message\":\"Success, transaction is found\",\"merchant_id\":\"G356931974\"}','2020-07-25 14:34:48','2020-07-25 14:36:19',NULL,0,0),
(9,'TAC-ALPHA-I-III-00009','ffd05bb9-366b-4265-ad18-85e7947f6222',4,'2020-02-29','2020-03-31',500004,'bank_transfer','permata','approved',NULL,'319000691931030',NULL,NULL,'{\n  \"status_code\" : \"201\",\n  \"status_message\" : \"Success, PERMATA VA transaction is successful\",\n  \"transaction_id\" : \"ffd05bb9-366b-4265-ad18-85e7947f6222\",\n  \"order_id\" : \"TAC-ALPHA-I-III-00009\",\n  \"gross_amount\" : \"500004.00\",\n  \"currency\" : \"IDR\",\n  \"payment_type\" : \"bank_transfer\",\n  \"transaction_time\" : \"2020-07-25 13:35:15\",\n  \"transaction_status\" : \"pending\",\n  \"fraud_status\" : \"accept\",\n  \"permata_va_number\" : \"319000691931030\",\n  \"merchant_id\" : \"G356931974\"\n}','{\"transaction_time\":\"2020-07-25 13:35:15\",\"transaction_status\":\"settlement\",\"transaction_id\":\"ffd05bb9-366b-4265-ad18-85e7947f6222\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"2484f6a62eb82be39b51ef394b8ba110e70eca4c397e6db78dab96e3cd237f47058170f72871122b522aa54be42ddbd0a30deb7d861d23544fb39a16618696c6\",\"settlement_time\":\"2020-07-25 13:36:31\",\"permata_va_number\":\"319000691931030\",\"payment_type\":\"bank_transfer\",\"order_id\":\"TAC-ALPHA-I-III-00009\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','{\"transaction_time\":\"2020-07-25 13:35:15\",\"transaction_status\":\"settlement\",\"transaction_id\":\"ffd05bb9-366b-4265-ad18-85e7947f6222\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"2484f6a62eb82be39b51ef394b8ba110e70eca4c397e6db78dab96e3cd237f47058170f72871122b522aa54be42ddbd0a30deb7d861d23544fb39a16618696c6\",\"settlement_time\":\"2020-07-25 13:36:31\",\"permata_va_number\":\"319000691931030\",\"payment_type\":\"bank_transfer\",\"order_id\":\"TAC-ALPHA-I-III-00009\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"fraud_status\":\"accept\",\"currency\":\"IDR\"}','2020-07-25 14:35:17','2020-07-25 14:36:33',NULL,0,0),
(10,'TAC-ALPHA-I-III-00010','da16de01-8c21-4563-942d-7d86db6234ce',6,'2020-03-02','2020-04-02',500001,'bank_transfer','bca','proses',NULL,'31974928506',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"da16de01-8c21-4563-942d-7d86db6234ce\",\"order_id\":\"TAC-ALPHA-I-III-00010\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-07-27 12:09:01\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bca\",\"va_number\":\"31974928506\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-07-27 13:09:01','2020-07-27 13:09:01',NULL,0,0),
(11,'TAC-ALPHA-I-III-M-00011',NULL,6,'2020-03-02','2020-04-02',500001,'manual','manual','pending','1wD69F4sB1DE4FNbpl1AuoOEVsAIoEJHIxRMLhD0.jpeg',NULL,NULL,NULL,NULL,NULL,NULL,'2020-07-27 13:09:09','2020-07-27 14:24:23',NULL,0,0),
(12,'TAC-ALPHA-I-III-M-00012',NULL,6,'2020-03-02','2020-04-02',500001,'manual','manual','proses',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2020-07-27 14:22:05','2020-07-27 14:22:05',NULL,0,0);

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
('010c5df1-8d2a-4450-8859-18e83a23f184','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:05:01','2020-07-21 16:05:01'),
('017c0373-ff6c-4c41-879b-8faaefa5b47c','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:05:52','2020-07-21 14:05:52'),
('01923ed6-ba30-47c7-9dbe-b63df0446fe7','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00014 \",\"type\" : \"special\"}',NULL,'2020-07-19 15:17:11','2020-07-19 15:17:11'),
('0296353f-4586-4e6b-ad4c-81c1a8f94f16','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-I-00002  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 15:31:57','2020-07-21 15:31:57'),
('0336b1ad-6bb2-443b-ad16-5d8a7529ff1c','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 14. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00011 \",\"type\" : \"special\"}',NULL,'2020-07-19 14:45:11','2020-07-19 14:45:11'),
('037ece07-af4c-46fb-a48d-aa46a2df97fa','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:03:17','2020-07-21 16:03:17'),
('03a0731d-b12a-4073-a9d2-9c5ede7a7009','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00015  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 12:42:20','2020-07-20 12:42:20'),
('05d5fd15-f37f-4e43-8773-a825de1b75c5','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:19:42','2020-07-27 15:19:42'),
('063f1f7e-01a6-4e14-a5de-78581c159fed','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:10:21','2020-07-27 15:10:21'),
('098285a1-4b99-42f4-82f4-7926b8ddb92b','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 24 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00018, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 12:59:15','2020-07-20 12:59:15'),
('0b506586-0f63-453a-a3d5-26302958a89c','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00002  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:08:45','2020-07-21 16:08:45'),
('0c893e83-ab14-4bba-ae2f-1dd1ceb0c255','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:57:00','2020-07-20 12:57:00'),
('0d096eba-c2b0-4075-8b5c-00a3ede249c3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-I-00003  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 15:57:12','2020-07-21 15:57:12'),
('0e728bf2-c67e-4a25-830c-638000df2c4a','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 9. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00006 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:21:24','2020-07-21 16:21:24'),
('0ea1d8c6-2868-4b01-9367-a17ca9432400','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:01:45','2020-07-21 16:01:45'),
('0eb5f187-8aa8-4942-b86d-425185a209ba','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:07:39','2020-07-21 16:07:39'),
('0f3d2c3f-55dd-4890-8bd2-eefbfea42589','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:50:57','2020-07-21 14:50:57'),
('0f5070a1-7a33-43c3-b7e1-916f74333158','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-III-00006  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-25 14:14:19','2020-07-25 14:14:19'),
('0ff7b9b5-f3c8-4eb3-9963-8ee160df1b8f','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00016  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:12:17','2020-07-21 14:12:17'),
('1083cf2a-08ad-4d80-9f49-706983c0dac1','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:00:22','2020-07-21 15:00:22'),
('1110da72-a308-4611-b3f8-4c06f8c2f71d','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-III-00009  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-25 14:36:32','2020-07-25 14:36:32'),
('1115a2f2-ee57-4fa6-bdc6-9b22fd7135c6','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-00006  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-07-21 13:55:59','2020-07-21 13:55:59'),
('12ad78db-6a7d-401c-a46f-adc7ab0d0bc3','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00016, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:12:19','2020-07-21 14:12:19'),
('12c8e9e6-fee8-4c74-9ad1-992459333152','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:41:53','2020-07-20 12:41:53'),
('12fccc5e-f13f-42bd-a9e2-3e5ac4213ed6','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:09:04','2020-07-21 16:09:04'),
('13e9a384-1878-44e9-9f09-ae47b0b04aad','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE MANUAL !\",\"text\" : \"Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid\",\"type\" : \"common\"}',NULL,'2020-07-21 13:55:52','2020-07-21 13:55:52'),
('148f48c7-69f4-441b-9ff3-422d2439d044','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:27:46','2020-07-21 16:27:46'),
('15c524cf-e96a-410b-9da5-74f14810b9a4','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-20 13:18:29','2020-07-20 13:18:29'),
('15cbed61-ee6f-4d01-8321-80ecc0c359fa','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00004  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:16:02','2020-07-21 16:16:02'),
('15e1aee5-ae3c-4899-a9eb-44d9043ed5df','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:00:05','2020-07-21 15:00:05'),
('182ee562-51fa-4188-8233-b3e7f973b7ad','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 1 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00002, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:08:31','2020-07-21 16:08:31'),
('1917c4d3-b2f4-4d1e-bfc3-506578f3ce5e','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00006  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:21:24','2020-07-21 16:21:24'),
('197922dd-e37b-4755-8103-3b85c914157d','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-23 14:58:34','2020-07-23 14:58:34'),
('1a8513ff-31b2-42ec-a3a3-0bc341084a8c','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-23 14:57:42','2020-07-23 14:57:42'),
('1a8e21d4-c2bd-4ef5-b43b-fa6ea1db673b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:10:41','2020-07-27 15:10:41'),
('1c66ae67-ec0a-4b2b-9fc7-69b63f81b647','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:05:54','2020-07-21 16:05:54'),
('1feae05f-d273-4f53-8aae-b30dfc022a2b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00024  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:31:26','2020-07-21 13:31:26'),
('20604248-ff0d-4112-a3b5-0bd1aef75ed4','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:49:40','2020-07-21 14:49:40'),
('22212704-1465-4b14-ae3d-7cb6ecd97616','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00012, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:05','2020-07-21 14:06:05'),
('2439f303-93e9-4fa9-97e0-821ce4051616','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:04:55','2020-07-21 14:04:55'),
('26b216e8-6ded-40da-875e-b8f7f780d654','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:20:03','2020-07-21 16:20:03'),
('274a7b94-1285-4a6a-bf28-8cc66ec90c5b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:16:38','2020-07-27 15:16:38'),
('2785e7f5-dc85-4376-b5ce-6af2a5450887','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:27:59','2020-07-21 16:27:59'),
('28017025-7527-4195-a3b4-524681781cae','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:21:07','2020-07-21 16:21:07'),
('280fe126-3cd2-48ca-b3c5-90fc8a071dc4','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-I-00016  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 14:12:51','2020-07-21 14:12:51'),
('2886bf05-0490-494b-8d60-4aa0498cc6f6','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-20 13:18:23','2020-07-20 13:18:23'),
('296eba8d-6160-43e1-83c4-218645a2506d','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 11 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00003, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:13:23','2020-07-21 16:13:23'),
('298a7cd4-ffaf-43e5-b206-66fa64b1e80f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:41:43','2020-07-20 12:41:43'),
('29aa36d0-1609-46ca-820b-89736e001baf','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:09:08','2020-07-21 16:09:08'),
('2ae1fc1c-5967-40bf-bb89-a4f342733c0e','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:52:09','2020-07-23 14:52:09'),
('2b2dd67a-2e55-4674-a735-45f8bf3f8fd2','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00007 \",\"type\" : \"special\"}','2020-07-19 14:29:30','2020-07-19 14:24:57','2020-07-19 14:29:30'),
('2c9b11fe-1847-430d-934f-59920258c47c','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:57:09','2020-07-20 12:57:09'),
('2e46ea47-b8a6-43a8-8761-5dd4121e4a57','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 19. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00008 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:27:16','2020-07-21 16:27:16'),
('2efe2123-42c5-4a86-b51f-d02a76747149','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 9 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00012, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-19 15:13:51','2020-07-19 15:13:51'),
('2fbcf1c2-4a9e-41c5-a186-f658a4efd79b','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00008, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}','2020-07-19 14:29:30','2020-07-19 14:25:26','2020-07-19 14:29:30'),
('3036eaca-6d7e-42fd-bda5-c3d43e686aa2','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:54:56','2020-07-21 13:54:56'),
('309abfa2-b6b9-4dd5-932a-cf0259f7b05d','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00006 \",\"type\" : \"special\"}','2020-07-19 14:29:30','2020-07-19 14:24:56','2020-07-19 14:29:30'),
('30d90802-c3fd-42bb-a949-59f7ed6abd46','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00008  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:27:16','2020-07-21 16:27:16'),
('32deae5c-1075-4614-b9ff-d819b9c85da6','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 19. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00017 \",\"type\" : \"special\"}',NULL,'2020-07-20 12:55:59','2020-07-20 12:55:59'),
('3356b2cc-f8e3-408e-b006-668325357ff2','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:41:39','2020-07-20 12:41:39'),
('3377f614-136c-4974-ba1c-e593a343450e','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 11 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00003, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 15:57:00','2020-07-21 15:57:00'),
('340781ff-f145-4b46-8dd4-3599623f2e70','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 1 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00001, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 15:30:56','2020-07-21 15:30:56'),
('34582172-8f2f-450e-9257-cb282743df1a','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-25 14:34:48','2020-07-25 14:34:48'),
('36b778ef-ce7d-4abf-851e-0d241eb87018','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XXI-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:38:08','2020-07-21 13:38:08'),
('371fb693-29b7-4291-879d-30ac2209a0c3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:12:08','2020-07-21 16:12:08'),
('38092f3b-e5ee-47c5-8ab6-a2698f0935b1','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-27 13:08:03','2020-07-27 13:08:03'),
('3a8d3a51-ed23-416d-abf2-a0c277060b11','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XXII-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:52:38','2020-07-21 13:52:38'),
('3bafbdb0-bdf0-4d91-8d18-fb130fb81074','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:56:24','2020-07-23 14:56:24'),
('3cce4975-82a0-4195-9dac-151426f26a15','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00014  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-07-19 16:41:57','2020-07-19 15:17:11','2020-07-19 16:41:57'),
('3d487a22-228f-4d09-ac12-d7447a47dae8','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"User user_4 Belum melakukan pembayaran hingga charge yang dibuatnya expired, tolong admin memberikan peringatan, charge yang expired dengan nomor order_id TAC-ALPHA-XX-00012 \",\"type\" : \"common\"}',NULL,'2020-07-19 15:14:52','2020-07-19 15:14:52'),
('3f3b2e15-2794-4af0-acf0-bb50896e587b','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:52:57','2020-07-21 15:52:57'),
('3fff113f-7fbf-4817-8e73-7a6d3365d2c1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:12:12','2020-07-21 16:12:12'),
('40764a07-d038-44d0-9606-2972e31a58ba','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_1 dengan tanggal tagihan 2020-02-02 sampai dengan 2020-03-02 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-25 13:57:01','2020-07-25 13:57:01'),
('41fa9adc-e388-4ee5-87a7-11084cbeb37e','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:23:53','2020-07-27 15:23:53'),
('42f7f78a-6c74-4d03-acf5-6c05c4a73fa5','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 16. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00004 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:16:02','2020-07-21 16:16:02'),
('434b989a-b21a-48b7-b8dc-7e0bac8e984e','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:22:07','2020-07-27 15:22:07'),
('43be7a5f-3e7c-4d30-bd87-addc56437817','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 14:20:08','2020-07-19 14:15:58','2020-07-19 14:20:08'),
('43d45769-ed00-4aa0-b36e-bf572bd51c16','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"User user_1 Belum melakukan pembayaran hingga charge yang dibuatnya expired, tolong admin memberikan peringatan, charge yang expired dengan nomor order_id TAC-ALPHA-I-00006 \",\"type\" : \"common\"}',NULL,'2020-07-21 13:55:59','2020-07-21 13:55:59'),
('444c0930-c742-492a-b791-e8b2bf126a25','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:13:21','2020-07-21 16:13:21'),
('446930c0-4d87-4a62-a2d8-0055d5679874','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 1. Transaksi dilakukan dengan order_id TAC-ALPHA-I-III-00006 \",\"type\" : \"special\"}',NULL,'2020-07-25 14:14:19','2020-07-25 14:14:19'),
('44e09102-c835-4b48-ac82-673744946775','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_1 dengan tanggal tagihan 2020-02-02 sampai dengan 2020-03-02 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-25 13:57:01','2020-07-25 13:57:01'),
('44e4e58a-b1b4-4db9-8783-e8ef7bb13323','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-00005, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 13:54:35','2020-07-21 13:54:35'),
('44fbe4c2-d930-4df5-b091-20c24a7cd9f2','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:57:05','2020-07-20 12:57:05'),
('476b1b6a-8a92-49c3-a3f4-c4b46a8bcdaa','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:16:03','2020-07-27 15:16:03'),
('47849e07-dcde-448f-84e0-ff0b002c25c6','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-27 13:07:18','2020-07-27 13:07:18'),
('47b8d2f0-da03-4d1e-a374-d8341bab5a81','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 6 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00002, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 15:31:42','2020-07-21 15:31:42'),
('48dfdcc4-168f-4dee-8857-7ff0a0f482d1','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:01:53','2020-07-21 16:01:53'),
('4b7dd211-ef4a-46d1-86ad-9ae0c653fc7e','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00014  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:40','2020-07-21 14:06:40'),
('4b87b938-2d6b-40f9-a1a2-aa24079af201','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-27 13:09:01','2020-07-27 13:09:01'),
('4c73ce27-a344-44d7-8f3f-596b5148bd85','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:05:48','2020-07-21 16:05:48'),
('4d795493-f7c9-404f-8ac9-9315df216173','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-00010, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:05:09','2020-07-21 14:05:09'),
('4e0ccccf-eb02-431a-a66e-17855047c3b6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:05:58','2020-07-21 16:05:58'),
('4e18ab64-b720-4ef6-9f6b-f15739ae80de','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-00007, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 13:55:20','2020-07-21 13:55:20'),
('4e628029-563d-444e-8011-0f777b4cd2ec','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:03:21','2020-07-21 16:03:21'),
('4eee7c85-c22e-4009-8abf-d957da27d789','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-23 14:57:47','2020-07-23 14:57:47'),
('4f130f90-a502-489f-a045-b269bea9aca5','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-III-00003  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}',NULL,'2020-07-24 12:50:30','2020-07-24 12:50:30'),
('5012dd8d-7512-4e85-9251-21baa459d9c8','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00008 \",\"type\" : \"special\"}','2020-07-19 14:29:30','2020-07-19 14:24:57','2020-07-19 14:29:30'),
('524b1262-3956-4d7f-84d7-1b49afa54d2b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:04:09','2020-07-27 15:04:09'),
('525f586d-9e8b-463e-826e-2e90baabd8b7','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:08:58','2020-07-21 16:08:58'),
('5311af63-cca4-4d6c-a937-cce7e2902ed7','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:04:51','2020-07-21 16:04:51'),
('53b53c31-dd6d-4a62-8c04-6b52b6e99964','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:16:49','2020-07-27 15:16:49'),
('54b7380d-478b-4c20-94c3-3e9840996a0c','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00010, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}','2020-07-19 14:29:30','2020-07-19 14:20:16','2020-07-19 14:29:30'),
('54ba6630-c4e4-4811-b124-ce1c5f3aabb9','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:56:16','2020-07-23 14:56:16'),
('54bcbe00-f745-4110-97d2-8bd6d46a24c3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-25 14:11:00','2020-07-25 14:11:00'),
('553f622d-171e-4336-ada7-f096d921a8aa','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:56:33','2020-07-23 14:56:33'),
('554c3535-14b9-4306-9a7f-d08f7b54f074','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 1. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00002 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:08:45','2020-07-21 16:08:45'),
('56697df1-ace9-4681-8cab-b20306d6dba6','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:03:47','2020-07-27 15:03:47'),
('5725eb2e-c4a9-4e84-9012-c79e1bd8b0dd','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:41:48','2020-07-20 12:41:48'),
('58a6646a-d0b9-439a-8d0b-78b4eda3a84e','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:09:16','2020-07-21 16:09:16'),
('58da6391-1f37-4e22-93e6-1c39a4cc7cae','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:00:26','2020-07-21 15:00:26'),
('596bee14-5c9f-483c-b6cd-d6582d2b3f10','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:51:10','2020-07-21 14:51:10'),
('5abf9254-00e9-4991-b7b8-5693fdf780d2','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XXI-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:49:13','2020-07-21 13:49:13'),
('5b83f408-61bb-4657-97a8-66b9d75b1709','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:56:29','2020-07-23 14:56:29'),
('5c354ca2-1724-42c2-b4f0-8d431a3b2322','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00012  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 15:13:49','2020-07-19 16:41:57'),
('5d722ae2-8999-4d21-b5da-14c731567453','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 1 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-III-00007, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-25 14:11:01','2020-07-25 14:11:01'),
('5e393d75-fbaa-443e-8211-8d8793e498a7','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00021  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-07-20 13:21:14','2020-07-20 13:21:14'),
('5f0e8065-c306-4404-b57f-40814824dca0','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XXII-00004, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 13:53:29','2020-07-21 13:53:29'),
('5f70e147-d6f1-404d-8401-7911adc41326','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 11. Transaksi dilakukan dengan order_id TAC-ALPHA-I-I-00003 \",\"type\" : \"special\"}',NULL,'2020-07-21 15:57:12','2020-07-21 15:57:12'),
('6031f78f-6bf3-429d-a2dd-798b6c76b599','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 21. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00010 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:42:31','2020-07-21 16:42:31'),
('60aa2123-8774-4100-b499-4ad73b5e85be','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 13:05:31','2020-07-20 13:05:31'),
('610f1535-b981-4648-8320-a2a0091e5954','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00001  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:07:50','2020-07-21 16:07:50'),
('6138f1f5-7ba2-4c43-ab15-ae92c484866f','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 11. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00003 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:13:34','2020-07-21 16:13:34'),
('615e5cbf-d621-42cc-a5da-d0b8ebb24c41','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00020, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 13:19:47','2020-07-20 13:19:47'),
('6281b70f-dbe4-4316-8156-2e965c7f05aa','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:11:38','2020-07-27 15:11:38'),
('62fa9529-a0af-4045-b07d-b6166b7e3b6d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:52:53','2020-07-21 15:52:53'),
('6302e479-f037-4327-81b5-92b81f832e3f','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XXII-00004  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:53:27','2020-07-21 13:53:27'),
('63b75743-7060-4f46-a17b-b0ef7519b446','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_4 dengan tanggal tagihan 2020-03-31 sampai dengan 2020-04-30 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-19 15:16:38','2020-07-19 15:16:38'),
('642e6e2d-e7be-4047-aec9-9f6fe85ea414','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE MANUAL !\",\"text\" : \"Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid\",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:48','2020-07-21 14:06:48'),
('6562cc0d-5e3f-4b14-8b12-4ae64499870f','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00019, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 13:19:39','2020-07-20 13:19:39'),
('657f618a-0cd6-4429-b0aa-fb0661cded98','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:00:15','2020-07-21 15:00:15'),
('662041fb-5beb-49a4-a493-54864cdae76f','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:54:33','2020-07-21 13:54:33'),
('6645b87f-0b51-4443-8f87-4b59b4a9bacc','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00005, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:20:04','2020-07-21 16:20:04'),
('6651390a-69df-41c8-8cf9-530aec231900','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00021, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 13:20:05','2020-07-20 13:20:05'),
('66a02e8f-6de9-421f-9117-91b48a6ed5b0','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-I-00013  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}',NULL,'2020-07-21 14:07:34','2020-07-21 14:07:34'),
('67b4e0c9-63fe-4451-a6de-96cac753775b','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:51:15','2020-07-21 14:51:15'),
('68b9a3f2-88d6-47ad-9460-d1e4b22a8e4f','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:22:35','2020-07-27 15:22:35'),
('6a7d82e3-c1ab-49cd-8d7b-99545804eb14','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00017  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 12:55:27','2020-07-20 12:55:27'),
('6b236f72-97d8-4d76-9403-bc356d8853d5','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:04:55','2020-07-21 16:04:55'),
('7136f8c7-4607-4d93-aeec-ea71ea170f2a','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:49:49','2020-07-21 14:49:49'),
('7194021c-6afa-40ec-aa58-9c560fb44f81','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-25 14:35:17','2020-07-25 14:35:17'),
('72454d3d-511a-4b22-8805-b488f6a8fb80','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-III-00002  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}',NULL,'2020-07-24 12:49:37','2020-07-24 12:49:37'),
('72a09930-b9ec-4013-882e-dc88bddde723','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-I-III-00009 \",\"type\" : \"special\"}',NULL,'2020-07-25 14:36:33','2020-07-25 14:36:33'),
('73874942-1ee6-4dba-9d6a-1f339e4ace18','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-25 14:06:15','2020-07-25 14:06:15'),
('74c8921a-3d9b-43f9-9b24-98e702c90501','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:26:59','2020-07-21 16:26:59'),
('76544848-1fda-48a4-af78-9ef810adbb34','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 15:30:56','2020-07-21 15:30:56'),
('771a709a-a9f9-467a-9eb5-65373c0d385a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:01:36','2020-07-21 16:01:36'),
('789f9fc5-480f-45cc-9bde-80269d139770','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 1. Transaksi dilakukan dengan order_id TAC-ALPHA-I-I-00001 \",\"type\" : \"special\"}',NULL,'2020-07-21 15:31:10','2020-07-21 15:31:10'),
('791dc988-2b38-4a75-b55f-6d5fa570dc6a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00022  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:29:55','2020-07-21 13:29:55'),
('7aee81a1-e817-4519-8937-386e61c79dbc','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Hapus Tagihan\",\"text\" : \"Tagihan User user_2 dengan tanggal tagihan 2020-04-30 sampai dengan 2020-05-31 telah berhasil dilakukan\", \"type\" : \"common\"}','2020-07-19 14:07:47','2020-07-19 14:07:09','2020-07-19 14:07:47'),
('7aeeec23-4e66-4656-95b7-340b31775437','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00010  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:42:30','2020-07-21 16:42:30'),
('7b1e98cd-5785-4c69-a66d-d94f274f61ae','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"User user_1 Belum melakukan pembayaran hingga charge yang dibuatnya expired, tolong admin memberikan peringatan, charge yang expired dengan nomor order_id TAC-ALPHA-I-I-00013 \",\"type\" : \"common\"}',NULL,'2020-07-21 14:07:34','2020-07-21 14:07:34'),
('7d79c996-c7b2-4d9d-a5b4-5dec2d2b17e1','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00013  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 15:16:39','2020-07-19 16:41:57'),
('7d885e2a-3a45-4b23-a8b7-88bc04632663','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:52:43','2020-07-21 15:52:43'),
('7f668e19-56ca-419c-9f2d-d0d3c4a50e17','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00014, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-19 15:17:03','2020-07-19 15:17:03'),
('7fa65e65-695d-4913-bac0-c3d014cd45a2','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE MANUAL !\",\"text\" : \"Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid\",\"type\" : \"common\"}',NULL,'2020-07-23 14:57:57','2020-07-23 14:57:57'),
('81363473-8e59-417d-8e42-edaf585dc29e','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"User user_1 Belum melakukan pembayaran hingga charge yang dibuatnya expired, tolong admin memberikan peringatan, charge yang expired dengan nomor order_id TAC-ALPHA-XX-00021 \",\"type\" : \"common\"}',NULL,'2020-07-20 13:21:14','2020-07-20 13:21:14'),
('81ed28c8-2e40-4fdc-ae22-5b7be7e993c3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-I-00001  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 15:31:10','2020-07-21 15:31:10'),
('85ef9462-5c6e-45d4-8e74-f4dfc85a8734','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:20:15','2020-07-19 16:41:57'),
('8605e0a7-c011-4d20-8c4c-ca2f6216bc61','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:12:03','2020-07-21 16:12:03'),
('86c37ce7-9549-428e-8c14-5b2172ecce5c','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:04:47','2020-07-21 16:04:47'),
('875f7b2d-2837-4d6f-b550-c9a9f6d49d58','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 14:20:08','2020-07-19 14:12:21','2020-07-19 14:20:08'),
('883ffbb9-b98a-4a58-b596-e071641c00b8','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00007, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}','2020-07-19 14:29:30','2020-07-19 14:24:26','2020-07-19 14:29:30'),
('8881ce9b-be64-4ff3-b378-8e82890bc578','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00019  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 13:19:38','2020-07-20 13:19:38'),
('889d731c-0d75-4bf7-a168-5798a9dabda8','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 19 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00016, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 12:42:31','2020-07-20 12:42:31'),
('89b1c642-5aad-4316-acdb-238e36ddb763','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-III-00009, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-25 14:35:19','2020-07-25 14:35:19'),
('8a3312b2-ac4f-4cff-b15a-37bd0ebe05c3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:56:20','2020-07-23 14:56:20'),
('8b68a3b5-2044-479d-92c3-c634b2039dc9','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00016  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 12:42:30','2020-07-20 12:42:30'),
('8d10b2e6-2462-4294-a73b-18e4d9f57a9f','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_3 dengan tanggal tagihan 2020-02-15 sampai dengan 2020-03-15 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-23 12:40:43','2020-07-23 12:40:43'),
('8d6cc9e0-68f0-4109-b19e-b7ac69c6b3eb','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00009  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:24:57','2020-07-19 16:41:57'),
('8ee911b8-f28b-4d7a-8968-5607fa5cd41f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 13:05:35','2020-07-20 13:05:35'),
('9088093f-d0a7-4857-87af-43f6bda6fdc1','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 4 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-III-00008, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-25 14:34:49','2020-07-25 14:34:49'),
('91aae42e-de43-4cc7-94b0-af87297841aa','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:42:12','2020-07-21 16:42:12'),
('9309e174-bfb8-455a-86a8-9712ea794c38','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 14:20:08','2020-07-19 14:16:41','2020-07-19 14:20:08'),
('9360f583-5981-4885-aa03-0f1dcc8be981','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 9 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00013, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-19 15:15:49','2020-07-19 15:15:49'),
('9400e403-2939-40e7-b699-c4233e7ed84d','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00023  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:30:03','2020-07-21 13:30:03'),
('943fe570-6c9d-45b4-8480-1cb553192a69','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:08:30','2020-07-21 16:08:30'),
('94c1b124-3db0-45c3-81a7-ca3b3bb9ba04','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_3 dengan tanggal tagihan 2020-02-15 sampai dengan 2020-03-15 telah berhasil ditarik\", \"type\" : \"common\"}','2020-07-19 14:11:33','2020-07-19 14:08:07','2020-07-19 14:11:33'),
('95a24323-a98d-42f6-97a8-a7345af51e9a','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-27 13:07:53','2020-07-27 13:07:53'),
('95fed164-e55d-4c03-a2d9-585f85c56668','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:06:07','2020-07-21 16:06:07'),
('960a1cc0-cd4f-4216-a559-b7552857f90a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:04:42','2020-07-21 16:04:42'),
('966c0b64-03aa-4951-94ec-95f0580ed4cd','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-00006, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 13:54:57','2020-07-21 13:54:57'),
('9938082b-ff69-4dff-9f92-f64a64e24941','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 15:56:58','2020-07-21 15:56:58'),
('9a3edad0-14e9-409b-9879-3855e461c984','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:19:50','2020-07-27 15:19:50'),
('9b4f8102-3ba6-4e84-bfc0-bf46d3845ac7','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:24:07','2020-07-27 15:24:07'),
('9fa2f5b5-2734-471c-ab37-49cce5c4efb7','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00013  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 15:15:48','2020-07-19 16:41:57'),
('a320e97c-58f0-47b5-bedb-60fcc0ef81d0','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 9 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00006, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:21:09','2020-07-21 16:21:09'),
('a4be4bd5-e6d4-4a66-b4bf-9ae906b067d3','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-00009, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:04:56','2020-07-21 14:04:56'),
('ab1834ec-2e53-42ea-8005-e70e30eb52d6','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00012  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:03','2020-07-21 14:06:03'),
('ac351c2d-5b79-4d23-8bdd-4ed2c60f3bc4','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 19 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00017, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 12:55:28','2020-07-20 12:55:28'),
('acb66ff6-1f15-4e8f-87bb-81eea6dfe650','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:44:28','2020-07-19 16:41:57'),
('ad02c92d-6a8f-4640-b968-f7b9bbabc4d0','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 16 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00004, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:15:41','2020-07-21 16:15:41'),
('ad1825bb-5ea3-4b0a-864e-de349e79acf9','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:01:40','2020-07-21 16:01:40'),
('ad6a7800-3dbd-4405-bd3b-555073e8b32c','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:09:32','2020-07-27 15:09:32'),
('adc94edc-5868-41ed-b686-72cf03d30ffa','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:27:51','2020-07-21 16:27:51'),
('ae974f52-a0d0-4048-875d-095d7bac4fd0','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00005 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:20:21','2020-07-21 16:20:21'),
('b035b1fa-87f9-4b16-a93b-c9bd5b6dadf8','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:07:34','2020-07-27 15:07:34'),
('b1461915-67d7-426a-8b70-4e2cf1eae58a','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00017  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-20 12:55:59','2020-07-20 12:55:59'),
('b1470b32-f873-4cc5-a9d2-b5ae84b624bf','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:37:30','2020-07-21 16:37:30'),
('b1d40ea6-29dc-4bdc-9b62-df5428087a8b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00004  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:15:40','2020-07-21 16:15:40'),
('b2417964-0447-41c3-b4c2-fe61c8483719','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:12:20','2020-07-21 16:12:20'),
('b2f00278-efbd-467e-a396-c6216bca3859','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-II-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan BILLER CODE dan BILL KEY BANK MANDIRI yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 16:21:45','2020-07-21 16:21:45'),
('b7d7b278-8360-4248-a04f-9ed80719f238','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00014  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 15:17:03','2020-07-19 16:41:57'),
('b8b0913d-8e26-4d9b-9083-b09867edf729','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:27:55','2020-07-21 16:27:55'),
('b8ea1b1f-155a-456c-afe8-fdd9c6dbe060','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:56:56','2020-07-20 12:56:56'),
('b949016a-7e51-4993-90c5-40eda0f42af0','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 19 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00008, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:27:00','2020-07-21 16:27:00'),
('bac66df3-80f6-446a-820d-a6ad8e2c656c','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00003  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:13:34','2020-07-21 16:13:34'),
('bc1d76fa-de67-4a85-948c-72e61351c652','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_2 dengan tanggal tagihan 2020-04-30 sampai dengan 2020-05-31 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-19 15:01:54','2020-07-19 15:01:54'),
('bd3f2edf-3589-43a5-b76e-851ad4bf622d','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-07-19 14:20:08','2020-07-19 14:15:26','2020-07-19 14:20:08'),
('bd9a5c05-6d93-472a-8852-f178d6c25ddd','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:03:25','2020-07-21 16:03:25'),
('be2a9d63-61a4-4573-bd2c-b30c2675c1bd','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-III-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-23 14:57:53','2020-07-23 14:57:53'),
('bef50d79-fa07-4347-8fcb-05085d473bf3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:49:33','2020-07-21 14:49:33'),
('bfbde1ee-ca1f-46c2-a0ac-0e1c7b6654a8','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 14. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00007 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:22:07','2020-07-21 16:22:07'),
('c0ab4eeb-3553-4081-b0d7-d8600c55cca5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-23 14:52:02','2020-07-23 14:52:02'),
('c32e4a91-92ca-4506-ac3e-e4675e850069','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN EXPIRED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00012  Telah Kedaluarsa, Jika anda belum melakukan pembayaran dimohon untuk segera melakukan pembayaran kembali\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 15:14:51','2020-07-19 16:41:57'),
('c400dbaa-96d9-4591-819f-839daa3207ae','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:01:49','2020-07-21 16:01:49'),
('c44e5288-7552-457f-ae81-718357c544f8','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00018  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 12:59:15','2020-07-20 12:59:15'),
('c53ab231-e11b-4117-b143-725db3efbc3d','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_4 dengan tanggal tagihan 2020-02-29 sampai dengan 2020-03-31 telah berhasil ditarik\", \"type\" : \"common\"}','2020-07-19 14:29:30','2020-07-19 14:24:57','2020-07-19 14:29:30'),
('c58447f7-4b73-4ae3-83a4-8c0f8b9dd265','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE MANUAL !\",\"text\" : \"Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid\",\"type\" : \"common\"}',NULL,'2020-07-27 14:22:06','2020-07-27 14:22:06'),
('c69895d5-110d-4734-b33b-f9b7a7120951','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 14 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00011, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-19 14:44:30','2020-07-19 14:44:30'),
('c69d505c-39c3-4d05-8a28-62320957d87b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:49:26','2020-07-21 14:49:26'),
('c78d8b28-def7-48e3-aaa9-ed3dee316a1f','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00005  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:20:21','2020-07-21 16:20:21'),
('c79d3f6e-376f-4d7f-8d59-bd30b1a0e5e8','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:53:02','2020-07-21 15:53:02'),
('c9739ec5-87a9-40c9-97b4-53c381f13e69','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00021  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 13:20:04','2020-07-20 13:20:04'),
('ca79dfa4-b903-4cf3-b179-cfbd24a089be','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00014, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:41','2020-07-21 14:06:41'),
('cad17817-49c3-4733-ab37-fbe88ed9614a','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:09:12','2020-07-21 16:09:12'),
('ccd2ae11-4149-43bd-b7c2-6cdcee632c7a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:55:19','2020-07-21 13:55:19'),
('ce175683-6398-4c44-9393-388709bc309b','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 13:05:40','2020-07-20 13:05:40'),
('ce76680e-c38d-4549-a9d5-5d005a42a18c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:51:05','2020-07-21 14:51:05'),
('d0ab5cfa-f20b-4fc1-b3f1-9c4b3a1308a4','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:52:48','2020-07-21 15:52:48'),
('d0f058d9-52c3-455d-952a-07c327492207','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00011  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}','2020-07-19 16:41:57','2020-07-19 14:45:11','2020-07-19 16:41:57'),
('d10a9810-534e-4bc4-9dcb-28b538557283','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00013, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:25','2020-07-21 14:06:25'),
('d2588e8a-6c09-483e-81a1-ef05d26091c1','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 15:31:41','2020-07-21 15:31:41'),
('d423b286-2e1d-496c-af01-5fd7d442fae0','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00006  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:24:56','2020-07-19 16:41:57'),
('d7e563ed-ea27-4fe2-9c25-c4b3ed87e137','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00007  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:24:57','2020-07-19 16:41:57'),
('d91abec3-e0b0-47dd-8bd4-c886ffb5695a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00020  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-20 13:19:46','2020-07-20 13:19:46'),
('d9bc17d3-9896-4d6e-bd0b-5c8d66d27901','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00009 \",\"type\" : \"special\"}','2020-07-19 14:29:30','2020-07-19 14:24:57','2020-07-19 14:29:30'),
('da9ba599-36e9-4f61-93a7-6a308484a95d','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 24. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00018 \",\"type\" : \"special\"}',NULL,'2020-07-20 12:59:46','2020-07-20 12:59:46'),
('db82eacc-bd37-4c3d-b38a-ed903a971a34','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-II-00007  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-21 16:22:07','2020-07-21 16:22:07'),
('dbaf444f-4a0b-45d3-89df-f7ebe4e06fc4','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_4 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 4. Transaksi dilakukan dengan order_id TAC-ALPHA-XX-00010 \",\"type\" : \"special\"}','2020-07-19 14:29:30','2020-07-19 14:24:58','2020-07-19 14:29:30'),
('dbd9f79f-41cc-43a5-bd19-81ea130488c2','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 6. Transaksi dilakukan dengan order_id TAC-ALPHA-I-II-00001 \",\"type\" : \"special\"}',NULL,'2020-07-21 16:07:51','2020-07-21 16:07:51'),
('de831b49-247d-4229-aee2-8aeddf608d6a','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 26. Transaksi dilakukan dengan order_id TAC-ALPHA-I-I-00016 \",\"type\" : \"special\"}',NULL,'2020-07-21 14:12:51','2020-07-21 14:12:51'),
('dea90c41-bdb1-4b76-b1e4-2f36393021fa','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:06:02','2020-07-21 16:06:02'),
('dedbe6ad-a75d-4a02-9168-12720f045518','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 19 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XX-00015, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-20 12:42:22','2020-07-20 12:42:22'),
('e08ca5d1-f6f6-4f2b-9ead-1b965f018071','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 6 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00001, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:07:40','2020-07-21 16:07:40'),
('e14062f2-09b1-4079-a0b3-c7af5882f984','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-I-00011, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 14:05:54','2020-07-21 14:05:54'),
('e44d1cc4-6b39-4cf8-8b6c-6754545bde10','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 16:12:16','2020-07-21 16:12:16'),
('e4ef156a-3123-4910-8607-0bbb82371195','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-27 13:07:32','2020-07-27 13:07:32'),
('e73924a5-57c6-4f49-beb5-cb97cc52803a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-I-00013  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Payment Code yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:06:24','2020-07-21 14:06:24'),
('eac51e68-c656-4b8f-8598-999e58495e81','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 21 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00010, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:42:13','2020-07-21 16:42:13'),
('eae5db58-ba8c-44e1-82f8-5f08b5a27f82','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"User user_1 telah berhasil melakukan pembayaran terhadap Tagihan dengan nomor ID 6. Transaksi dilakukan dengan order_id TAC-ALPHA-I-I-00002 \",\"type\" : \"special\"}',NULL,'2020-07-21 15:31:57','2020-07-21 15:31:57'),
('ebbcbd03-3139-4603-b244-f145914d6613','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 26 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-XXII-00003, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 13:52:39','2020-07-21 13:52:39'),
('ecf37b67-fd1d-45cc-9ba3-04ab9e6826e3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:41:24','2020-07-20 12:41:24'),
('ed6bbf6a-4a04-4401-a837-cf7e172b74e3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-07-27 15:03:56','2020-07-27 15:03:56'),
('edc84378-9fed-4931-a235-3c364edef2b2','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00010  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:24:58','2020-07-19 16:41:57'),
('f0cdaca0-428e-466d-b580-4ce47797f80b','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE MANUAL !\",\"text\" : \"Charge pembayaran manual telah berhasil dibuat, silahkan upload bukti pembayaran, dan tunggu verifikasi admin, pastikan anda memberikan bukti pembayaran yang valid\",\"type\" : \"common\"}',NULL,'2020-07-27 13:09:09','2020-07-27 13:09:09'),
('f0f000b4-a236-4135-a6c0-d4c010a9a152','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-27 13:07:09','2020-07-27 13:07:09'),
('f3dd4dbf-bdd0-4be6-b9ed-ff51b3ce6aac','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 15:00:10','2020-07-21 15:00:10'),
('f3ff203e-d2ed-44f0-ba36-5e42841187a8','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 14:05:08','2020-07-21 14:05:08'),
('f511ae68-db0c-4255-add4-9b4f9794b2bb','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_1 telah melakukan charge terhadap tagihan dengan ID 21 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00009, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:37:31','2020-07-21 16:37:31'),
('f5aca252-8436-4697-99c6-13e1b7840dd2','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-I-III-00007  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}',NULL,'2020-07-25 14:14:48','2020-07-25 14:14:48'),
('f939412f-1400-4cff-aa16-07a561cd20b3','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-20 12:56:51','2020-07-20 12:56:51'),
('f9effdc3-483d-48cf-a015-3f71ad4f1ef4','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-XX-00025  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-07-21 13:36:20','2020-07-21 13:36:20'),
('fad3b473-09d6-4f51-afb1-0ecc89f751b8','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:51:01','2020-07-21 14:51:01'),
('fc600d9e-2354-4867-b1fb-aa66f85e2a55','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN REJECTED\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00008  Telah gagal, dimohon untuk melakukan pembayaran dengan benar\",\"type\" : \"common\"}','2020-07-19 16:41:57','2020-07-19 14:24:57','2020-07-19 16:41:57'),
('fd4be605-2d1d-4770-bf52-d6b4cae80705','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"Tagihan Kamar\",\"text\" : \"Tagihan Kamar anda telah dibuat silahkan melakukan pembayaran\", \"type\" : \"common\"}',NULL,'2020-07-21 14:49:44','2020-07-21 14:49:44'),
('fe398af9-a15d-4ec5-b92a-65fcf09b693a','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"CHARGE USER\",\"text\" : \"User user_4 telah melakukan charge terhadap tagihan dengan ID 14 Status Transaksi saat ini masih PENDING , Charge dibentuk dengan order_id TAC-ALPHA-I-II-00007, dimohon untuk admin mengawasi aktifitas transaksi dengan baik \",\"type\" : \"common\"}',NULL,'2020-07-21 16:21:46','2020-07-21 16:21:46'),
('ff622921-7a1c-4582-8c7d-d840c8f0422e','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"PEMBAYARAN SUCCESS\",\"text\" : \"Transaksi dengan Order ID TAC-ALPHA-XX-00018  telah selesai , terimakasih banyak, have a good day\",\"type\" : \"special\"}',NULL,'2020-07-20 12:59:46','2020-07-20 12:59:46'),
('ffda3b19-5a48-4b5a-952a-d4f63bded83d','App\\Notifications\\UserNotification','App\\User',6,'{\"title\" : \"Penarikan Tagihan\",\"text\" : \"Tagihan User user_1 dengan tanggal tagihan 2020-02-02 sampai dengan 2020-03-02 telah berhasil ditarik\", \"type\" : \"common\"}',NULL,'2020-07-25 13:57:01','2020-07-25 13:57:01');

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
  `verified_email_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by_admin` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`email`,`password`,`pelaporan`,`kode_invitation`,`reward`,`verify_admin`,`image`,`nomor_hp`,`ktp`,`role`,`verified_email_at`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_admin`) values 
(1,'user 1','user_1','alindeveloper143@gmail.com','$2y$10$kGbW4KKow.8DfBwGUz8VA.5IaSIbyopxBAXftBUNjwnHDcPWo4qZa',0,'ce572',0,1,'default.png','+6281246082357','vbzhx8tGu1X0hRrAvTWBPRzR8BDdr7HmvJxSvkF2.jpeg','user','2020-07-03 12:00:05','2020-06-25 03:38:01','2020-07-27 15:24:07',NULL,0),
(2,'user 2','user_2','alindeveloper17@gmail.com','$2y$10$ESUdj.MMLK7LDqZdCOfoQ.k5y5sFmPHwu8A9GWs5etRiIhURNl4wq',0,'1b4r4',0,1,'default.png','081246082357','ktp_default.jpg','user',NULL,'2020-06-25 03:38:32','2020-07-15 10:51:02',NULL,0),
(3,'user 3','user_3','alindeveloper14@gmail.com','$2y$10$dGkKi2/csJhdapLWr1HVMOA7BH/61ITaQAy8TywNFNDA3iE9Ur6G.',0,'n0x0a',0,1,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-06-25 03:39:04','2020-06-25 03:39:04',NULL,0),
(4,'user 4','user_4','alindeveloper14@gmail.com','$2y$10$xBWsx0AxxIw2YMckOioHIeA31v8ioxH/tVWZ9hWl761mNLhwVI9FW',0,'cjtj9',0,1,'p1sycEEGxKy4dR8eD6hpINzvABflZHiwKOqqmolG.png','123242312341','KSe7I5OKwJIDDKEQGQtlZfC5HhA82e5RPHX2CcKr.jpeg','user','2020-07-03 12:00:05','2020-06-25 03:39:36','2020-07-03 12:00:05',NULL,0),
(5,'user 5','user_5','alindeveloper14@gmail.com','$2y$10$0io2WQCJ4sgEzPUt7BidTecBSJsPeCxsta7apZ9ekKnLBI1KZXneO',0,'asui9',0,1,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-06-25 03:40:13','2020-06-25 03:40:13',NULL,0),
(6,'I Putu Alin Winata Gotama','alsan','alsan@gmail.com','$2y$10$zG3awpQFYicoygeZ33mC1eWbCKiOjNumOyrywcxJNnb.sImVf7LF2',0,'seclx',0,1,'default.png','08192883783','ktp_default.jpg','admin',NULL,'2020-06-25 03:40:49','2020-07-12 13:49:01',NULL,0),
(7,'I Putu Alin Winata Gotama','alin','alsan4154@gmail.com','$2y$10$rLfL10Af8EjXEuq1zfMoiejiPPrRhB/xibgnTttHCf7lrzjeHl0I2',0,'7u5dh',0,0,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-07-02 13:01:22','2020-07-02 13:13:48',NULL,0),
(8,'I Putu Alin Winata Gotama','alin2','alsan4154@gmail.com','$2y$10$sy43DVHfBK09iUhL0wWYYOorVVI8NEtc47RGY.NbPRTiHPMs3wgVO',0,'dzbp9',0,0,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-07-02 13:01:51','2020-07-02 13:01:51',NULL,0),
(9,'I Putu Alin Winata Gotama','alin3','alsan4154@gmail.com','$2y$10$yhgtj6qP07plB7UNqMnH/.vqabY7FDifXthxMJEXcsz9ls9qaEDEW',0,'44tq6',0,0,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-07-02 13:02:34','2020-07-02 13:02:34',NULL,0),
(10,'I Kadek Santa Buana Gotama','santa','alindeveloper15@gmail.com','$2y$10$uZJN4nEzxIimPSXYFL/ree3yLRTCf3TswTAp/wNHTeWZDnhkLPsIW',0,'74e7q',0,0,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-07-15 10:39:52','2020-07-15 10:39:52',NULL,0),
(11,'I Kadek Santa Buana Gotama','santa2','alindeveloper16@gmail.com','$2y$10$jj0P21Mme6qiXmJCmRpNRen/YujC9eQgQJXQLn9IOON5leCMIcJSW',0,'8897v',0,0,'default.png',NULL,'ktp_default.jpg','user',NULL,'2020-07-15 10:40:57','2020-07-15 10:40:57',NULL,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
