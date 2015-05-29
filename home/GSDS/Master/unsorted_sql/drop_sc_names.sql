SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `scientific_names`;
CREATE TABLE  `scientific_names` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_code` varchar(42) NOT NULL,
  `web_site` longtext,
  `genus` varchar(50) DEFAULT NULL,
  `subgenus` varchar(50) DEFAULT NULL,
  `species` varchar(60) DEFAULT NULL,
  `infraspecies_parent_name_code` varchar(42) DEFAULT NULL,
  `infraspecies` varchar(50) DEFAULT NULL,
  `infraspecies_marker` varchar(50) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `accepted_name_code` varchar(42) DEFAULT NULL,
  `comment` longtext,
  `scrutiny_date` text,
  `sp2000_status_id` int(1) DEFAULT NULL,
  `database_id` int(10) DEFAULT NULL,
  `specialist_id` int(10) DEFAULT NULL,
  `family_id` int(10) DEFAULT NULL,
  `specialist_code` varchar(50) DEFAULT NULL,
  `family_code` varchar(50) DEFAULT NULL,
  `is_accepted_name` int(1) DEFAULT NULL,
  `GSDTaxonGUID` longtext,
  `GSDNameGUID` longtext,
  PRIMARY KEY (`record_id`,`name_code`),
KEY `database_id` (`database_id`),
  KEY `family_id` (`family_id`),
  KEY `species` (`species`),
  KEY `infraspecies` (`infraspecies`),
  KEY `accepted_name_code` (`accepted_name_code`),
KEY `infraspecies_parent_name_code` (`infraspecies_parent_name_code`),
  KEY `name_code1` (`name_code`,`family_id`),
  KEY `record_id` (`record_id`,`family_id`),
  KEY `genus` (`genus`,`species`,`infraspecies`),
  KEY `sp2000_status_id` (`sp2000_status_id`),
  KEY `sp2000_status_id_2` (`sp2000_status_id`,`database_id`,`infraspecies`),
CONSTRAINT scnames_link_to_GSD_db 
FOREIGN KEY (`database_id`) REFERENCES `databases` (`record_id`)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT scnames_link_to_families 
FOREIGN KEY (`family_code`) REFERENCES `families` (`family_code`)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT sp2000_statuses_to_scientific_names
FOREIGN KEY (`sp2000_status_id`) REFERENCES `sp2000_statuses` (`record_id`)
ON UPDATE CASCADE,
CONSTRAINT acc_names_to_synonyms 
FOREIGN KEY (`accepted_name_code`) REFERENCES `scientific_names` (`name_code`)
ON DELETE CASCADE,
CONSTRAINT acc_names_to_infraspecies 
FOREIGN KEY (`infraspecies_parent_name_code`) REFERENCES `scientific_names` (`name_code`)
ON DELETE CASCADE
) ENGINE=InnoDB;
SET foreign_key_checks = 1;
