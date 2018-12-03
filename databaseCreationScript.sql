
/*Create Table from Phase 2 */
USE atlzoo;

CREATE TABLE `exhibit` (
  `Size` int(11) NOT NULL,
  `Water_Feature` tinyint(1) NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
# Comment to grading TA
# For Water_Feature, value of zero is false, Non­zero values are considered true
CREATE TABLE `animal` (
  `Age` int(11) NOT NULL,
  `Type` enum('Amphibian','Bird','Fish','Invertebrate','Mammal','Reptile') NOT NULL,
  `Species` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Exhibit` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`,`Species`),
  KEY `Exhibit` (`Exhibit`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`Exhibit`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `admins` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visitors` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `staff` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `shows` (
  `Name` varchar(20) NOT NULL,
  `Date_and_time` datetime NOT NULL,
  `Located_at` varchar(20) NOT NULL,
  `Host` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`,`Date_and_time`),
  KEY `Located_at` (`Located_at`),
  KEY `Host` (`Host`),
  CONSTRAINT `shows_ibfk_1` FOREIGN KEY (`Located_at`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `shows_ibfk_2` FOREIGN KEY (`Host`) REFERENCES `staff` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `note` (
  `Time` timestamp NOT NULL,
  `Text` text,
  `Username` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Species` varchar(20) NOT NULL,
  `Staff_email` varchar(30) NOT NULL,
  PRIMARY KEY (`Time`,`Username`,`Name`,`Species`,`Staff_email`),
  KEY `Username` (`Username`),
  KEY `Name` (`Name`,`Species`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `staff` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `note_ibfk_2` FOREIGN KEY (`Name`, `Species`) REFERENCES `animal` (`name`, `species`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visit_show` (
  `Shows_name` varchar(20) NOT NULL,
  `Visitor_username` varchar(20) NOT NULL,
  `Visitor_Email` varchar(30) NOT NULL,
  `Time` timestamp NOT NULL,
  PRIMARY KEY (`Time`,`Visitor_username`,`Shows_name`),
  KEY `Shows_name` (`Shows_name`),
  KEY `Visitor_username` (`Visitor_username`),
  CONSTRAINT `visit_show_ibfk_1` FOREIGN KEY (`Shows_name`) REFERENCES `shows` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visit_show_ibfk_2` FOREIGN KEY (`Visitor_username`) REFERENCES `visitors` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visit_exhibit` (
  `Datetime` timestamp NOT NULL,
  `Exhibit_name` varchar(20) NOT NULL,
  `Visitor_username` varchar(20) NOT NULL,
  `Visitor_Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Datetime`,`Exhibit_name`,`Visitor_username`),
  KEY `Exhibit_name` (`Exhibit_name`),
  KEY `Visitor_username` (`Visitor_username`),
  CONSTRAINT `visit_exhibit_ibfk_1` FOREIGN KEY (`Exhibit_name`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `visit_exhibit_ibfk_2` FOREIGN KEY (`Visitor_username`) REFERENCES `visitors` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci





