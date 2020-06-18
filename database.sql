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

USE `alindeve_kost_development`;

/*Table structure for table `kamars` */

DROP TABLE IF EXISTS `kamars`;

CREATE TABLE `kamars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `nomor` tinyint(4) NOT NULL,
  `tipe_pembayaran` enum('bulan','tahun') DEFAULT NULL,
  `tgl_awal_sewa` date DEFAULT NULL,
  `tgl_bayar_selanjutnya` date DEFAULT NULL,
  `status_pembayaran` enum('lunas','hutang') DEFAULT NULL,
  `keluhan` enum('ada','tidak') DEFAULT 'tidak',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `kamars_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `kamars` */

insert  into `kamars`(`id`,`user_id`,`nomor`,`tipe_pembayaran`,`tgl_awal_sewa`,`tgl_bayar_selanjutnya`,`status_pembayaran`,`keluhan`,`created_at`,`updated_at`,`deleted_at`) values 
(1,3,1,'bulan','2020-06-01','2020-07-01','lunas','tidak','2020-06-18 17:44:30','2020-06-18 17:44:34',NULL);

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

/*Table structure for table `transaksis` */

DROP TABLE IF EXISTS `transaksis`;

CREATE TABLE `transaksis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kamar_id` int(11) NOT NULL,
  `tgl_awal` date NOT NULL,
  `tgl_akir` date NOT NULL,
  `nominal` int(11) NOT NULL,
  `via` enum('manual','bank_transfer','kedai') NOT NULL,
  `integration_name` enum('mandiri','bca','permata','bni','indomaret','alfamart','manual') DEFAULT NULL,
  `status_pembayaran` enum('approved','rejected','pending','expired') NOT NULL,
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
  `role` enum('user','admin') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`email`,`password`,`pelaporan`,`kode_invitation`,`reward`,`verify_admin`,`image`,`role`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'I Putu Alin Winata Gotama','alsan','alingotama14@gmail.com','$2y$10$pbToID5ZL6BED569zaF2F.exM3wkZQlYOb.RwKG1ViNfbClrgUYeG',0,'ip5ga',0,1,'default.png','admin','2020-06-18 03:05:02','2020-06-18 03:05:02',NULL),
(2,'I Kadek Santa Buana Gotama','santa','santa@gmail.comn','$2y$10$pbToID5ZL6BED569zaF2F.exM3wkZQlYOb.RwKG1ViNfbClrgUYeG',0,'asd12',0,1,'default.png','user','2020-06-18 18:05:33','2020-06-18 18:05:39',NULL),
(3,'Jamaikan','jamaikan','jamaikan@gmail.com','$2y$10$vXY4jiLbJUGj.5XnCEpNJuiDunWp9J0OpVcB13XFJpfoPBHby/T/O',0,'64uc3',0,1,'default.png','user','2020-06-18 12:55:10','2020-06-18 12:55:10',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
