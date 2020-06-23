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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `kamars` */

insert  into `kamars`(`id`,`user_id`,`nomor`,`tipe_pembayaran`,`harga`,`tgl_mulai_sewa`,`tgl_awal_sewa`,`tgl_bayar_selanjutnya`,`status_pembayaran`,`keluhan`,`auto_tagih`,`created_at`,`updated_at`,`deleted_at`) values 
(1,3,1,'tahun',9800000,'2020-02-29','2020-02-29','2022-02-28','lunas','tidak','on','2020-06-18 17:44:30','2020-06-22 11:40:14',NULL),
(2,2,2,'bulan',500000,'2020-10-31','2021-02-28','2021-03-31','hutang','tidak','on','2020-06-19 20:53:37','2020-06-22 13:11:31',NULL);

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
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `kamar_id` (`kamar_id`),
  CONSTRAINT `tagihans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tagihans_ibfk_2` FOREIGN KEY (`kamar_id`) REFERENCES `kamars` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

insert  into `tagihans`(`id`,`user_id`,`kamar_id`,`tipe_pembayaran`,`tgl_awal_sewa`,`tgl_akhir_sewa`,`status_tagihan`,`tgl_pembayaran`,`nominal_pembayaran`,`created_by`,`created_at`,`updated_at`,`deleted_at`) values 
(1,2,2,'bulan','2020-10-31','2020-11-30','lunas',NULL,NULL,'system','2020-06-22 11:50:31','2020-06-22 11:50:31',NULL),
(2,2,2,'bulan','2020-11-30','2020-12-31','hutang',NULL,NULL,'system','2020-06-22 11:55:38','2020-06-22 11:55:38',NULL),
(3,2,2,'bulan','2020-12-31','2021-01-31','hutang',NULL,NULL,'system','2020-06-22 13:02:50','2020-06-22 13:02:50',NULL),
(4,2,2,'bulan','2021-01-31','2021-02-28','lunas',NULL,NULL,'system','2020-06-22 13:11:30','2020-06-22 13:11:30',NULL);

/*Table structure for table `transaksis` */

DROP TABLE IF EXISTS `transaksis`;

CREATE TABLE `transaksis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) NOT NULL,
  `tagihan_id` int(11) NOT NULL,
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

insert  into `user_notifications`(`id`,`type`,`notifiable_type`,`notifiable_id`,`data`,`read_at`,`created_at`,`updated_at`) values 
('047ef0f5-fe71-4366-85b4-b84283af339f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('05eddc7c-54dc-47e5-b147-2665426ef3f4','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:38','2020-06-21 13:43:54'),
('0e8cd7d6-7870-430e-9f70-030d77644dda','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('108c3d0b-7b9a-47c2-9f0c-7bc5e473f8bc','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:18:00','2020-06-22 19:19:12'),
('13387f6b-8113-431e-ad4f-57b95359f760','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:13:35','2020-06-21 07:11:59','2020-06-21 15:13:35'),
('14b1dcda-82d7-465a-929b-7967d1410785','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('16ff44d0-c6e8-47e1-8d09-fcafb7fdce55','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('1787fd27-11d0-4eb9-aee3-23b447aa6d5b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:23','2020-06-21 13:59:28'),
('1a71d3f4-4933-4e7d-b7d2-24391be01d5a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('1a8306eb-260c-44c3-baaf-c14abf46a949','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('1d394195-d155-4ebf-8aa2-199859fc3d67','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('1fffc4d1-35a3-42ef-9eec-b325b2080334','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:09','2020-06-21 13:59:28'),
('22062e44-d4cd-44a3-a6aa-ed5fc4ff8bab','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('235266f2-b456-47e2-810c-4f5bf5c1d123','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('23dae3d5-0af9-46db-88ea-9a7dc023bb80','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:05:26','2020-06-21 13:43:54'),
('2732a765-435a-4a0d-bc66-2b4dff11aea6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('2b6e4eb0-4f64-407e-9139-e945d0872a15','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:47','2020-06-21 13:43:54'),
('2ca45a2c-124f-4f76-ad4e-5f36bb55cee1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:20','2020-06-22 19:25:06'),
('301d5e2a-7da7-454f-8b51-6a6efb9c3892','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('336e3950-3096-46cc-bfbd-a461547beef5','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:22:36','2020-06-21 07:21:47','2020-06-21 15:22:36'),
('351590ac-a38f-4774-8486-09963491c861','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('36bca704-4cb3-4411-bd9b-8d5f6d77e48b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:15:48','2020-06-22 19:17:52'),
('3bc91dac-49f4-4be5-bbf8-8613428b5117','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('3c4a1a5e-1322-45cb-b529-55f84a39d57e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:14','2020-06-21 13:59:28'),
('44d76228-f2f6-4b9e-9032-939ddd3c81ab','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-22 14:19:33','2020-06-23 10:28:00'),
('4549ea3e-976f-4f07-884f-249b64f50ad8','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:14:57','2020-06-22 19:17:52'),
('484da515-ee70-4925-8fbe-61476a063ef6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-22 12:04:03','2020-06-22 12:04:03'),
('4b96345a-69bf-4983-b053-dbcfaaaa6ca5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('4dd3574e-405c-40c7-9a93-da2db3ee47e5','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 11:22:03','2020-06-23 03:21:30','2020-06-23 11:22:03'),
('507ca45c-3d2e-4297-898a-00d08e65f129','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('56490615-d517-4048-8c31-55a8703dcd47','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:15:55','2020-06-22 19:17:52'),
('57e0c4b1-de5b-48c5-a50a-1815f174499c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('598d8681-7e14-4f20-9cec-06762b74f041','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:35:41','2020-06-21 16:39:04'),
('5a97e782-cddc-4ed6-afe8-aeaf3b975abb','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-23 02:27:50','2020-06-23 10:28:00'),
('5c6c7b06-e08b-42b2-bfde-d22cc94929dc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 05:51:18','2020-06-21 16:39:04'),
('5d2a0d86-637c-443f-abf8-e7714e2ce54e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:12:07','2020-06-21 16:39:04'),
('645a9f0b-b7f6-4fa5-984d-0b63119d6efa','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:08','2020-06-22 19:25:06'),
('687a9199-91de-459c-a0e7-38779541c66a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('6c7a72e6-e460-4cf1-b457-b19bcfb1a008','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:08','2020-06-22 19:25:06'),
('76d0abb8-2d2a-4483-96e2-cdf779f558a3','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('77d01677-505d-4001-9224-7f5187db9eb1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:38','2020-06-22 11:25:17','2020-06-22 19:25:38'),
('7ed894e6-f849-47ef-8fac-23bd716d70ac','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Pembayaran Succes\",\"text\" : \"Pembayaran secara manual berhasil dilakukan, silahkan tunggu verifikasi admin\", \"type\" : \"special\"}','2020-06-21 16:39:04','2020-06-21 04:07:10','2020-06-21 16:39:04'),
('8248a050-5ae6-4064-a0dc-026179b87d66','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('8480010a-f065-4828-9180-da3d9f457c78','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 10:57:47','2020-06-22 19:17:52'),
('88d4c2ac-5b25-4c67-a2e0-e5b64e43309f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('8fe1dc2c-6328-4035-9370-43caef6d2d52','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 10:58:06','2020-06-22 19:17:52'),
('91205501-735b-48e9-9a5e-ff945059909c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('915bbab6-6a9a-40e5-88ee-cb8aa867072f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('9b4e4d15-6125-4182-9c8f-668ef73806c2','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:14:40','2020-06-22 19:17:52'),
('9c6c5f9a-245b-40d1-b7d5-30e95184a3d3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:27:38','2020-06-21 16:39:04'),
('9fd572cf-72f0-494c-886d-7acccd2cd264','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:28','2020-06-22 19:19:57'),
('a15ca2a5-7721-4c4e-a3a6-3f15cfdb00bd','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:12:12','2020-06-21 16:39:04'),
('a1a9b664-2fb6-41ce-851e-24b1e57f4cfd','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('a7f6d55e-0cc7-4cb5-bcaf-50ecf417a5e9','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:17:45','2020-06-22 19:17:52'),
('ac764343-47f0-49af-be95-517a70091956','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-23 02:05:28','2020-06-23 10:28:00'),
('b40b08e0-65ad-400d-b59c-0fc7d4e3bb3e','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:44','2020-06-22 19:17:52'),
('b56a430b-868c-415e-bb73-3d5894d858ee','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('b750c3cb-8b61-4442-837d-265b81578396','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('b8cd343f-a3b0-4fd7-aa52-957a0affe7a7','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('b9206997-3e90-4470-b253-c2727df2e6f2','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 11:16:53','2020-06-23 03:00:15','2020-06-23 11:16:53'),
('ba115736-8461-4ed2-8272-b89d9b83730d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('bb676016-b3fa-431b-a5a5-61136c99135c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:53','2020-06-22 19:17:52'),
('c516221d-a11d-439a-abc9-d9f2eb4ff14b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:28:00','2020-06-21 16:39:04'),
('c517960c-e946-4259-b9b5-1f10192750f5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:44','2020-06-22 19:17:52'),
('c7798fb6-7ce0-4141-9c70-f4ed3667b115','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:27:38','2020-06-21 16:39:04'),
('cba497fa-82a9-4b36-94b2-0285e5b6df72','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('ccfb9296-fd68-47f0-8a20-169d61b71e0d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:24:54','2020-06-22 19:25:06'),
('cd7f25ca-6db3-4f89-8dde-8487ced93f3b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('d1e42710-4428-4caa-8b84-53ad601312d8','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:14:40','2020-06-22 19:17:52'),
('d56ed11c-50dd-49a3-b9de-e65eb40dcdb3','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('d7a3e7b7-90ba-4f2e-8c06-288e1fa6764a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('d8805bec-1eab-4589-bea4-b0b72a8e6d76','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 05:47:34','2020-06-21 16:39:04'),
('db5eb27d-08aa-4a8b-8228-21949fa03dc4','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:15:48','2020-06-22 19:17:52'),
('dfdd3552-5753-4a57-bf86-f537bf38c627','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:44','2020-06-22 19:17:52'),
('e1cc60c1-4ae6-4785-a9cb-3d022bcc5556','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:20','2020-06-22 19:19:57'),
('e3e890c9-f03e-41bf-a40d-e074fdaa8fa0','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('e75e6eb2-37f7-4b24-8032-6eaf42660a86','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('e89b8219-3b93-44fb-971b-79600fd3f1cc','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:28','2020-06-22 19:19:57'),
('ea8d5d79-e542-4f1d-8d68-8a6d9c36b103','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:21:39','2020-06-21 16:39:04'),
('eca4d87f-3957-4cc7-93d1-0905dfce613a','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 05:51:28','2020-06-21 16:39:04'),
('ed50adf9-c95d-4a99-bcc0-b37c1834480a','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-22 14:19:17','2020-06-23 10:28:00'),
('eee8446b-07a4-469e-b3c0-1eb702539c80','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 22:15:53','2020-06-22 12:01:41','2020-06-22 22:15:53'),
('f0178c3a-2534-430a-9259-4cbcbca3d97f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:25:00','2020-06-22 19:25:06'),
('f0cf2774-3a31-4a4e-8fe3-710235d58763','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 10:58:06','2020-06-22 19:17:52'),
('f13fb611-863f-424d-92d8-ec13afb600d0','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:12:17','2020-06-21 16:39:04'),
('f505ac17-eade-436b-adc8-0636a3654f97','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:06:39','2020-06-21 16:39:04'),
('f5c5b929-b55b-4d57-af34-d165b298c319','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:38:53','2020-06-21 16:39:04'),
('f6727ea1-953a-4907-bee4-ce5c4fa613c6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`email`,`password`,`pelaporan`,`kode_invitation`,`reward`,`verify_admin`,`image`,`nomor_hp`,`ktp`,`role`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'I Putu Alin Winata Gotama','alsan','alingotama14@gmail.com','$2y$10$pbToID5ZL6BED569zaF2F.exM3wkZQlYOb.RwKG1ViNfbClrgUYeG',0,'ip5ga',0,1,'default.png',NULL,'ktp_default.jpg','admin','2020-06-18 03:05:02','2020-06-18 03:05:02',NULL),
(2,'I Kadek Santa Buana Gotama','santa','santa@gmail.comn','$2y$10$8KwjSrpefy1an3Qys3oE7eOOBAF8CVCt7yjNeFyANDK/Aa2gW7jC6',0,'asd12',0,1,'qjYTD5bDC6LgehEj4z3qabQKMd4rHsfAt1CWUonk.jpeg','0855681861','ZqwcfJtPXkhgO520y16KBxYmWAbOa8yBFsG7nnez.jpeg','user','2020-06-18 18:05:33','2020-06-23 03:00:15',NULL),
(3,'Jamaikan','jamaikan','jamaikan@gmail.com','$2y$10$8KwjSrpefy1an3Qys3oE7eOOBAF8CVCt7yjNeFyANDK/Aa2gW7jC6',0,'64uc3',0,1,'default.png','123124121','ktp_default.jpg','user','2020-06-18 12:55:10','2020-06-22 11:25:17',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
