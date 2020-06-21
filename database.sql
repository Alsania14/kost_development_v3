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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `kamars` */

insert  into `kamars`(`id`,`user_id`,`nomor`,`tipe_pembayaran`,`tgl_awal_sewa`,`tgl_bayar_selanjutnya`,`status_pembayaran`,`keluhan`,`created_at`,`updated_at`,`deleted_at`) values 
(1,3,1,'bulan','2020-06-01','2020-06-20','lunas','tidak','2020-06-18 17:44:30','2020-06-18 17:44:34',NULL),
(2,2,2,'bulan','2020-06-01','2020-07-01','lunas','tidak','2020-06-19 20:53:37','2020-06-19 20:53:40',NULL);

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
  `tipe_pembayaran` enum('bulan','tahun') DEFAULT NULL,
  `tgl_awal_sewa` date NOT NULL,
  `tgl_akhir_sewa` date NOT NULL,
  `status_tagihan` enum('hutang','lunas') DEFAULT NULL,
  `tgl_pembayaran` date NOT NULL,
  `nominal_pembayaran` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

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
('05eddc7c-54dc-47e5-b147-2665426ef3f4','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:38','2020-06-21 13:43:54'),
('13387f6b-8113-431e-ad4f-57b95359f760','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:13:35','2020-06-21 07:11:59','2020-06-21 15:13:35'),
('1787fd27-11d0-4eb9-aee3-23b447aa6d5b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:23','2020-06-21 13:59:28'),
('1fffc4d1-35a3-42ef-9eec-b325b2080334','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:09','2020-06-21 13:59:28'),
('23dae3d5-0af9-46db-88ea-9a7dc023bb80','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:05:26','2020-06-21 13:43:54'),
('2b6e4eb0-4f64-407e-9139-e945d0872a15','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:47','2020-06-21 13:43:54'),
('336e3950-3096-46cc-bfbd-a461547beef5','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:22:36','2020-06-21 07:21:47','2020-06-21 15:22:36'),
('3c4a1a5e-1322-45cb-b529-55f84a39d57e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:14','2020-06-21 13:59:28'),
('598d8681-7e14-4f20-9cec-06762b74f041','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 04:35:41','2020-06-21 15:44:36'),
('5c6c7b06-e08b-42b2-bfde-d22cc94929dc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 05:51:18','2020-06-21 15:44:36'),
('5d2a0d86-637c-443f-abf8-e7714e2ce54e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:12:07','2020-06-21 15:44:36'),
('7ed894e6-f849-47ef-8fac-23bd716d70ac','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Pembayaran Succes\",\"text\" : \"Pembayaran secara manual berhasil dilakukan, silahkan tunggu verifikasi admin\", \"type\" : \"special\"}',NULL,'2020-06-21 04:07:10','2020-06-21 15:44:36'),
('9c6c5f9a-245b-40d1-b7d5-30e95184a3d3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 04:27:38','2020-06-21 13:43:54'),
('a15ca2a5-7721-4c4e-a3a6-3f15cfdb00bd','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:12:12','2020-06-21 15:13:35'),
('c516221d-a11d-439a-abc9-d9f2eb4ff14b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 04:28:00','2020-06-21 13:43:54'),
('c7798fb6-7ce0-4141-9c70-f4ed3667b115','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 04:27:38','2020-06-21 13:43:54'),
('d8805bec-1eab-4589-bea4-b0b72a8e6d76','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 05:47:34','2020-06-21 13:59:28'),
('ea8d5d79-e542-4f1d-8d68-8a6d9c36b103','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:21:39','2020-06-21 15:22:36'),
('eca4d87f-3957-4cc7-93d1-0905dfce613a','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 05:51:28','2020-06-21 13:59:28'),
('f13fb611-863f-424d-92d8-ec13afb600d0','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:12:17','2020-06-21 15:13:35'),
('f505ac17-eade-436b-adc8-0636a3654f97','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:06:39','2020-06-21 15:10:56'),
('f5c5b929-b55b-4d57-af34-d165b298c319','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-21 07:38:53','2020-06-21 15:44:36');

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
(2,'I Kadek Santa Buana Gotama','santa','santa@gmail.comn','$2y$10$SerP1RfbKUIge4TLhODaSe879hKy2GAK7WHD1m8GCK0nzW6mJ1vwa',0,'asd12',0,1,'7NF8tYNJJLmWb80fGnEyE7ZrWRot4O59E5eAjUoo.jpeg','0855681861','P2oQ2nSUTE7n6GfrGWn9cfo1iaeHkE8ejjqajc07.jpeg','user','2020-06-18 18:05:33','2020-06-21 07:38:53',NULL),
(3,'Jamaikan','jamaikan','jamaikan@gmail.com','$2y$10$vXY4jiLbJUGj.5XnCEpNJuiDunWp9J0OpVcB13XFJpfoPBHby/T/O',0,'64uc3',0,1,'default.png','123124121','ktp_default.jpg','user','2020-06-18 12:55:10','2020-06-20 10:41:05',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
