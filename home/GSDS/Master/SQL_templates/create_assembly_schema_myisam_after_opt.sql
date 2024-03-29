DROP TABLE IF EXISTS `databases`;
CREATE TABLE  `databases` (
  `database_name_displayed` varchar(125) DEFAULT NULL,
  `record_id` int(10) NOT NULL AUTO_INCREMENT,
  `database_name` varchar(150) DEFAULT NULL,
  `database_full_name` varchar(100) NOT NULL DEFAULT '',
  `web_site` longtext,
  `organization` longtext,
  `contact_person` varchar(255) DEFAULT NULL,
  `taxa` varchar(255) DEFAULT NULL,
  `taxonomic_coverage` longtext,
  `abstract` longtext,
  `version` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT '0000-00-00',
  `SpeciesCount` int(11) DEFAULT 0,
  `SpeciesEst` int(11) DEFAULT 0,
  `authors_editors` longtext,
  `accepted_species_names` int(10) DEFAULT 0,
  `accepted_infraspecies_names` int(10) DEFAULT 0,
  `species_synonyms` int(10) DEFAULT 0,
  `infraspecies_synonyms` int(10) DEFAULT 0,
  `common_names` int(10) DEFAULT 0,
  `total_names` int(10) DEFAULT 0,
  `is_new` tinyint(1) NOT NULL DEFAULT 0,
  `coverage` varchar(45) DEFAULT NULL,
  `completeness` int(3) unsigned DEFAULT 0,
  `confidence`  tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`record_id`),
  KEY `database_name` (`database_name`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;



DROP TABLE IF EXISTS `families`;
CREATE TABLE  `families` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hierarchy_code` varchar(250) NOT NULL,
  `kingdom` varchar(50) NOT NULL DEFAULT 'Not Assigned',
  `phylum` varchar(50) NOT NULL DEFAULT ' Not Assigned ',
  `class` varchar(50) NOT NULL DEFAULT ' Not Assigned ',
  `order` varchar(50) NOT NULL DEFAULT ' Not Assigned ',
  `family` varchar(50) NOT NULL DEFAULT ' Not Assigned ',
  `superfamily` varchar(50) DEFAULT NULL,
  `database_id` int(10) NOT NULL,
  `family_code` varchar(50) NOT NULL,
  `is_accepted_name` int(1) unsigned,
  PRIMARY KEY (`record_id`),
  KEY (`family_code`),
  KEY `kingdom` (`kingdom`),
  KEY `phylum` (`phylum`),
  KEY `class` (`class`),
  KEY `order` (`order`),
  KEY `family` (`family`),
  KEY `superfamily` (`superfamily`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;


DROP TABLE IF EXISTS `sp2000_statuses`;
CREATE TABLE  `sp2000_statuses` (
  `record_id` int(1) NOT NULL AUTO_INCREMENT,
  `sp2000_status` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`record_id`)
) ENGINE=MyISAM;

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
  `is_extinct` smallint(1) NOT NULL DEFAULT '0',
  `has_preholocene` smallint(1) NOT NULL DEFAULT '0',
  `has_modern` smallint(1) NOT NULL DEFAULT '1',
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
  KEY `sp2000_status_id_2` (`sp2000_status_id`,`database_id`,`infraspecies`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;

DROP TABLE IF EXISTS `common_names`;
CREATE TABLE  `common_names` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_code` varchar(42) NOT NULL DEFAULT '',
  `common_name` varchar(700) NOT NULL,
  `transliteration` varchar(700),
  `language` varchar(25) NOT NULL,
  `country` varchar(44) NOT NULL DEFAULT '',
  `area` varchar(50) DEFAULT NULL,
  `reference_id` int(10) DEFAULT '0',
  `database_id` int(10) NOT NULL,
  `is_infraspecies` int(1) NOT NULL DEFAULT '0',
  `reference_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `common_name` (`common_name`),
  KEY `name_code` (`name_code`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;




DROP TABLE IF EXISTS `distribution`;
CREATE TABLE  `distribution` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_code` varchar(42) NOT NULL,
  `distribution` longtext,
  `StandardInUse` varchar(255) DEFAULT NULL,
  /*`DistributionStatus` ENUM ('Native', 'Domesticated', 'Alien', 'Uncertain', 'Alien-Domesticated','Native-Domesticated'),*/
   `DistributionStatus` varchar(255),
  `database_id` int(10) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `name_code` (`name_code`),
  KEY `database_id` (`database_id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;

DROP TABLE IF EXISTS `lifezone`;
CREATE TABLE  `lifezone` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `name_code` varchar(42),
  `lifezone` varchar(255),
  `database_id` int(10),
  PRIMARY KEY (`record_id`),
  KEY `name_code` (`name_code`),
  KEY `database_id` (`database_id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;

DROP TABLE IF EXISTS `scientific_name_references`;
CREATE TABLE  `scientific_name_references` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_code` varchar(42) NOT NULL DEFAULT '',
  `reference_type` varchar(10) DEFAULT NULL,
  `reference_id` int(10) DEFAULT '0',
  `reference_code` varchar(50) DEFAULT NULL,
  `database_id` int(10) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `name_code` (`name_code`,`reference_id`,`reference_type`),
  KEY `name_code_2` (`name_code`,`reference_type`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;

DROP TABLE IF EXISTS `references`;
CREATE TABLE  `references` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(200) DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  `title` longtext,
  `source` longtext,
  `database_id` int(10) NOT NULL,
  `reference_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;


DROP TABLE IF EXISTS `specialists`;
CREATE TABLE  `specialists` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `specialist_name` varchar(255) NOT NULL DEFAULT '',
  `specialist_code` varchar(50) DEFAULT NULL,
  `database_id` int(10) NOT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = utf8 COLLATE = utf8_bin;


INSERT INTO `sp2000_statuses` 
VALUES (1,'accepted name'),
(2,'ambiguous synonym'),
(3,'misapplied name'),
(4,'provisionally accepted name'),
(5,'synonym');

DROP TABLE IF EXISTS `taxa`;
CREATE TABLE  `taxa` (
 `record_id` int(10) unsigned,
 `lsid` varchar(87),  
 `name` varchar(137),
 `name_with_italics` varchar(151),  
 `taxon` varchar(12),  
 `name_code` varchar(42),  
 `parent_id` int(10), 
 `sp2000_status_id` int(1),  
 `database_id` int(2), 
 `is_accepted_name` int(1), 
 `is_species_or_nonsynonymic_higher_taxon` int(1),  
 `HierarchyCode` text,
  `is_extinct` smallint(1) DEFAULT '0',
  `has_preholocene` smallint(1) DEFAULT '0',
  `has_modern` smallint(1) DEFAULT '1',
PRIMARY KEY (`record_id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET = latin1;

/*
DROP TABLE IF EXISTS `hard_coded_species_totals`;
CREATE TABLE  `hard_coded_species_totals` (
 `taxon` varchar(50), 
 `species_count` int(20)
)  ENGINE=MyISAM DEFAULT CHARACTER SET = latin1;

DROP TABLE IF EXISTS `hard_coded_taxon_lists`;
CREATE TABLE  `hard_coded_taxon_lists` (
 `rank` varchar(12),
 `accepted_names_only` int(1),  
 `name` varchar(100)
)  ENGINE=MyISAM DEFAULT CHARACTER SET = latin1;

DROP TABLE IF EXISTS `simple_search`;
CREATE TABLE  `simple_search` (
 `record_id` int(10) unsigned,
 `taxa_id` int(10), 
 `words` varchar(250),
PRIMARY KEY (`record_id`)
)  ENGINE=MyISAM DEFAULT CHARACTER SET = latin1;
*/

