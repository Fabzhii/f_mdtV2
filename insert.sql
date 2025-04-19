
-- calls

CREATE TABLE `f_mdt_calls` (
  `reason` longtext DEFAULT NULL,  
  `time` timestamp NULL DEFAULT current_timestamp(), 
  `position` JSON DEFAULT NULL, 
  `code` longtext DEFAULT NULL, 
  `infos` longtext DEFAULT NULL, 
  `officer` longtext DEFAULT NULL, 
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- weapons

CREATE TABLE `f_mdt_weapons` (
  `owner` longtext DEFAULT NULL,  
  `type` longtext DEFAULT NULL,  
  `serial` varchar(50) DEFAULT NULL,
  `wanted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- chat

CREATE TABLE `f_mdt_chat` (
  `text` longtext DEFAULT NULL, 
  `sender` longtext DEFAULT NULL, 
  `name` longtext DEFAULT NULL, 
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- infos

CREATE TABLE `f_mdt_infos` (
  `header` longtext DEFAULT NULL, 
  `text` longtext DEFAULT NULL, 
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- buttons

CREATE TABLE `f_mdt_buttons` (
  `text` longtext DEFAULT NULL, 
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- law

CREATE TABLE `f_mdt_law` (
  `text` longtext DEFAULT NULL, 
  `paragraph` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`paragraph`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- tracking

CREATE TABLE `f_mdt_tracker` (
  `label` varchar(46) DEFAULT NULL, 
  `time` timestamp NULL DEFAULT current_timestamp(), 
  `officer` varchar(46) DEFAULT NULL,
  `type` varchar(46) DEFAULT NULL, 
  `coords` longtext DEFAULT NULL, 
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- vehicles

CREATE TABLE `f_mdt_vehicles` (
  `category` varchar(46) DEFAULT NULL, 
  `label` varchar(46) DEFAULT NULL, 
  `mingrade` varchar(46) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- outfits

CREATE TABLE `f_mdt_outfits` (
  `label` varchar(46) DEFAULT NULL, 
  `mingrade` varchar(46) DEFAULT NULL,
  `unit` varchar(46) DEFAULT NULL,
  `url` LONGTEXT DEFAULT NULL,
  `outfit` LONGTEXT NOT NULL DEFAULT '[]',
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- todos

CREATE TABLE `f_mdt_todos` (
  `label` varchar(46) DEFAULT NULL, 
  `description` longtext DEFAULT NULL,
  `officer` varchar(46) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- trainings

CREATE TABLE `f_mdt_trainings` (
  `label` varchar(46) DEFAULT NULL, 
  `description` longtext DEFAULT NULL,
  `supervisor` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `list` longtext DEFAULT NULL,
  `playerlimit` varchar(46) NOT NULL DEFAULT 10,
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- documents

CREATE TABLE `f_mdt_documents` (
  `id` varchar(46) DEFAULT NULL, 
  `time` timestamp NULL DEFAULT current_timestamp(), 
  `officer` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `identifier` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- users & weapons

ALTER TABLE `users` 
    ADD COLUMN `warrant` LONGTEXT NOT NULL DEFAULT '{"state":false,"infos":"n/A","reason":"n/A"}',
    ADD COLUMN `editinfo` LONGTEXT NOT NULL DEFAULT '{"telefon":"n/A","email":"n/A","job":"n/A"}',
    ADD COLUMN `state` LONGTEXT NOT NULL DEFAULT '{"status":"n/A","callname":"n/A","o1":"n/A","vehicle":"n/A","o3":"n/A","o2":"n/A","frequency":"n/A","position":"n/A"}',
    ADD COLUMN `images` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `callNumber` int(11) NOT NULL DEFAULT 999,
    ADD COLUMN `badgeNumber` varchar(10) NOT NULL DEFAULT 'n/A',
    ADD COLUMN `unit` varchar(46) NOT NULL DEFAULT 'patrol',
    ADD COLUMN `notes` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `files` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `info` LONGTEXT NOT NULL DEFAULT '',
    ADD COLUMN `trainings` LONGTEXT NOT NULL DEFAULT '[]';

ALTER TABLE `owned_vehicles` 
    ADD COLUMN `registered` int(11) NOT NULL DEFAULT 0,
    ADD COLUMN `wanted` int(11) NOT NULL DEFAULT 0;


