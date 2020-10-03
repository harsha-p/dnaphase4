-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: project
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

DROP TABLE IF EXISTS `ATTRACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ATTRACTION` (
  `attraction_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `for_adult` tinyint NOT NULL DEFAULT '0',
  `for_child` tinyint NOT NULL DEFAULT '0',
  `for_old` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ATTRACTION`
--

LOCK TABLES `ATTRACTION` WRITE;
/*!40000 ALTER TABLE `ATTRACTION` DISABLE KEYS */;
INSERT INTO `ATTRACTION` VALUES (1,'one',1,1,1),(2,'two',1,0,1),(3,'three',0,1,0);
/*!40000 ALTER TABLE `ATTRACTION` ENABLE KEYS */;
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
  CONSTRAINT `PHOTO_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `TICKET` (`ticket_id`) ON UPDATE CASCADE,
  CONSTRAINT `PHOTO_ibfk_2` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`) ON UPDATE CASCADE,
  CONSTRAINT `PHOTO_ibfk_3` FOREIGN KEY (`photo_size`) REFERENCES `PHOTO_COST` (`photo_size`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHOTO`
--

LOCK TABLES `PHOTO` WRITE;
/*!40000 ALTER TABLE `PHOTO` DISABLE KEYS */;
INSERT INTO `PHOTO` VALUES ('1',1,'2020-10-03 15:00:40',1),('1',3,'2020-10-03 15:04:41',1),('1',2,'2020-10-03 15:04:37',3);
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
INSERT INTO `PHOTO_COST` VALUES (1,'200'),(2,'400'),(3,'600');
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
  `position` enum('MANAGER','OPERATOR','MAINTAINER') DEFAULT NULL,
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
INSERT INTO `STAFF` VALUES ('1','harsha','pathuri','Male','2001-10-06','2020-10-03','mon-thu 9am-9pm','MANAGER','10000','77-2-7/1','gandhipuram','533103',1);
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
  CONSTRAINT `STAFF_PHONENUMBERS_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `STAFF` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STAFF_PHONENUMBERS`
--

LOCK TABLES `STAFF_PHONENUMBERS` WRITE;
/*!40000 ALTER TABLE `STAFF_PHONENUMBERS` DISABLE KEYS */;
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
  `issued_time` datetime NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `staff_id` (`staff_id`),
  KEY `ssn` (`ssn`),
  KEY `ticket_type` (`ticket_type`),
  CONSTRAINT `TICKET_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `STAFF` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `TICKET_ibfk_2` FOREIGN KEY (`ssn`) REFERENCES `VISITOR` (`ssn`) ON UPDATE CASCADE,
  CONSTRAINT `TICKET_ibfk_3` FOREIGN KEY (`ticket_type`) REFERENCES `TICKET_COST` (`ticket_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TICKET`
--

LOCK TABLES `TICKET` WRITE;
/*!40000 ALTER TABLE `TICKET` DISABLE KEYS */;
INSERT INTO `TICKET` VALUES ('1','3492',1,'1','2019-10-03 20:26:00');
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
INSERT INTO `TICKET_COST` VALUES (1,'3000'),(2,'5000'),(3,'2500');
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
  CONSTRAINT `VISITED_ATTRACTIONS_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `TICKET` (`ticket_id`) ON UPDATE CASCADE,
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
INSERT INTO `VISITOR` VALUES ('3492','2001-10-06','harsha','pathuri','Male');
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
  CONSTRAINT `VISITOR_PHONENUMBERS_ibfk_1` FOREIGN KEY (`visitor_ssn`) REFERENCES `VISITOR` (`ssn`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISITOR_PHONENUMBERS`
--

LOCK TABLES `VISITOR_PHONENUMBERS` WRITE;
/*!40000 ALTER TABLE `VISITOR_PHONENUMBERS` DISABLE KEYS */;
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

-- Dump completed on 2020-10-03 20:38:39
