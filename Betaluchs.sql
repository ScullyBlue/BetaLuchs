-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.2.9-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Exportiere Datenbank Struktur für betaluchs
CREATE DATABASE IF NOT EXISTS `betaluchs` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_german1_ci */;
USE `betaluchs`;

-- Exportiere Struktur von Tabelle betaluchs.belu_betareader
CREATE TABLE IF NOT EXISTS `belu_betareader` (
  `BetaID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `Capacity` int(11) DEFAULT NULL COMMENT 'Maximal number of projects, this betareader reads for',
  PRIMARY KEY (`BetaID`),
  UNIQUE KEY `UserID` (`UserID`),
  CONSTRAINT `UserID` FOREIGN KEY (`UserID`) REFERENCES `belu_user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Table of all betareaders and their bind attributes';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_beta_genre
CREATE TABLE IF NOT EXISTS `belu_beta_genre` (
  `BetaID` int(11) NOT NULL,
  `GenreID` int(11) NOT NULL,
  `GenrePriority` int(1) DEFAULT NULL COMMENT 'Preference of betareader for genre',
  PRIMARY KEY (`BetaID`,`GenreID`),
  KEY `GenreID` (`GenreID`),
  CONSTRAINT `BetaID` FOREIGN KEY (`BetaID`) REFERENCES `belu_betareader` (`BetaID`),
  CONSTRAINT `GenreID` FOREIGN KEY (`GenreID`) REFERENCES `belu_genre` (`GenreID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='List of genres for a betareader';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_beta_job
CREATE TABLE IF NOT EXISTS `belu_beta_job` (
  `JobID` int(11) NOT NULL AUTO_INCREMENT,
  `BetaID` int(11) NOT NULL,
  `DocumentID` int(11) NOT NULL,
  `StartDate` date DEFAULT NULL COMMENT 'The day the job gets "In Progress"',
  `Jobstatus` enum('Wait','In Progress','Canceled','Ready','Finished') COLLATE latin1_german1_ci NOT NULL,
  `EndDate` date DEFAULT NULL COMMENT 'The day the betareader set the status on Ready',
  `deadline` date DEFAULT NULL COMMENT 'The day the projectowner wants the betareader to finish the job',
  PRIMARY KEY (`JobID`),
  KEY `BetaJobID` (`BetaID`),
  KEY `DocumentID` (`DocumentID`),
  CONSTRAINT `BetaJobID` FOREIGN KEY (`BetaID`) REFERENCES `belu_betareader` (`BetaID`),
  CONSTRAINT `DocumentID` FOREIGN KEY (`DocumentID`) REFERENCES `belu_document` (`DocumentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Table of betajobs on ducumentlevel with their status.';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_beta_project
CREATE TABLE IF NOT EXISTS `belu_beta_project` (
  `ProjectID` int(11) NOT NULL,
  `BetaID` int(11) NOT NULL,
  `KooperationID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`KooperationID`),
  UNIQUE KEY `ProjectID` (`ProjectID`,`BetaID`),
  KEY `Beta_ID` (`BetaID`),
  CONSTRAINT `Beta_ID` FOREIGN KEY (`BetaID`) REFERENCES `belu_betareader` (`BetaID`),
  CONSTRAINT `Projekt_ID` FOREIGN KEY (`ProjectID`) REFERENCES `belu_project` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Link betareader with projects';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_beta_textsort
CREATE TABLE IF NOT EXISTS `belu_beta_textsort` (
  `BetaID` int(11) NOT NULL,
  `TestsortID` int(11) NOT NULL,
  `SortPriority` int(1) DEFAULT NULL,
  PRIMARY KEY (`BetaID`,`TestsortID`),
  KEY `TestsortID` (`TestsortID`),
  CONSTRAINT `BetareaderID` FOREIGN KEY (`BetaID`) REFERENCES `belu_betareader` (`BetaID`),
  CONSTRAINT `TestsortID` FOREIGN KEY (`TestsortID`) REFERENCES `belu_textsort` (`TextsortID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Table of textsortpreferences of betareader';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_beta_theme
CREATE TABLE IF NOT EXISTS `belu_beta_theme` (
  `BetaID` int(11) NOT NULL,
  `ThemeID` int(11) NOT NULL,
  `Priority` int(1) DEFAULT NULL COMMENT 'Preference of betareader for theme ',
  PRIMARY KEY (`ThemeID`,`BetaID`),
  KEY `BetaThemeID` (`BetaID`),
  CONSTRAINT `BetaThemeID` FOREIGN KEY (`BetaID`) REFERENCES `belu_betareader` (`BetaID`),
  CONSTRAINT `ThemeID` FOREIGN KEY (`ThemeID`) REFERENCES `belu_theme` (`themeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Table of themepreferences of betareader';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_document
CREATE TABLE IF NOT EXISTS `belu_document` (
  `DocumentID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `DocumentType` enum('Chapter','Draft','Charakterstudy','Summary') COLLATE latin1_german1_ci NOT NULL DEFAULT 'Chapter',
  `ProjectID` int(11) NOT NULL,
  `UploadDate` date NOT NULL,
  `Path` tinytext COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`DocumentID`),
  KEY `ProjectID` (`ProjectID`),
  CONSTRAINT `ProjectID` FOREIGN KEY (`ProjectID`) REFERENCES `belu_project` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Documents of all projects. Every Document belongs to one project, which has a owner, who is implicit the owner of the documents. The document can be approved to a betareader for korrection.';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_genre
CREATE TABLE IF NOT EXISTS `belu_genre` (
  `GenreID` int(11) NOT NULL AUTO_INCREMENT,
  `TextsortID` int(11) NOT NULL,
  `Genre` varchar(50) COLLATE latin1_german1_ci NOT NULL COMMENT 'Name of Genre',
  `Definition` tinytext COLLATE latin1_german1_ci DEFAULT NULL COMMENT 'Definition of Genre',
  PRIMARY KEY (`GenreID`),
  KEY `TextsortID` (`TextsortID`),
  CONSTRAINT `TextsortID` FOREIGN KEY (`TextsortID`) REFERENCES `belu_textsort` (`TextsortID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='List of valid genres for projects';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_project
CREATE TABLE IF NOT EXISTS `belu_project` (
  `ProjectID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `TextsortID` int(11) NOT NULL,
  `GenreID` int(11) NOT NULL,
  `Description` text COLLATE latin1_german1_ci DEFAULT NULL COMMENT 'Projektdescription (eg. Shortsummary)',
  `UserID` int(11) NOT NULL COMMENT 'ID of the owner the project',
  PRIMARY KEY (`ProjectID`),
  KEY `SortID` (`TextsortID`),
  KEY `ProjektGenreID` (`GenreID`),
  KEY `ProjektUser` (`UserID`),
  CONSTRAINT `ProjektGenreID` FOREIGN KEY (`GenreID`) REFERENCES `belu_genre` (`GenreID`),
  CONSTRAINT `ProjektUser` FOREIGN KEY (`UserID`) REFERENCES `belu_user` (`UserID`),
  CONSTRAINT `SortID` FOREIGN KEY (`TextsortID`) REFERENCES `belu_textsort` (`TextsortID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Table of writingprojects from users';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_project_theme
CREATE TABLE IF NOT EXISTS `belu_project_theme` (
  `ThemeID` int(11) NOT NULL,
  `ProjektID` int(11) NOT NULL,
  PRIMARY KEY (`ThemeID`,`ProjektID`),
  KEY `_ProjektID` (`ProjektID`),
  CONSTRAINT `ProjektThemeID` FOREIGN KEY (`ThemeID`) REFERENCES `belu_theme` (`themeID`),
  CONSTRAINT `_ProjektID` FOREIGN KEY (`ProjektID`) REFERENCES `belu_project` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Link projects with one or many themes';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_textsort
CREATE TABLE IF NOT EXISTS `belu_textsort` (
  `TextsortID` int(11) NOT NULL AUTO_INCREMENT,
  `Textsort` tinytext COLLATE latin1_german1_ci NOT NULL DEFAULT '0' COMMENT 'Name of Textsort',
  `SortDefinition` text COLLATE latin1_german1_ci DEFAULT NULL COMMENT 'Definition of Textsort',
  PRIMARY KEY (`TextsortID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='List of valid sorts of texts';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_theme
CREATE TABLE IF NOT EXISTS `belu_theme` (
  `themeID` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(20) COLLATE latin1_german1_ci NOT NULL COMMENT 'Name of theme',
  `definition` text COLLATE latin1_german1_ci NOT NULL COMMENT 'Definition of theme',
  `themereference` int(11) DEFAULT NULL COMMENT 'Reference to a other theme via ID (eg. ID of ''Fantasy'' for ''Dark Fantasy'')',
  PRIMARY KEY (`themeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_user
CREATE TABLE IF NOT EXISTS `belu_user` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique User-ID',
  `BirthDate` date NOT NULL COMMENT 'Users Birthdate',
  `RegisterDate` date NOT NULL COMMENT 'Date of Registration',
  `AgeDisplay` enum('Y','N','Range') COLLATE latin1_german1_ci NOT NULL DEFAULT 'N' COMMENT 'Show Age of User in profile in Years (20 Y), Range (20-30 Y) or not',
  `Email` varchar(50) COLLATE latin1_german1_ci NOT NULL COMMENT 'Email-Adress of User',
  `EmailDisplay` enum('Y','N') COLLATE latin1_german1_ci NOT NULL DEFAULT 'N' COMMENT 'Show Email (Y) or not in profile (N)',
  `Username` varchar(25) COLLATE latin1_german1_ci NOT NULL,
  `PGP-Public` tinytext COLLATE latin1_german1_ci DEFAULT NULL COMMENT 'Public PGP-Key of User',
  `Password` char(224) COLLATE latin1_german1_ci NOT NULL COMMENT 'SHA3-Hash',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Usertable';

-- Daten Export vom Benutzer nicht ausgewählt
-- Exportiere Struktur von Tabelle betaluchs.belu_user_absence
CREATE TABLE IF NOT EXISTS `belu_user_absence` (
  `UserID` int(11) NOT NULL,
  `AbsenceID` int(11) NOT NULL AUTO_INCREMENT,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`AbsenceID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci COMMENT='Absencetime of users.';

-- Daten Export vom Benutzer nicht ausgewählt
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
