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
  CONSTRAINT `MAINTAINANCE_SCHEDULE_ibfk_1` FOREIGN KEY (`attraction_id`) REFERENCES `ATTRACTION` (`attraction_id`),
  CONSTRAINT `MAINTAINANCE_SCHEDULE_ibfk_2` FOREIGN KEY (`maintainer`) REFERENCES `STAFF` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MAINTAINANCE_SCHEDULE`
--

LOCK TABLES `MAINTAINANCE_SCHEDULE` WRITE;
/*!40000 ALTER TABLE `MAINTAINANCE_SCHEDULE` DISABLE KEYS */;
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
  `issued_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

-- Dump completed on 2020-10-04 21:02:59
