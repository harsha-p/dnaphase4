-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: theme_park
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ATTRACTION`
--
DROP DATABASE IF EXISTS `theme_parkdb`;
CREATE SCHEMA `theme_parkdb`;
USE `theme_parkdb`;
DROP TABLE IF EXISTS `ATTRACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ATTRACTION` (
  `attraction_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `for_adult` tinyint NOT NULL DEFAULT '0',
  `for_child` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ATTRACTION`
--

LOCK TABLES `ATTRACTION` WRITE;
/*!40000 ALTER TABLE `ATTRACTION` DISABLE KEYS */;
INSERT INTO `ATTRACTION` VALUES (1,'Frog Hopper',0,1),(2,'Wilde Beast',1,0),(3,'The Bat',1,0),(4,'White Water Canyon',1,1),(5,'Timber wolf Falls',1,1);
/*!40000 ALTER TABLE `ATTRACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MAINTAINANCE_SCHEDULE`
--

DROP TABLE IF EXISTS `MAINTAINANCE_SCHEDULE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MAINTAINANCE_SCHEDULE` (
  `maintainer` char(9) NOT NULL,
  `attraction_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`attraction_id`,`maintainer`),
  KEY `maintainer` (`maintainer`),
  CONSTRAINT `MAINTAINANCE_SCHEDULE_ibfk_1` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MAINTAINANCE_SCHEDULE_ibfk_2` FOREIGN KEY (`maintainer`) REFERENCES `STAFF` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MAINTAINANCE_SCHEDULE`
--

LOCK TABLES `MAINTAINANCE_SCHEDULE` WRITE;
/*!40000 ALTER TABLE `MAINTAINANCE_SCHEDULE` DISABLE KEYS */;
INSERT INTO `MAINTAINANCE_SCHEDULE` VALUES ('11',1,'2020-10-12 09:00:00','2020-10-05 12:00:00'),('12',2,'2020-10-13 09:00:00','2020-10-13 12:00:00'),('13',3,'2020-10-12 09:00:00','2020-10-12 12:00:00'),('14',4,'2020-10-16 09:00:00','2020-10-16 12:00:00'),('15',5,'2020-10-13 09:00:00','2020-10-13 12:00:00');
/*!40000 ALTER TABLE `MAINTAINANCE_SCHEDULE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PHOTO`
--

DROP TABLE IF EXISTS `PHOTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PHOTO` (
  `ticket_id` char(10) NOT NULL,
  `attraction_id` int NOT NULL,
  `photo_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `photo_size` int NOT NULL,
  PRIMARY KEY (`ticket_id`,`attraction_id`,`photo_time`),
  KEY `attraction_id` (`attraction_id`),
  KEY `photo_size` (`photo_size`),
  CONSTRAINT `PHOTO_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `TICKET` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PHOTO_ibfk_2` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`) ON UPDATE CASCADE,
  CONSTRAINT `PHOTO_ibfk_3` FOREIGN KEY (`photo_size`) REFERENCES `PHOTO_COST` (`photo_size`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHOTO`
--

LOCK TABLES `PHOTO` WRITE;
/*!40000 ALTER TABLE `PHOTO` DISABLE KEYS */;
/*!40000 ALTER TABLE `PHOTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PHOTO_COST`
--

DROP TABLE IF EXISTS `PHOTO_COST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PHOTO_COST` (
  `photo_size` int NOT NULL,
  `photo_cost` char(3) NOT NULL,
  PRIMARY KEY (`photo_size`,`photo_cost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHOTO_COST`
--

LOCK TABLES `PHOTO_COST` WRITE;
/*!40000 ALTER TABLE `PHOTO_COST` DISABLE KEYS */;
INSERT INTO `PHOTO_COST` VALUES (1,'200'),(2,'300'),(3,'500');
/*!40000 ALTER TABLE `PHOTO_COST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STAFF`
--

DROP TABLE IF EXISTS `STAFF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STAFF` (
  `id` char(9) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `sex` enum('Male','Female','Others') DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `join_date` date NOT NULL,
  `working_hours` varchar(50) NOT NULL DEFAULT '0',
  `position` enum('Manager','Operator','Maintainer') NOT NULL,
  `salary` char(10) NOT NULL,
  `door_no` varchar(20) NOT NULL,
  `street` varchar(30) DEFAULT NULL,
  `pincode` char(10) NOT NULL,
  `attraction_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attraction_id` (`attraction_id`),
  CONSTRAINT `STAFF_ibfk_1` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STAFF`
--

LOCK TABLES `STAFF` WRITE;
/*!40000 ALTER TABLE `STAFF` DISABLE KEYS */;
INSERT INTO `STAFF` VALUES ('1','harsha','pathuri','Male','2001-10-06','2020-10-03','mon-thu 9am-9pm','Manager','30000','77-2-7/1','gandhipuram','533103',1),('10','yogendra','nagalla','Male','1985-03-30','2020-01-02','mon-fri 9am-9pm','Operator','15000','47-1-7','pushkarghat','533123',5),('11','vamsi','sunkavalli','Male','2000-01-13','2020-01-02','mon-fri 9am-9pm','Maintainer','8000','54-5-7/1','sayajigunji','533115',1),('12','sri kanya','Jhansi','Female','2002-07-23','2020-01-02','mon-fri 9am-9pm','Maintainer','70000','43-2-7/1','chinchi bundar','533153',2),('13','sandeep','chintala','Male','2000-05-13','2020-01-02','mon-fri 9am-9pm','Maintainer','7000','43-2-7/1','dlf road','533101',3),('14','vani','kantipudi','Female','2001-01-14','2020-01-02','mon-fri 9am-9pm','Maintainer','6000','47-2-7/1','jijabai rd','533102',4),('15','hanisha','bandaru','Female','1983-04-30','2020-01-02','mon-fri 9am-9pm','Maintainer','8000','32-5-45','katheru','533106',5),('2','kowshik','motepalli','Male','2002-04-18','2020-01-02','mon-fri 9am-9pm','Manager','25000','122-1-113','tilakroad','533101',2),('3','bhushan','thorati','Male','2001-09-02','2020-01-02','mon-fri 9am-9pm','Manager','25000','2-3/1','jn road','533232',3),('4','sri hari','malla','Male','2001-03-19','2020-01-02','mon-fri 9am-9pm','Manager','26000','7-3-5','katheru','533201',4),('5','ravi kishore','yerra','Male','2000-01-20','2020-01-02','mon-fri 9am-9pm','Manager','28000','5-8/3','motil nagar','533102',5),('6','sai kumar','boda','Male','1999-03-03','2020-01-02','mon-fri 9am-9pm','Operator','15000','73-2-7/1','hitesh-bustand','533105',1),('7','rahul','bongu','Male','2000-07-06','2020-01-02','mon-fri 9am-9pm','Operator','16000','7-7/1','lalacheruvu','533104',2),('8','Venkat','boyanapalli','Male','2000-01-15','2020-01-02','mon-fri 9am-9pm','Operator','16000','54-2-5/1','kotagummum','533105',3),('9','bhargav','yimmidisetty','Male','2000-01-31','2020-01-02','mon-fri 9am-9pm','Operator','14000','45-7/1','kotilingakarevu','533134',4);
/*!40000 ALTER TABLE `STAFF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STAFF_PHONENUMBERS`
--

DROP TABLE IF EXISTS `STAFF_PHONENUMBERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STAFF_PHONENUMBERS` (
  `staff_id` char(9) NOT NULL,
  `phone_number` char(15) NOT NULL,
  PRIMARY KEY (`staff_id`,`phone_number`),
  CONSTRAINT `STAFF_PHONENUMBERS_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `STAFF` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STAFF_PHONENUMBERS`
--

LOCK TABLES `STAFF_PHONENUMBERS` WRITE;
/*!40000 ALTER TABLE `STAFF_PHONENUMBERS` DISABLE KEYS */;
INSERT INTO `STAFF_PHONENUMBERS` VALUES ('1','7702000000'),('1','7702000001'),('10','8985799999'),('10','9763932109'),('11','9177800000'),('11','9320143801'),('12','9167812300'),('12','9704999999'),('13','9237800400'),('13','9849900000'),('14','7382326314'),('14','9640200000'),('14','9948100000'),('15','8179800000'),('2','9701199999'),('2','9704100000'),('3',' 9989100000'),('3',' 9989200000'),('4',' 8985600000'),('4','8179832100'),('5','8439830000'),('5','8985699999'),('6','8589700000'),('6','8985400000'),('7','9492599999'),('7','9963900000'),('8','8985599999'),('8','9563912300'),('9','9493300000'),('9','9763932100');
/*!40000 ALTER TABLE `STAFF_PHONENUMBERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TICKET`
--

DROP TABLE IF EXISTS `TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TICKET` (
  `ticket_id` char(10) NOT NULL,
  `ssn` char(9) NOT NULL,
  `ticket_type` int NOT NULL,
  `staff_id` char(9) NOT NULL,
  `issued_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket_id`),
  KEY `staff_id` (`staff_id`),
  KEY `ssn` (`ssn`),
  KEY `ticket_type` (`ticket_type`),
  CONSTRAINT `TICKET_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `STAFF` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `TICKET_ibfk_2` FOREIGN KEY (`ssn`) REFERENCES `VISITOR` (`ssn`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `TICKET_ibfk_3` FOREIGN KEY (`ticket_type`) REFERENCES `TICKET_COST` (`ticket_type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TICKET`
--

LOCK TABLES `TICKET` WRITE;
/*!40000 ALTER TABLE `TICKET` DISABLE KEYS */;
INSERT INTO `TICKET` VALUES ('6138479','138479',2,'6','2018-10-27 11:00:11'),('6245432','245432',1,'6','2019-01-10 09:43:20'),('6258709','258709',2,'6','2019-03-15 10:01:19'),('62719','2719',2,'6','2020-02-03 10:36:30'),('6495829','495829',2,'6','2018-07-08 12:33:40'),('6524235','524235',1,'6','2019-05-17 11:45:30'),('6752284','752284',2,'6','2018-01-17 10:22:50'),('7237089','237089',2,'7','2020-03-12 12:10:57'),('73492','3492',2,'7','2019-05-25 10:35:27'),('7778223','79223',2,'7','2019-09-20 11:15:06'),('798764','98764',2,'7','2020-02-09 10:25:08'),('798765','98765',2,'7','2020-02-09 10:34:30'),('798767','98767',1,'7','2020-02-09 10:43:26'),('798768','98768',1,'7','2020-02-09 10:52:23'),('823579','23579',2,'8','2018-11-30 13:10:34'),('828572','28572',2,'8','2018-02-22 11:23:42'),('845693','45693',2,'8','2019-02-01 13:11:30'),('849582','49582',2,'8','2020-08-02 10:19:55'),('85102','5102',2,'8','2019-03-28 10:37:35'),('851028','51028',2,'8','2018-04-26 09:22:22'),('866666','66666',2,'8','2018-08-28 09:23:20'),('927190','27190',1,'9','2019-03-20 11:33:29'),('928573','28573',2,'9','2018-02-16 12:37:12'),('934925','34925',1,'9','2019-09-03 11:57:15'),('945723','45723',2,'9','2020-03-01 10:41:02'),('951026','51026',1,'9','2019-07-28 12:47:10'),('96666','6666',2,'9','2020-07-29 10:38:41'),('966660','66660',1,'9','2018-08-03 12:38:29');
/*!40000 ALTER TABLE `TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TICKET_COST`
--

DROP TABLE IF EXISTS `TICKET_COST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TICKET_COST` (
  `ticket_type` int NOT NULL,
  `ticket_cost` char(5) NOT NULL,
  PRIMARY KEY (`ticket_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TICKET_COST`
--

LOCK TABLES `TICKET_COST` WRITE;
/*!40000 ALTER TABLE `TICKET_COST` DISABLE KEYS */;
INSERT INTO `TICKET_COST` VALUES (1,'2000'),(2,'3000');
/*!40000 ALTER TABLE `TICKET_COST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VISITED_ATTRACTIONS`
--

DROP TABLE IF EXISTS `VISITED_ATTRACTIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VISITED_ATTRACTIONS` (
  `ticket_id` char(10) NOT NULL,
  `attraction_id` int NOT NULL,
  PRIMARY KEY (`ticket_id`,`attraction_id`),
  KEY `attraction_id` (`attraction_id`),
  CONSTRAINT `VISITED_ATTRACTIONS_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `TICKET` (`ticket_id`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `VISITED_ATTRACTIONS_ibfk_2` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISITED_ATTRACTIONS`
--

LOCK TABLES `VISITED_ATTRACTIONS` WRITE;
/*!40000 ALTER TABLE `VISITED_ATTRACTIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `VISITED_ATTRACTIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VISITOR`
--

DROP TABLE IF EXISTS `VISITOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VISITOR` (
  `ssn` char(9) NOT NULL,
  `date_of_birth` date NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `sex` enum('Male','Female','Others') DEFAULT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISITOR`
--

LOCK TABLES `VISITOR` WRITE;
/*!40000 ALTER TABLE `VISITOR` DISABLE KEYS */;
INSERT INTO `VISITOR` VALUES ('138479','1969-06-06','Ross','Geller','Male'),('23579','1990-05-20','Ram','Nandamuri','Male'),('237089','1970-07-07','Rachel','Green','Female'),('245432','2012-10-10','Harsh','Pathuri','Others'),('258709','1969-06-06','Chandler','Bing','Male'),('2719','2001-02-06','Alphanso','ELric','Male'),('27190','2018-09-08','Raj','Koothrapally','Male'),('28572','1970-04-22','Phoebe','Buffay','Male'),('28573','1989-11-19','Amy','Fowler','Female'),('3492','2001-10-29','Edward','Elric','Male'),('34925','2017-11-11','Ted','Mosby','Male'),('45693','1989-08-15','Arjun','Allu','Male'),('45723','1988-12-13','Sheldon','Cooper','Male'),('49582','1969-09-25','Joey','Tribbiani','Male'),('495829','1988-01-11','Bernadette','Rostenkowski','Female'),('5102','2001-08-07','lol','Pathuri','Female'),('51026','2017-12-12','Robin','Schrebatsky','Female'),('51028','1984-11-22','Scarlett','Johansson','Female'),('524235','2011-10-09','Penny','Hofstadter','Female'),('6666','2002-05-10','Harsh','Pathuri','Others'),('66660','2014-04-10','Jim','Parsons','Others'),('66666','1973-06-15','Patrick','Harris','Others'),('752284','1985-03-31','Howard','Wolowitz','Male'),('79223','1971-05-26','Monica','Geller','Female'),('98764','1990-05-25','Prasanth','Boyina','Male'),('98765','1989-02-10','Ananya','Pandey','Female'),('98767','2016-03-07','Chloe','Standall','Female'),('98768','2016-03-07','Alex','Standall','Others');
/*!40000 ALTER TABLE `VISITOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VISITOR_PHONENUMBERS`
--

DROP TABLE IF EXISTS `VISITOR_PHONENUMBERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VISITOR_PHONENUMBERS` (
  `visitor_ssn` char(9) NOT NULL,
  `phone_number` char(15) NOT NULL,
  PRIMARY KEY (`visitor_ssn`,`phone_number`),
  CONSTRAINT `VISITOR_PHONENUMBERS_ibfk_1` FOREIGN KEY (`visitor_ssn`) REFERENCES `VISITOR` (`ssn`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISITOR_PHONENUMBERS`
--

LOCK TABLES `VISITOR_PHONENUMBERS` WRITE;
/*!40000 ALTER TABLE `VISITOR_PHONENUMBERS` DISABLE KEYS */;
INSERT INTO `VISITOR_PHONENUMBERS` VALUES ('138479','9849442678'),('23579','2548723501'),('237089','9490162433'),('245432','2455653637'),('258709','9884047707'),('2719','7210374812'),('2719','9494521750'),('27190','1001001001'),('27190','4204204203'),('28572','8464893453'),('28573','9720639712'),('3492','3949944494'),('34925','9199119911'),('45693','2652543208'),('45723','8897238556'),('49582','7028344729'),('495829','9032875189'),('5102','7238798011'),('51026','9898989898'),('51028','2523452309'),('51028','7329845202'),('524235','4252452345'),('524235','7345820839'),('6666','9110788770'),('66660','9949999499'),('66666','9442749492'),('752284','6699031459'),('752284','7781091343'),('79223','9419725525'),('79223','9848666872'),('98764','1354325637'),('98765','8453213543'),('98767','0987687897'),('98767','9857877549'),('98768','7843208758');
/*!40000 ALTER TABLE `VISITOR_PHONENUMBERS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-05 18:15:55

