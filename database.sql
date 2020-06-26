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
(1,1,1,'bulan',500001,'2020-01-02','2020-03-02','2020-04-02','hutang','tidak','on','2020-06-18 17:44:30','2020-06-26 16:22:34',NULL),
(2,2,2,'bulan',500002,'2020-01-31','2020-03-31','2020-04-30','hutang','tidak','on','2020-06-19 20:53:37','2020-06-26 16:22:35',NULL),
(3,3,3,'bulan',500003,'2020-01-15','2020-03-15','2020-04-15','hutang','tidak','on','2020-06-25 11:51:37','2020-06-26 16:22:35',NULL),
(4,4,4,'bulan',500004,'2020-01-31','2020-03-31','2020-04-30','hutang','tidak','on','2020-06-25 11:52:45','2020-06-26 16:22:35',NULL),
(5,5,5,'bulan',500005,'2020-01-16','2020-03-16','2020-04-16','hutang','tidak','on',NULL,'2020-06-26 16:22:35',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

insert  into `tagihans`(`id`,`user_id`,`kamar_id`,`tipe_pembayaran`,`tgl_awal_sewa`,`tgl_akhir_sewa`,`status_tagihan`,`tgl_pembayaran`,`nominal_pembayaran`,`created_by`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_user`) values 
(1,1,1,'bulan','2020-02-02','2020-03-02','hutang',NULL,500001,'system','2020-06-26 16:20:38','2020-06-26 16:20:38',NULL,0),
(2,2,2,'bulan','2020-02-29','2020-03-31','hutang',NULL,500002,'system','2020-06-26 16:20:39','2020-06-26 16:20:39',NULL,0),
(3,3,3,'bulan','2020-02-15','2020-03-15','hutang',NULL,500003,'system','2020-06-26 16:20:39','2020-06-26 16:20:39',NULL,0),
(4,4,4,'bulan','2020-02-29','2020-03-31','hutang',NULL,500004,'system','2020-06-26 16:20:39','2020-06-26 16:20:39',NULL,0),
(5,5,5,'bulan','2020-02-16','2020-03-16','hutang',NULL,500005,'system','2020-06-26 16:20:39','2020-06-26 16:20:39',NULL,0),
(6,1,1,'bulan','2020-03-02','2020-04-02','hutang',NULL,500001,'system','2020-06-26 16:22:34','2020-06-26 16:22:34',NULL,0),
(7,2,2,'bulan','2020-03-31','2020-04-30','hutang',NULL,500002,'system','2020-06-26 16:22:35','2020-06-26 16:22:35',NULL,0),
(8,3,3,'bulan','2020-03-15','2020-04-15','hutang',NULL,500003,'system','2020-06-26 16:22:35','2020-06-26 16:22:35',NULL,0),
(9,4,4,'bulan','2020-03-31','2020-04-30','hutang',NULL,500004,'system','2020-06-26 16:22:35','2020-06-26 16:22:35',NULL,0),
(10,5,5,'bulan','2020-03-16','2020-04-16','hutang',NULL,500005,'system','2020-06-26 16:22:35','2020-06-26 16:22:35',NULL,0);

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
