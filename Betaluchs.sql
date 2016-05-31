CREATE DATABASE  IF NOT EXISTS `BetaLuchs_Dev` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `BetaRead_Dev`;
-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: BetaRead_Dev
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BeLu_BetaFeedback`
--

DROP TABLE IF EXISTS `BeLu_BetaFeedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_BetaFeedback` (
  `betafbid` int(11) NOT NULL AUTO_INCREMENT,
  `geduld` int(11) DEFAULT NULL,
  `freundlich` int(11) DEFAULT NULL,
  `flexibel` int(11) DEFAULT NULL,
  `sorgfalt` int(11) DEFAULT NULL,
  `bewerter` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`betafbid`),
  UNIQUE KEY `betafbid_UNIQUE` (`betafbid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Betadienst`
--

DROP TABLE IF EXISTS `BeLu_Betadienst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Betadienst` (
  `dienstid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `kapazitat` int(11) DEFAULT NULL,
  PRIMARY KEY (`dienstid`),
  UNIQUE KEY `dienstid_UNIQUE` (`dienstid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_FBVerifizierung`
--

DROP TABLE IF EXISTS `BeLu_FBVerifizierung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_FBVerifizierung` (
  `vid` int(11) NOT NULL AUTO_INCREMENT,
  `betafbid` int(11) NOT NULL,
  `verifizierer` int(11) NOT NULL,
  PRIMARY KEY (`vid`),
  UNIQUE KEY `VID_UNIQUE` (`vid`),
  UNIQUE KEY `betafbid_UNIQUE` (`betafbid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_FeBa`
--

DROP TABLE IF EXISTS `BeLu_FeBa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_FeBa` (
  `FBID` int(11) NOT NULL AUTO_INCREMENT,
  `interpunktion` int(11) DEFAULT NULL,
  `schreibung` int(11) DEFAULT NULL,
  `rechtschreibung` int(11) DEFAULT NULL,
  `zeiten` int(11) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `type` enum('Self','Test') DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`FBID`),
  UNIQUE KEY `FBID_UNIQUE` (`FBID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Genre`
--

DROP TABLE IF EXISTS `BeLu_Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Genre` (
  `genreid` int(11) NOT NULL AUTO_INCREMENT,
  `genre` varchar(15) NOT NULL,
  `definition` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`genreid`),
  UNIQUE KEY `genreid_UNIQUE` (`genreid`),
  UNIQUE KEY `genre_UNIQUE` (`genre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Genre_Beta`
--

DROP TABLE IF EXISTS `BeLu_Genre_Beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Genre_Beta` (
  `genreid` int(11) NOT NULL,
  `betaid` varchar(45) NOT NULL,
  PRIMARY KEY (`genreid`,`betaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Genre_Projekt`
--

DROP TABLE IF EXISTS `BeLu_Genre_Projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Genre_Projekt` (
  `genreid` int(11) NOT NULL,
  `projektid` int(11) NOT NULL,
  PRIMARY KEY (`genreid`,`projektid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Kooperation`
--

DROP TABLE IF EXISTS `BeLu_Kooperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Kooperation` (
  `projektid` int(11) NOT NULL,
  `betaid` int(11) NOT NULL,
  `Status` enum('Aktiv','Abgeschlossen','Abgebrochen','Pausiert') NOT NULL,
  `start` date NOT NULL,
  `frist` date NOT NULL,
  `ende` date DEFAULT NULL,
  PRIMARY KEY (`projektid`,`betaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Krypto`
--

DROP TABLE IF EXISTS `BeLu_Krypto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Krypto` (
  `kryptid` int(11) NOT NULL AUTO_INCREMENT,
  `pgpkey` varchar(45) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`kryptid`),
  UNIQUE KEY `Krypt-ID_UNIQUE` (`kryptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Projekt`
--

DROP TABLE IF EXISTS `BeLu_Projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Projekt` (
  `projektid` int(11) NOT NULL AUTO_INCREMENT,
  `titel` varchar(45) NOT NULL,
  `uid` int(11) NOT NULL,
  `ziel` enum('Keine','Internet','Verlag','Selfpublish') NOT NULL,
  `rating` enum('Ab 6','Ab 12','Ab 16','Ab 18','18+') NOT NULL,
  `status` enum('In Planung','In Arbeit','Pausiert','Beendet') NOT NULL,
  PRIMARY KEY (`projektid`),
  UNIQUE KEY `projektid_UNIQUE` (`projektid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Textart`
--

DROP TABLE IF EXISTS `BeLu_Textart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Textart` (
  `textid` int(11) NOT NULL AUTO_INCREMENT,
  `textart` varchar(20) NOT NULL,
  `definition` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`textid`),
  UNIQUE KEY `textid_UNIQUE` (`textid`),
  UNIQUE KEY `textart_UNIQUE` (`textart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Textart_Beta`
--

DROP TABLE IF EXISTS `BeLu_Textart_Beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Textart_Beta` (
  `textartid` int(11) NOT NULL,
  `betaid` int(11) NOT NULL,
  PRIMARY KEY (`textartid`,`betaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Textart_Projekt`
--

DROP TABLE IF EXISTS `BeLu_Textart_Projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Textart_Projekt` (
  `textartid` int(11) NOT NULL,
  `projektid` int(11) NOT NULL,
  PRIMARY KEY (`textartid`,`projektid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Thema_Beta`
--

DROP TABLE IF EXISTS `BeLu_Thema_Beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Thema_Beta` (
  `themenid` int(11) NOT NULL,
  `projektid` int(11) NOT NULL,
  PRIMARY KEY (`themenid`,`projektid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Thema_Projekt`
--

DROP TABLE IF EXISTS `BeLu_Thema_Projekt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Thema_Projekt` (
  `themenid` int(11) NOT NULL,
  `projektid` int(11) NOT NULL,
  PRIMARY KEY (`themenid`,`projektid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_Users`
--

DROP TABLE IF EXISTS `BeLu_Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_Users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'User-ID',
  `gebdate` date DEFAULT NULL,
  `beta` binary(1) NOT NULL DEFAULT '0',
  `autor` binary(1) NOT NULL DEFAULT '0',
  `nickname` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` char(41) NOT NULL COMMENT 'User-Tabelle',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `nickname_UNIQUE` (`nickname`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_abwesend`
--

DROP TABLE IF EXISTS `BeLu_abwesend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_abwesend` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `start` date NOT NULL,
  `ende` date DEFAULT NULL,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `aid_UNIQUE` (`aid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BeLu_thema`
--

DROP TABLE IF EXISTS `BeLu_thema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeLu_thema` (
  `themenid` int(11) NOT NULL AUTO_INCREMENT,
  `thema` varchar(20) NOT NULL,
  `definition` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`themenid`),
  UNIQUE KEY `themenid_UNIQUE` (`themenid`),
  UNIQUE KEY `thema_UNIQUE` (`thema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-31 21:16:42
