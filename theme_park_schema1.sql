-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: theme_park2
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
  CONSTRAINT `MAINTAINANCE_SCHEDULE_ibfk_2` FOREIGN KEY (`maintainer`) REFERENCES `STAFF` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-05 18:17:32
