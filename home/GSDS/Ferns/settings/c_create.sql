#`common_names`
#`scientific_names`
#`references`
#distribution
#families
#synonyms


#----------------------------
# Table structure for common_names
#----------------------------
CREATE TABLE `common_names` (
  `ID` integer(6) PRIMARY KEY AUTO_INCREMENT,
  `name_code` varchar(32) NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `database_id` int(3) NOT NULL
) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for scientific_names
#----------------------------
CREATE TABLE `scientific_names` (
  `record_id` int(6) PRIMARY KEY AUTO_INCREMENT,
  `name_code` varchar(32) NOT NULL,
  `genus` varchar(255) DEFAULT NULL,
  `species` varchar(255) DEFAULT NULL,
  `infraspecies_parent_name_code` varchar(32) NOT NULL,
  `infraspecies` varchar(255) DEFAULT NULL,
  `infraspecies_marker` varchar(8) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL, 
  `accepted_name_code` varchar(32) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `database_id` int(3) NOT NULL,
  `family_code` varchar(32) NOT NULL,
  `is_accepted_name` int(1),
  `name_status` int(1),
  `reference` varchar(255) DEFAULT NULL
  ) DEFAULT CHARSET=utf8;
  

#----------------------------
# Table structure for references
#----------------------------
CREATE TABLE `references` (
  `referenceID` integer(6) PRIMARY KEY AUTO_INCREMENT,
  `name_code` varchar(32) NOT NULL,
  `reference_type` varchar(16) DEFAULT NULL,
  `reference_code` varchar(32) NOT NULL,
  `year` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `database_id` int(3) NOT NULL
) DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for distribution
#----------------------------
CREATE TABLE `distribution` (
  `ID` integer(6) PRIMARY KEY AUTO_INCREMENT,
  `name_code` varchar(32) NOT NULL,
  `distribution` longtext DEFAULT NULL,
  `StandardInUse` varchar(16) DEFAULT NULL,
  `database_id` int(3) NOT NULL
) DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for families
#----------------------------
CREATE TABLE `families` (
  `record_id` integer(6) PRIMARY KEY AUTO_INCREMENT,
`hierarchy_code` varchar(255) DEFAULT NULL,
  `kingdom` varchar(32) DEFAULT NULL,
  `phylum` varchar(32) DEFAULT NULL,
  `class` varchar(32) DEFAULT NULL,
  `order` varchar(32) DEFAULT NULL,
  `family` varchar(32) DEFAULT NULL,
  `superfamily` varchar(32) DEFAULT NULL,
  `database_id` int(3) NOT NULL,
  `family_code` varchar(32) NOT NULL
) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for databases
#----------------------------
CREATE TABLE `databases` ( 
`database_name_displayed` varchar(125) COLLATE utf8_bin DEFAULT NULL,
`record_id` int(10) NOT NULL AUTO_INCREMENT,
`database_name` varchar(150) COLLATE utf8_bin DEFAULT NULL, 
`database_full_name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '', 
`web_site` longtext COLLATE utf8_bin, 
`organization` longtext COLLATE utf8_bin, 
`contact_person` varchar(255) COLLATE utf8_bin DEFAULT NULL, 
`taxa` varchar(255) COLLATE utf8_bin DEFAULT NULL, 
`taxonomic_coverage` longtext COLLATE utf8_bin, 
`abstract` longtext COLLATE utf8_bin, 
`version` varchar(255) COLLATE utf8_bin DEFAULT NULL, 
`release_date` date DEFAULT '0000-00-00', 
`SpeciesCount` int(11) DEFAULT '0', 
`SpeciesEst` int(11) DEFAULT '0', 
`authors_editors` longtext COLLATE utf8_bin, 
`accepted_species_names` int(10) DEFAULT '0', 
`accepted_infraspecies_names` int(10) DEFAULT '0', 
`species_synonyms` int(10) DEFAULT '0', 
`infraspecies_synonyms` int(10) DEFAULT '0', 
`common_names` int(10) DEFAULT '0', 
`total_names` int(10) DEFAULT '0', 
`is_new` tinyint(1) NOT NULL DEFAULT '0', 
`coverage` varchar(45) COLLATE utf8_bin DEFAULT NULL, 
`completeness` int(3) unsigned DEFAULT '0', 
`confidence` tinyint(1) unsigned DEFAULT '0', 
PRIMARY KEY (`record_id`), KEY `database_name` (`database_name`) )  DEFAULT CHARSET=utf8;

INSERT INTO `databases` 
 SELECT
 CONCAT('World Ferns', ': ', 'Checklist of Ferns and Lycophytes of the World')  AS `database_name_displayed`,
 @dbid AS `record_id`,
 'World Ferns' AS `database_name`,
 'Checklist of Ferns and Lycophytes of the World' AS `database_full_name`,
  'http://www.rz.uni-karlsruhe.de/~db111/flora/ferns/index.php' AS `web_site`,
  'Individual custodian in cooperation with the Botanical Garden of the Karlsruhe Institute of Technology, Karlsruhe, Germany' AS `organization`,
  'Hassler M.' AS `contact_person`,
  'Ferns and fern-allies' AS `taxa`,
  'Plantae - Tracheophyta - Equisetopsida, Lycopodiopsida, Marattiopsida, Polypodiopsida, Psilotopsida;' AS `taxonomic_coverage`,
  'WorldFerns and WorldPlants are synonymic checklists of the vascular plants of the world (including ferns and lycophytes). The data set has been compiled over the last 20 years by starting from the basic data of the Kew Index and the Index Filicum. These names (roughly 1 million) have been cross-checked against local floras, checklists and treatments. In the current status about 90% of the species names have been verified, and distribution data are available for about 80% of the countries (incomplete only for parts of tropical Africa and Brazil).' AS `abstract`,
  '3.18, Sep 2013' AS `version`,
  '2013-10-12 ' AS `release_date`,
  NULL AS `SpeciesCount`,
  NULL AS `SpeciesEst`,
  'Hassler M.' AS `authors_editors`,
  NULL AS `accepted_species_names`,
  NULL AS `accepted_infraspecies_names`,
  NULL AS `species_synonyms`,
  NULL AS `infraspecies_synonyms`,
  NULL AS `common_names`,
  NULL AS `total_names`,
  1 AS `is_new`,
  'Global' AS `coverage`,
  '100' AS `completeness`,
  '4' AS `confidence`;



LOAD DATA LOCAL INFILE 'common_names.txt' INTO TABLE `common_names` CHARACTER SET utf8 FIELDS TERMINATED BY '\t'   LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`name_code`, `common_name`, `database_id`);

LOAD DATA LOCAL INFILE 'scientific_names.txt' INTO TABLE `scientific_names` CHARACTER SET utf8 FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`record_id`, `name_code`, `genus`, `species`, `infraspecies_parent_name_code`, `infraspecies`, `infraspecies_marker`, `author`, `accepted_name_code`,  `comment`,`database_id`,`family_code`,`is_accepted_name`,`name_status`);

LOAD DATA LOCAL INFILE 'synonyms.txt' INTO TABLE `scientific_names` CHARACTER SET utf8 FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`name_code`, `genus`, `species`, `infraspecies`, `infraspecies_marker`, `author`, `accepted_name_code`, `database_id`,`family_code`,`is_accepted_name`, `name_status`, `reference`);

LOAD DATA LOCAL INFILE 'references.txt' INTO TABLE `references` CHARACTER SET utf8 FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`name_code`, `reference_type`, `reference_code`, `year`, `author`, `source`, `database_id`); 

LOAD DATA LOCAL INFILE 'distribution.txt' INTO TABLE `distribution` CHARACTER SET utf8 FIELDS TERMINATED BY '\t'   LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`name_code`, `distribution`, `StandardInUse`,  `database_id`); 

LOAD DATA LOCAL INFILE 'families.txt' INTO TABLE `families` CHARACTER SET utf8 FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`record_id`, `hierarchy_code`, `kingdom`, `phylum`, `class`, `order`, `family`, `superfamily`, `database_id`, `family_code`);


  