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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_kost_development` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_kost_development`;

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
(1,1,1,'bulan',500001,'2020-01-02','2020-02-02','2020-03-02','hutang','tidak','on','2020-06-18 17:44:30','2020-06-25 12:07:24',NULL),
(2,2,2,'bulan',500002,'2020-01-31','2020-02-29','2020-03-31','hutang','tidak','on','2020-06-19 20:53:37','2020-06-25 12:07:24',NULL),
(3,3,3,'bulan',500003,'2020-01-15','2020-02-15','2020-03-15','hutang','tidak','on','2020-06-25 11:51:37','2020-06-25 12:07:25',NULL),
(4,4,4,'bulan',500004,'2020-01-31','2020-02-29','2020-03-31','hutang','tidak','on','2020-06-25 11:52:45','2020-06-25 12:07:25',NULL),
(5,5,5,'bulan',500005,'2020-01-16','2020-02-16','2020-03-16','hutang','tidak','on',NULL,'2020-06-25 12:07:25',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `tagihans` */

insert  into `tagihans`(`id`,`user_id`,`kamar_id`,`tipe_pembayaran`,`tgl_awal_sewa`,`tgl_akhir_sewa`,`status_tagihan`,`tgl_pembayaran`,`nominal_pembayaran`,`created_by`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_user`) values 
(1,1,1,'bulan','2020-02-02','2020-03-02','lunas',NULL,500001,'system','2020-06-25 12:07:24','2020-06-25 05:09:42',NULL,0),
(2,2,2,'bulan','2020-02-29','2020-03-31','lunas',NULL,500002,'system','2020-06-25 12:07:24','2020-06-25 05:16:12','2020-06-25 14:36:58',0),
(3,3,3,'bulan','2020-02-15','2020-03-15','hutang',NULL,500003,'system','2020-06-25 12:07:25','2020-06-25 12:07:25',NULL,0),
(4,4,4,'bulan','2020-02-29','2020-03-31','hutang',NULL,500004,'system','2020-06-25 12:07:25','2020-06-25 12:07:25',NULL,0),
(5,5,5,'bulan','2020-02-16','2020-03-16','hutang',NULL,500005,'system','2020-06-25 12:07:25','2020-06-25 12:07:25',NULL,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `transaksis` */

insert  into `transaksis`(`id`,`order_id`,`transaction_id`,`tagihan_id`,`tgl_awal`,`tgl_akir`,`nominal`,`via`,`integration_name`,`status_pembayaran`,`bukti_transaksi`,`field_1`,`field_2`,`tgl_lunas`,`developer_information_charge`,`developer_information_finish`,`developer_information_last_notification`,`created_at`,`updated_at`,`deleted_at`,`deleted_by_user`) values 
(1,'TAC-ALPHA-I-00001',NULL,5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197431936436',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"0c1310bb-a7cf-43b0-a405-c41db1ace37e\",\"order_id\":\"TAC-ALPHA-I-00001\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:09:41\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197431936436\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:09:38','2020-06-25 06:54:18',NULL,0),
(2,'TAC-ALPHA-I-00002',NULL,5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197426096171',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"ed42e973-1249-45a2-802d-cfb80bc742d9\",\"order_id\":\"TAC-ALPHA-I-00002\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:10:42\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197426096171\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:10:38','2020-06-25 06:11:11',NULL,0),
(3,'TAC-ALPHA-I-00003',NULL,5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197431466179',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"d719346c-f183-42ef-aba2-7f8a6081dc8e\",\"order_id\":\"TAC-ALPHA-I-00003\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:10:53\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197431466179\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:10:50','2020-06-25 06:11:08',NULL,0),
(4,'TAC-ALPHA-I-00004',NULL,5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197471765463',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"84fcf6d9-9726-441d-b32f-dc4b4291659d\",\"order_id\":\"TAC-ALPHA-I-00004\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:11:02\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197471765463\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:10:59','2020-06-25 06:06:12',NULL,0),
(5,'TAC-ALPHA-I-00005',NULL,5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197450290310',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"2e91ab0c-34fb-45ff-8c07-b88140b026d7\",\"order_id\":\"TAC-ALPHA-I-00005\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:11:10\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197450290310\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:11:07','2020-06-25 06:06:17',NULL,0),
(6,'TAC-ALPHA-I-00006',NULL,4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','proses',NULL,'9883197411749837',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"9dc141e9-9f0f-481b-8f06-92a3abf7b3e3\",\"order_id\":\"TAC-ALPHA-I-00006\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:32:07\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197411749837\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:32:03','2020-06-25 12:32:03',NULL,0),
(7,'TAC-ALPHA-I-00007',NULL,4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','proses',NULL,'9883197486690487',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"7b37e995-d791-4531-a6e4-a4bfb0cb069c\",\"order_id\":\"TAC-ALPHA-I-00007\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:32:15\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197486690487\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:32:11','2020-06-25 12:32:11',NULL,0),
(8,'TAC-ALPHA-I-00008',NULL,4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','proses',NULL,'9883197447921226',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"ab9e4c50-97d2-4f33-9944-20d445ce6c0d\",\"order_id\":\"TAC-ALPHA-I-00008\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:32:23\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197447921226\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:32:19','2020-06-25 12:32:19',NULL,0),
(9,'TAC-ALPHA-I-00009',NULL,4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','proses',NULL,'9883197466637544',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"1dc7676f-6732-421d-a5a4-8dc814a1dc2f\",\"order_id\":\"TAC-ALPHA-I-00009\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:32:29\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197466637544\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:32:26','2020-06-25 12:32:26',NULL,0),
(10,'TAC-ALPHA-I-00010',NULL,4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','proses',NULL,'9883197481707398',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"1901a8db-24c6-42f3-a572-47d23ad1bdb5\",\"order_id\":\"TAC-ALPHA-I-00010\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:32:38\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197481707398\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:32:35','2020-06-25 12:32:35',NULL,0),
(11,'TAC-ALPHA-I-00011',NULL,3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197456728651',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"110b36a8-43f2-402d-87ac-27213da1d5f8\",\"order_id\":\"TAC-ALPHA-I-00011\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:37:44\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197456728651\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:37:40','2020-06-25 04:37:42',NULL,0),
(12,'TAC-ALPHA-I-00012',NULL,3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197418577132',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"9f671a68-96d0-4e34-9c84-973de71d7626\",\"order_id\":\"TAC-ALPHA-I-00012\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:37:54\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197418577132\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:37:51','2020-06-25 04:37:52',NULL,0),
(13,'TAC-ALPHA-I-00013',NULL,3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197463665133',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"9cc1c6ca-ca09-4b9e-921f-84aa1ff510f9\",\"order_id\":\"TAC-ALPHA-I-00013\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:38:01\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197463665133\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:37:59','2020-06-25 04:37:59',NULL,0),
(14,'TAC-ALPHA-I-00014',NULL,3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197405543833',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"eea129a3-bac9-479c-93f3-3c172465373a\",\"order_id\":\"TAC-ALPHA-I-00014\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:39:17\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197405543833\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:39:14','2020-06-25 04:39:16',NULL,0),
(15,'TAC-ALPHA-I-00015',NULL,3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197404198189',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"941423f1-11d2-4d37-9f19-55d6a9579a8a\",\"order_id\":\"TAC-ALPHA-I-00015\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:39:31\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197404198189\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:39:28','2020-06-25 04:39:30',NULL,0),
(16,'TAC-ALPHA-I-00016',NULL,2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','pending',NULL,'9883197402051050',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"5552770a-79a0-4593-aeb6-de0f3d957fc8\",\"order_id\":\"TAC-ALPHA-I-00016\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:42:22\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197402051050\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:42:18','2020-06-25 04:42:20',NULL,0),
(17,'TAC-ALPHA-I-00017',NULL,2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','pending',NULL,'9883197441056271',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"20610389-0be7-4aaf-8ee7-c4e1e682499c\",\"order_id\":\"TAC-ALPHA-I-00017\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:43:02\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197441056271\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:42:59','2020-06-25 04:43:01',NULL,0),
(18,'TAC-ALPHA-I-00018',NULL,2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','pending',NULL,'9883197407510129',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"5e41a5f6-60d3-43b5-9f3a-735dc0e4865f\",\"order_id\":\"TAC-ALPHA-I-00018\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:43:10\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197407510129\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:43:06','2020-06-25 04:43:08',NULL,0),
(19,'TAC-ALPHA-I-00019',NULL,2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','pending',NULL,'9883197483853514',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"e220372b-4812-4663-99a1-78f4e0fd8d06\",\"order_id\":\"TAC-ALPHA-I-00019\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:43:55\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197483853514\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:43:52','2020-06-25 04:43:53',NULL,0),
(20,'TAC-ALPHA-I-00020',NULL,2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','pending',NULL,'9883197413175550',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"32e31ffd-5581-43c8-bdeb-d7cc6f803508\",\"order_id\":\"TAC-ALPHA-I-00020\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:44:11\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197413175550\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:44:07','2020-06-25 04:44:08',NULL,0),
(21,'TAC-ALPHA-I-00021',NULL,1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197468281726',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"a30d5c7c-fba3-4e5e-a80e-bb32c56fcef9\",\"order_id\":\"TAC-ALPHA-I-00021\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:45:17\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197468281726\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:45:13','2020-06-25 06:57:56',NULL,0),
(22,'TAC-ALPHA-I-00022',NULL,1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197492611561',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"f7ad5177-087c-4785-971c-ce99bc818433\",\"order_id\":\"TAC-ALPHA-I-00022\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:45:25\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197492611561\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:45:21','2020-06-25 06:57:54',NULL,0),
(23,'TAC-ALPHA-I-00023',NULL,1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197442911430',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"b97eb107-50b2-4077-aafd-0f9af688c13d\",\"order_id\":\"TAC-ALPHA-I-00023\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:45:33\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197442911430\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:45:29','2020-06-25 06:52:53',NULL,0),
(24,'TAC-ALPHA-I-00024',NULL,1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197470782177',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"d68480ed-f77f-4fb5-a4b4-9a1c9a73089d\",\"order_id\":\"TAC-ALPHA-I-00024\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:46:20\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197470782177\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:46:17','2020-06-25 06:53:02',NULL,0),
(25,'TAC-ALPHA-I-00025',NULL,1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','pending',NULL,'9883197491759141',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"896634b4-a6b9-405b-be4d-41816732360b\",\"order_id\":\"TAC-ALPHA-I-00025\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:46:26\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197491759141\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:46:22','2020-06-25 06:49:15',NULL,0),
(26,'TAC-ALPHA-I-00026','7353bf01-1ff6-4b53-9551-9ac878df5b90',5,'2020-02-16','2020-03-16',500005,'bank_transfer','bni','pending',NULL,'9883197479889792',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"7353bf01-1ff6-4b53-9551-9ac878df5b90\",\"order_id\":\"TAC-ALPHA-I-00026\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500005.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 11:58:58\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197479889792\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 12:58:54','2020-06-25 04:58:56',NULL,0),
(27,'TAC-ALPHA-I-00027','c963ac95-2086-483b-b1b1-7501bb5f3be4',4,'2020-02-29','2020-03-31',500004,'bank_transfer','bni','pending',NULL,'9883197442420105',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"c963ac95-2086-483b-b1b1-7501bb5f3be4\",\"order_id\":\"TAC-ALPHA-I-00027\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500004.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 12:00:21\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197442420105\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 13:00:18','2020-06-25 05:00:19',NULL,0),
(28,'TAC-ALPHA-I-00028','15f6a91d-0d1f-4fbf-9485-2de371dd4050',3,'2020-02-15','2020-03-15',500003,'bank_transfer','bni','pending',NULL,'9883197458323241',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"15f6a91d-0d1f-4fbf-9485-2de371dd4050\",\"order_id\":\"TAC-ALPHA-I-00028\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500003.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 12:01:31\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197458323241\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 13:01:27','2020-06-25 05:01:29',NULL,0),
(29,'TAC-ALPHA-I-00029','630c7c33-8cd0-4df9-b309-aa7f0398f37e',2,'2020-02-29','2020-03-31',500002,'bank_transfer','bni','approved',NULL,'9883197439517065',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"630c7c33-8cd0-4df9-b309-aa7f0398f37e\",\"order_id\":\"TAC-ALPHA-I-00029\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500002.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 12:02:06\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197439517065\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 13:02:03','2020-06-25 05:16:12',NULL,0),
(30,'TAC-ALPHA-I-00030','1beeb28c-b4c4-421c-8fc9-f1330db0e892',1,'2020-02-02','2020-03-02',500001,'bank_transfer','bni','approved',NULL,'9883197433347591',NULL,NULL,'{\"status_code\":\"201\",\"status_message\":\"Success, Bank Transfer transaction is created\",\"transaction_id\":\"1beeb28c-b4c4-421c-8fc9-f1330db0e892\",\"order_id\":\"TAC-ALPHA-I-00030\",\"merchant_id\":\"G356931974\",\"gross_amount\":\"500001.00\",\"currency\":\"IDR\",\"payment_type\":\"bank_transfer\",\"transaction_time\":\"2020-06-25 12:03:29\",\"transaction_status\":\"pending\",\"va_numbers\":[{\"bank\":\"bni\",\"va_number\":\"9883197433347591\"}],\"fraud_status\":\"accept\"}',NULL,NULL,'2020-06-25 13:03:25','2020-06-25 06:57:57',NULL,0);

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
('000d320b-017d-4035-98c4-5b27734785d7','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00007  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:32:11','2020-06-25 12:32:11'),
('047ef0f5-fe71-4366-85b4-b84283af339f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('05eddc7c-54dc-47e5-b147-2665426ef3f4','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:38','2020-06-21 13:43:54'),
('0dacca43-5a74-4097-b809-0f9ac4908f94','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00020  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 12:44:07','2020-06-25 13:02:38'),
('0e8cd7d6-7870-430e-9f70-030d77644dda','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('108c3d0b-7b9a-47c2-9f0c-7bc5e473f8bc','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:18:00','2020-06-22 19:19:12'),
('116f8d3e-4078-4524-8bab-0df303cb6b06','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 11:20:41','2020-06-23 19:23:20'),
('13387f6b-8113-431e-ad4f-57b95359f760','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:13:35','2020-06-21 07:11:59','2020-06-21 15:13:35'),
('137f3f03-b658-4d44-8029-8258cf1d1365','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00012  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:37:51','2020-06-25 12:37:51'),
('14b1dcda-82d7-465a-929b-7967d1410785','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('16ff44d0-c6e8-47e1-8d09-fcafb7fdce55','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('1787fd27-11d0-4eb9-aee3-23b447aa6d5b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:23','2020-06-21 13:59:28'),
('1a71d3f4-4933-4e7d-b7d2-24391be01d5a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('1a8306eb-260c-44c3-baaf-c14abf46a949','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('1d394195-d155-4ebf-8aa2-199859fc3d67','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('1fffc4d1-35a3-42ef-9eec-b325b2080334','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:09','2020-06-21 13:59:28'),
('2110a729-d71a-4408-a60b-e0d49163b68a','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00006  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:32:03','2020-06-25 12:32:03'),
('22062e44-d4cd-44a3-a6aa-ed5fc4ff8bab','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('235266f2-b456-47e2-810c-4f5bf5c1d123','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('23dae3d5-0af9-46db-88ea-9a7dc023bb80','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:05:26','2020-06-21 13:43:54'),
('2732a765-435a-4a0d-bc66-2b4dff11aea6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('2b6e4eb0-4f64-407e-9139-e945d0872a15','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:43:54','2020-06-21 04:35:47','2020-06-21 13:43:54'),
('2ca45a2c-124f-4f76-ad4e-5f36bb55cee1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:20','2020-06-22 19:25:06'),
('2fa26603-75a4-4728-90a7-4f296246cde8','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00026  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:58:54','2020-06-25 12:58:54'),
('301d5e2a-7da7-454f-8b51-6a6efb9c3892','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('336e3950-3096-46cc-bfbd-a461547beef5','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 15:22:36','2020-06-21 07:21:47','2020-06-21 15:22:36'),
('351590ac-a38f-4774-8486-09963491c861','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('36bca704-4cb3-4411-bd9b-8d5f6d77e48b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:15:48','2020-06-22 19:17:52'),
('3754803b-b96a-44dc-909a-f585b573e0c7','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00019  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 12:43:52','2020-06-25 13:02:38'),
('37ae67d0-6eea-4c77-9c97-c665858ace4b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00029  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 13:02:03','2020-06-25 13:02:38'),
('3bc91dac-49f4-4be5-bbf8-8613428b5117','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('3c4a1a5e-1322-45cb-b529-55f84a39d57e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 13:59:28','2020-06-21 05:51:14','2020-06-21 13:59:28'),
('40b0fe81-fdf3-48dc-bb9a-6974a430969e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00017  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 12:42:59','2020-06-25 13:02:38'),
('44d76228-f2f6-4b9e-9032-939ddd3c81ab','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-22 14:19:33','2020-06-23 10:28:00'),
('4549ea3e-976f-4f07-884f-249b64f50ad8','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:14:57','2020-06-22 19:17:52'),
('484da515-ee70-4925-8fbe-61476a063ef6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}',NULL,'2020-06-22 12:04:03','2020-06-22 12:04:03'),
('4962ed7c-3025-4163-a387-d767c211a9cc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 11:21:16','2020-06-23 19:23:20'),
('4996a893-3cbf-4834-8221-5ae87edcae8b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00018  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 12:43:07','2020-06-25 13:02:38'),
('4a14ed6e-7d70-49ee-8bc9-88e1f5ee687a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00028  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 13:01:27','2020-06-25 13:01:27'),
('4aa3c5a9-1c71-4ed1-b763-65e8109429b1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00013  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:37:59','2020-06-25 12:37:59'),
('4b96345a-69bf-4983-b053-dbcfaaaa6ca5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('4dd3574e-405c-40c7-9a93-da2db3ee47e5','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 11:22:03','2020-06-23 03:21:30','2020-06-23 11:22:03'),
('4eedcd67-26d6-435b-8290-2279d2a91fc4','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 11:21:39','2020-06-23 19:23:20'),
('507ca45c-3d2e-4297-898a-00d08e65f129','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('52cbb3c6-073c-4500-bf87-2b65ed1051bc','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00010  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:32:35','2020-06-25 12:32:35'),
('5315e5fd-28fa-4bad-a1e7-afaed4d0c439','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-24 21:23:15','2020-06-25 13:02:38'),
('56490615-d517-4048-8c31-55a8703dcd47','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:15:55','2020-06-22 19:17:52'),
('56a1938a-2544-4057-a997-7a37ff5e5619','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00004  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 12:47:04','2020-06-25 12:10:59','2020-06-25 12:47:04'),
('57e0c4b1-de5b-48c5-a50a-1815f174499c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('598d8681-7e14-4f20-9cec-06762b74f041','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:35:41','2020-06-21 16:39:04'),
('5a97e782-cddc-4ed6-afe8-aeaf3b975abb','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-23 02:27:50','2020-06-23 10:28:00'),
('5c6c7b06-e08b-42b2-bfde-d22cc94929dc','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 05:51:18','2020-06-21 16:39:04'),
('5d2a0d86-637c-443f-abf8-e7714e2ce54e','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:12:07','2020-06-21 16:39:04'),
('645a9f0b-b7f6-4fa5-984d-0b63119d6efa','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:08','2020-06-22 19:25:06'),
('687a9199-91de-459c-a0e7-38779541c66a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('6c7a72e6-e460-4cf1-b457-b19bcfb1a008','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:08','2020-06-22 19:25:06'),
('6e90e68d-ef80-4ffe-ac38-f67a99d3a879','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00009  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:32:26','2020-06-25 12:32:26'),
('71d85919-b0f2-4933-af51-5e7684568813','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00021  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:45:13','2020-06-25 12:45:13'),
('7314c9f1-0fd5-442d-add2-c78e10f27b9a','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00011  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:37:41','2020-06-25 12:37:41'),
('76d0abb8-2d2a-4483-96e2-cdf779f558a3','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('77d01677-505d-4001-9224-7f5187db9eb1','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:38','2020-06-22 11:25:17','2020-06-22 19:25:38'),
('78ed26c9-dca8-4f4b-b1ff-3702b3151b37','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-SAND-BOX-ALPHA-00020  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-24 21:21:33','2020-06-24 21:07:26','2020-06-24 21:21:33'),
('7912a05b-9f6b-42c6-b8b1-38b2e361c1e8','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 12:47:04','2020-06-25 12:10:50','2020-06-25 12:47:04'),
('7aef18bb-fcdb-4a02-a5a5-ca5d93b1d07b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00016  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 13:02:38','2020-06-25 12:42:18','2020-06-25 13:02:38'),
('7b08db19-66e5-4581-9d4e-47baf0498091','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 11:23:00','2020-06-23 19:23:20'),
('7c6260f5-350c-4581-ad5a-8bb1a8f4d680','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00008  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:32:19','2020-06-25 12:32:19'),
('7ed894e6-f849-47ef-8fac-23bd716d70ac','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Pembayaran Succes\",\"text\" : \"Pembayaran secara manual berhasil dilakukan, silahkan tunggu verifikasi admin\", \"type\" : \"special\"}','2020-06-21 16:39:04','2020-06-21 04:07:10','2020-06-21 16:39:04'),
('7edfc7e5-5779-4cce-8f47-06008aeac6ef','App\\Notifications\\UserNotification','App\\User',4,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00027  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 13:00:18','2020-06-25 13:00:18'),
('8248a050-5ae6-4064-a0dc-026179b87d66','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:07','2020-06-22 19:25:06'),
('8480010a-f065-4828-9180-da3d9f457c78','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 10:57:47','2020-06-22 19:17:52'),
('88d4c2ac-5b25-4c67-a2e0-e5b64e43309f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('8b14e171-541b-4ffd-baf2-82515df062be','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00024  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:46:17','2020-06-25 12:46:17'),
('8cb8fbca-b797-4e87-be28-03c425a74bc7','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00015  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:39:28','2020-06-25 12:39:28'),
('8fe1dc2c-6328-4035-9370-43caef6d2d52','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 10:58:06','2020-06-22 19:17:52'),
('91205501-735b-48e9-9a5e-ff945059909c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:54','2020-06-22 19:17:52'),
('915bbab6-6a9a-40e5-88ee-cb8aa867072f','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:12','2020-06-22 11:17:59','2020-06-22 19:19:12'),
('927fdf00-712f-4f31-8729-f35f5afc7022','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 12:47:04','2020-06-25 12:10:39','2020-06-25 12:47:04'),
('9b4e4d15-6125-4182-9c8f-668ef73806c2','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:14:40','2020-06-22 19:17:52'),
('9c6c5f9a-245b-40d1-b7d5-30e95184a3d3','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:27:38','2020-06-21 16:39:04'),
('9fd572cf-72f0-494c-886d-7acccd2cd264','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:28','2020-06-22 19:19:57'),
('a15ca2a5-7721-4c4e-a3a6-3f15cfdb00bd','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 07:12:12','2020-06-21 16:39:04'),
('a1a9b664-2fb6-41ce-851e-24b1e57f4cfd','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:05','2020-06-22 19:25:06'),
('a1c63235-f2a4-46f5-88cd-488e35f9d203','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 11:20:05','2020-06-23 19:23:20'),
('a2a61c34-207b-405f-b5e2-04cdf962bed5','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00005  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 12:47:04','2020-06-25 12:11:07','2020-06-25 12:47:04'),
('a7f6d55e-0cc7-4cb5-bcaf-50ecf417a5e9','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:17:45','2020-06-22 19:17:52'),
('ac764343-47f0-49af-be95-517a70091956','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 10:28:00','2020-06-23 02:05:28','2020-06-23 10:28:00'),
('b40b08e0-65ad-400d-b59c-0fc7d4e3bb3e','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:44','2020-06-22 19:17:52'),
('b56a430b-868c-415e-bb73-3d5894d858ee','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('b663dc24-1c1f-444e-9a77-2437c8c80f2a','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00023  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:45:30','2020-06-25 12:45:30'),
('b750c3cb-8b61-4442-837d-265b81578396','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:23:06','2020-06-22 19:25:06'),
('b8cd343f-a3b0-4fd7-aa52-957a0affe7a7','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('b9206997-3e90-4470-b253-c2727df2e6f2','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 11:16:53','2020-06-23 03:00:15','2020-06-23 11:16:53'),
('b9e1f0a5-d629-4b6a-a9c2-2c91adfb57e5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-00002  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-24 21:23:51','2020-06-24 21:23:51'),
('ba115736-8461-4ed2-8272-b89d9b83730d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:32','2020-06-22 19:25:06'),
('bb676016-b3fa-431b-a5a5-61136c99135c','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:53','2020-06-22 19:17:52'),
('bf793ebf-d460-4180-a4d2-5d9a12c3f502','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00025  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:46:22','2020-06-25 12:46:22'),
('c2305356-fc1d-4beb-bab5-189fe8b947cf','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-00003  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-24 21:29:01','2020-06-24 21:29:01'),
('c516221d-a11d-439a-abc9-d9f2eb4ff14b','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:28:00','2020-06-21 16:39:04'),
('c517960c-e946-4259-b9b5-1f10192750f5','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:17:52','2020-06-22 11:02:44','2020-06-22 19:17:52'),
('c7798fb6-7ce0-4141-9c70-f4ed3667b115','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-21 16:39:04','2020-06-21 04:27:38','2020-06-21 16:39:04'),
('c7b5fe30-f417-47bf-beb8-50d29afb269d','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00030  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 13:03:25','2020-06-25 13:03:25'),
('ca277cbd-e9f8-47bc-8f65-f8d5918512e0','App\\Notifications\\UserNotification','App\\User',5,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00001  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}','2020-06-25 12:47:04','2020-06-25 12:09:39','2020-06-25 12:47:04'),
('cb2c54bf-c167-43fa-91a6-d37a3770c53c','App\\Notifications\\UserNotification','App\\User',2,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-23 19:23:20','2020-06-23 05:01:21','2020-06-23 19:23:20'),
('cb99c683-6202-4eee-b8fb-0329c245b353','App\\Notifications\\UserNotification','App\\User',1,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00022  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:45:21','2020-06-25 12:45:21'),
('cba497fa-82a9-4b36-94b2-0285e5b6df72','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:19:57','2020-06-22 11:19:29','2020-06-22 19:19:57'),
('ccfb9296-fd68-47f0-8a20-169d61b71e0d','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:24:54','2020-06-22 19:25:06'),
('cd7f25ca-6db3-4f89-8dde-8487ced93f3b','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"Update Profile\",\"text\" : \"Profile anda telah diperbaharui , pastikan anda memberikan identitas dan dokumen yang valid\", \"type\" : \"common\"}','2020-06-22 19:25:06','2020-06-22 11:21:31','2020-06-22 19:25:06'),
('ce4783fd-9a6f-4567-a024-7aa6589b66d6','App\\Notifications\\UserNotification','App\\User',3,'{\"title\" : \"CHARGE BERHASIL !\",\"text\" : \"Tagihan dengan Order ID TAC-ALPHA-I-00014  telah berhasil di Charge, Seilahkan lanjutkan pembayaran dengan Virtual Account yang telah diberikan\",\"type\" : \"common\"}',NULL,'2020-06-25 12:39:14','2020-06-25 12:39:14'),
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
