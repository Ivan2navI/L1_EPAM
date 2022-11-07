-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: aws-rds-4-l1.ctjlvtohkhor.eu-central-1.rds.amazonaws.com    Database: myAVIAdb
-- ------------------------------------------------------
-- Server version	8.0.28

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Company` (
  `ID_comp` int NOT NULL,
  `name` char(40) DEFAULT NULL,
  PRIMARY KEY (`ID_comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Company`
--

LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` VALUES (1,'Ukraine_International_Airlines'),(2,'Bees_Airline'),(3,'SkyUp_Airlines'),(4,'air_France'),(5,'British_AW');
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pass_in_trip`
--

DROP TABLE IF EXISTS `Pass_in_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pass_in_trip` (
  `trip_no` int NOT NULL,
  `date` datetime NOT NULL,
  `ID_psg` int NOT NULL,
  `place` char(10) NOT NULL,
  PRIMARY KEY (`trip_no`,`date`,`ID_psg`),
  KEY `FK_Pass_in_trip_Passenger` (`ID_psg`),
  CONSTRAINT `FK_Pass_in_trip_Passenger` FOREIGN KEY (`ID_psg`) REFERENCES `Passenger` (`ID_psg`),
  CONSTRAINT `FK_Pass_in_trip_Trip` FOREIGN KEY (`trip_no`) REFERENCES `Trip` (`trip_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pass_in_trip`
--

LOCK TABLES `Pass_in_trip` WRITE;
/*!40000 ALTER TABLE `Pass_in_trip` DISABLE KEYS */;
INSERT INTO `Pass_in_trip` VALUES (1100,'2003-04-29 00:00:00',1,'1a'),(1123,'2003-04-05 00:00:00',3,'2a'),(1123,'2003-04-08 00:00:00',1,'4c'),(1123,'2003-04-08 00:00:00',6,'4b'),(1124,'2003-04-02 00:00:00',2,'2d'),(1145,'2003-04-05 00:00:00',3,'2c'),(1145,'2003-04-25 00:00:00',5,'1d'),(1181,'2003-04-01 00:00:00',1,'1a'),(1181,'2003-04-01 00:00:00',6,'1b'),(1181,'2003-04-01 00:00:00',8,'3c'),(1181,'2003-04-13 00:00:00',5,'1b'),(1182,'2003-04-13 00:00:00',5,'4b'),(1182,'2003-04-13 00:00:00',9,'6d'),(1187,'2003-04-14 00:00:00',8,'3a'),(1187,'2003-04-14 00:00:00',10,'3d'),(1188,'2003-04-01 00:00:00',8,'3a'),(7771,'2005-11-04 00:00:00',11,'4a'),(7771,'2005-11-07 00:00:00',11,'1b'),(7771,'2005-11-07 00:00:00',37,'1c'),(7771,'2005-11-09 00:00:00',11,'5a'),(7771,'2005-11-14 00:00:00',14,'4d'),(7771,'2005-11-16 00:00:00',14,'5d'),(7772,'2005-11-07 00:00:00',12,'1d'),(7772,'2005-11-07 00:00:00',37,'1a'),(7772,'2005-11-29 00:00:00',10,'3a'),(7772,'2005-11-29 00:00:00',13,'1b'),(7772,'2005-11-29 00:00:00',14,'1c'),(7773,'2005-11-07 00:00:00',13,'2d'),(7778,'2005-11-05 00:00:00',10,'2a'),(8881,'2005-11-08 00:00:00',37,'1d'),(8882,'2005-11-06 00:00:00',37,'1a'),(8882,'2005-11-13 00:00:00',14,'3d');
/*!40000 ALTER TABLE `Pass_in_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Passenger`
--

DROP TABLE IF EXISTS `Passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Passenger` (
  `ID_psg` int NOT NULL,
  `name` char(20) NOT NULL,
  PRIMARY KEY (`ID_psg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Passenger`
--

LOCK TABLES `Passenger` WRITE;
/*!40000 ALTER TABLE `Passenger` DISABLE KEYS */;
INSERT INTO `Passenger` VALUES (1,'Bruce Willis'),(2,'George Clooney'),(3,'Kevin Costner'),(4,'Donald Sutherland'),(5,'Jennifer Lopez'),(6,'Ray Liotta'),(7,'Samuel L. Jackson'),(8,'Nikole Kidman'),(9,'Alan Rickman'),(10,'Kurt Russell'),(11,'Harrison Ford'),(12,'Russell Crowe'),(13,'Steve Martin'),(14,'Michael Caine'),(15,'Angelina Jolie'),(16,'Mel Gibson'),(17,'Michael Douglas'),(18,'John Travolta'),(19,'Sylvester Stallone'),(20,'Tommy Lee Jones'),(21,'Catherine Zeta-Jones'),(22,'Antonio Banderas'),(23,'Kim Basinger'),(24,'Sam Neill'),(25,'Gary Oldman'),(26,'Clint Eastwood'),(27,'Brad Pitt'),(28,'Johnny Depp'),(29,'Pierce Brosnan'),(30,'Sean Connery'),(31,'Bruce Willis'),(37,'Mullah Omar');
/*!40000 ALTER TABLE `Passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trip`
--

DROP TABLE IF EXISTS `Trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trip` (
  `trip_no` int NOT NULL,
  `ID_comp` int NOT NULL,
  `plane` char(10) NOT NULL,
  `town_from` char(25) NOT NULL,
  `town_to` char(25) NOT NULL,
  `time_out` datetime NOT NULL,
  `time_in` datetime NOT NULL,
  PRIMARY KEY (`trip_no`),
  KEY `FK_Trip_Company` (`ID_comp`),
  CONSTRAINT `FK_Trip_Company` FOREIGN KEY (`ID_comp`) REFERENCES `Company` (`ID_comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trip`
--

LOCK TABLES `Trip` WRITE;
/*!40000 ALTER TABLE `Trip` DISABLE KEYS */;
INSERT INTO `Trip` VALUES (1100,4,'Boeing','Zaporizhia','Paris','1900-01-01 14:30:00','1900-01-01 17:50:00'),(1101,4,'Boeing','Paris','Zaporizhia','1900-01-01 08:12:00','1900-01-01 11:45:00'),(1123,3,'AN','Zaporizhia','Odessa','1900-01-01 16:20:00','1900-01-01 03:40:00'),(1124,3,'AN','Odessa','Zaporizhia','1900-01-01 09:00:00','1900-01-01 19:50:00'),(1145,2,'Embraer','Kyiv','Zaporizhia','1900-01-01 09:35:00','1900-01-01 11:23:00'),(1146,2,'Embraer','Zaporizhia','Kyiv','1900-01-01 17:55:00','1900-01-01 20:01:00'),(1181,1,'Airbus','Zaporizhia','Kyiv','1900-01-01 06:12:00','1900-01-01 08:01:00'),(1182,1,'Airbus','Kyiv','Zaporizhia','1900-01-01 12:35:00','1900-01-01 14:30:00'),(1187,1,'Airbus','Zaporizhia','Kyiv','1900-01-01 15:42:00','1900-01-01 17:39:00'),(1188,1,'Airbus','Kyiv','Zaporizhia','1900-01-01 22:50:00','1900-01-01 00:48:00'),(1195,1,'AN','Zaporizhia','Kyiv','1900-01-01 23:30:00','1900-01-01 01:11:00'),(1196,1,'AN','Kyiv','Zaporizhia','1900-01-01 04:00:00','1900-01-01 05:45:00'),(7771,5,'Boeing','London','Singapore','1900-01-01 01:00:00','1900-01-01 11:00:00'),(7772,5,'Boeing','Singapore','London','1900-01-01 12:00:00','1900-01-01 02:00:00'),(7773,5,'Boeing','London','Singapore','1900-01-01 03:00:00','1900-01-01 13:00:00'),(7774,5,'Boeing','Singapore','London','1900-01-01 14:00:00','1900-01-01 06:00:00'),(7775,5,'Boeing','London','Singapore','1900-01-01 09:00:00','1900-01-01 20:00:00'),(7776,5,'Boeing','Singapore','London','1900-01-01 18:00:00','1900-01-01 08:00:00'),(7777,5,'Boeing','London','Singapore','1900-01-01 18:00:00','1900-01-01 06:00:00'),(7778,5,'Boeing','Singapore','London','1900-01-01 22:00:00','1900-01-01 12:00:00'),(8881,5,'Boeing','London','Paris','1900-01-01 03:00:00','1900-01-01 04:00:00'),(8882,5,'Boeing','Paris','London','1900-01-01 22:00:00','1900-01-01 23:00:00');
/*!40000 ALTER TABLE `Trip` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-07 17:16:04
