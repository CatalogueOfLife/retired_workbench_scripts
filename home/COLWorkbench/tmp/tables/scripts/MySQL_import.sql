-- HINT: either load this script and run from any MySQL User Interface
-- or execute \. 'path/to/this/file/MySQL_import.sql'
-- from MySQL commandline client
-- by default it will create database icol2011ac5Dec and will import all the data there, 
-- you can change database name by modifying the string below

CREATE DATABASE icol2011ac5Dec;
USE icol2011ac5Dec;

--
-- Table structure for table `author_string`
--

DROP TABLE IF EXISTS `author_string`;


CREATE TABLE `author_string` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `string` varchar(255) NOT NULL COMMENT 'Name of author(s), who described the taxon or published the current combination and the year when appropriate.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `string` (`string`)
) ENGINE=MyISAM AUTO_INCREMENT=79193 DEFAULT CHARSET=utf8 COMMENT='Author citations of taxa and synonyms';


--
-- Table structure for table `common_name`
--

DROP TABLE IF EXISTS `common_name`;


CREATE TABLE `common_name` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `taxon_id` int(10) UNSIGNED NOT NULL,
  `common_name_element_id` int(10) UNSIGNED NOT NULL,
  `language_iso` char(3) DEFAULT NULL COMMENT 'Optional language code',
  `country_iso` char(2) DEFAULT NULL COMMENT 'Optional country code if usage is restricted to a particular country',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`taxon_id`,`common_name_element_id`,`language_iso`,`country_iso`),
  KEY `taxon_id` (`taxon_id`),
  KEY `common_name_element_id` (`common_name_element_id`),
  KEY `language_iso` (`language_iso`),
  KEY `country_iso` (`country_iso`)
) ENGINE=MyISAM AUTO_INCREMENT=105540 DEFAULT CHARSET=utf8 COMMENT='Common names plus language/country details';


--
-- Table structure for table `common_name_element`
--

DROP TABLE IF EXISTS `common_name_element`;


CREATE TABLE `common_name_element` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `transliteration` varchar(255) DEFAULT NULL COMMENT 'Transcription of name in foreign alphabet into English',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76630 DEFAULT CHARSET=utf8 COMMENT='Common names separated to avoid duplication';


--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;


CREATE TABLE `country` (
  `iso` char(2) NOT NULL COMMENT 'ISO 3166-1-Alpha-2 code',
  `name` varchar(100) NOT NULL COMMENT 'Country',
  PRIMARY KEY (`iso`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Predetermined list of ISO 3166-1-Alpha-2 codes';


--
-- Table structure for table `distribution`
--

DROP TABLE IF EXISTS `distribution`;


CREATE TABLE `distribution` (
  `taxon_detail_id` int(10) UNSIGNED NOT NULL,
  `region_id` smallint(5) UNSIGNED NOT NULL,
  `distribution_status_id` tinyint(3) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`taxon_detail_id`,`region_id`),
  KEY `region_id` (`region_id`),
  KEY `distribution_status_id` (`distribution_status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links combination(s) of region and distribution status to ta';


--
-- Table structure for table `distribution_free_text`
--

DROP TABLE IF EXISTS `distribution_free_text`;


CREATE TABLE `distribution_free_text` (
  `taxon_detail_id` int(10) UNSIGNED NOT NULL,
  `region_free_text_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `unique` (`taxon_detail_id`,`region_free_text_id`),
  KEY `taxon_detail_id` (`taxon_detail_id`),
  KEY `region_free_text_id` (`region_free_text_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links text description of distribution to taxon';


--
-- Table structure for table `distribution_status`
--

DROP TABLE IF EXISTS `distribution_status`;


CREATE TABLE `distribution_status` (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL COMMENT 'Distribution status (common, rare, etc.)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Predetermined list of distribution statuses';


--
-- Table structure for table `habitat`
--

DROP TABLE IF EXISTS `habitat`;


CREATE TABLE `habitat` (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `habitat_standard_id` tinyint(3) UNSIGNED NOT NULL,
  `original_code` varchar(25) NOT NULL COMMENT 'Original ID or code of the habitat type in the standard referenced in habitat_standard_id',
  `name` varchar(255) NOT NULL COMMENT 'Habitat type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`habitat_standard_id`,`original_code`,`name`),
  KEY `habitat_standard_id` (`habitat_standard_id`),
  KEY `original_code` (`original_code`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='Predetermined list of habitat types';


--
-- Table structure for table `habitat_standard`
--

DROP TABLE IF EXISTS `habitat_standard`;


CREATE TABLE `habitat_standard` (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `standard` varchar(50) NOT NULL COMMENT 'Standard used to describe the habitat types',
  `version` varchar(10) DEFAULT NULL COMMENT 'Version of the standard used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard` (`standard`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='TDWG standard(s) used in habitat table';


--
-- Table structure for table `habitat_to_taxon_detail`
--

DROP TABLE IF EXISTS `habitat_to_taxon_detail`;


CREATE TABLE `habitat_to_taxon_detail` (
  `habitat_id` smallint(5) UNSIGNED NOT NULL,
  `taxon_detail_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`habitat_id`,`taxon_detail_id`),
  KEY `taxon_detail_id` (`taxon_detail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links habitat type(s) to taxon';


--
-- Table structure for table `hybrid`
--

DROP TABLE IF EXISTS `hybrid`;


CREATE TABLE `hybrid` (
  `taxon_id` int(10) UNSIGNED NOT NULL,
  `parent_taxon_id` int(10) UNSIGNED NOT NULL COMMENT 'References two (or three) parent taxon ids',
  PRIMARY KEY (`taxon_id`,`parent_taxon_id`),
  KEY `parent_taxon_id` (`parent_taxon_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links to parent taxa of hybrids';


--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;


CREATE TABLE `language` (
  `iso` char(3) NOT NULL COMMENT 'ISO 639-2 Alpha-3 code',
  `name` varchar(100) NOT NULL COMMENT 'Language',
  PRIMARY KEY (`iso`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Predetermined list of ISO 639-2 Alpha-3 codes';


--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;


CREATE TABLE `reference` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `authors` varchar(255) DEFAULT NULL COMMENT 'Complete author string',
  `year` varchar(25) DEFAULT NULL COMMENT 'Year(s) of publication',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of the publication',
  `text` text COMMENT 'Additional information pertaining to the publication',
  `uri_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Link to downloadable version',
  PRIMARY KEY (`id`),
  KEY `authors` (`authors`),
  KEY `year` (`year`),
  KEY `uri_id` (`uri_id`)
) ENGINE=MyISAM AUTO_INCREMENT=60462 DEFAULT CHARSET=utf8 COMMENT='References used for taxa, common names and synonyms';


--
-- Table structure for table `reference_to_common_name`
--

DROP TABLE IF EXISTS `reference_to_common_name`;


CREATE TABLE `reference_to_common_name` (
  `reference_id` int(10) UNSIGNED NOT NULL,
  `common_name_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`reference_id`,`common_name_id`),
  KEY `common_name_id` (`common_name_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links references to common names';


--
-- Table structure for table `reference_to_synonym`
--

DROP TABLE IF EXISTS `reference_to_synonym`;


CREATE TABLE `reference_to_synonym` (
  `reference_id` int(10) UNSIGNED NOT NULL,
  `synonym_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`reference_id`,`synonym_id`),
  KEY `synonym_id` (`synonym_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links references to synonyms';


--
-- Table structure for table `reference_to_taxon`
--

DROP TABLE IF EXISTS `reference_to_taxon`;


CREATE TABLE `reference_to_taxon` (
  `reference_id` int(10) UNSIGNED NOT NULL,
  `taxon_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`reference_id`,`taxon_id`),
  KEY `taxon_id` (`taxon_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links references to taxa';


--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;


CREATE TABLE `region` (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `region_standard_id` tinyint(3) UNSIGNED NOT NULL,
  `original_code` varchar(25) NOT NULL COMMENT 'Original ID or code of the region in the standard referenced in region_standard_id',
  `name` varchar(255) NOT NULL COMMENT 'Region',
  `parent_id` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Optional parent region',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`region_standard_id`,`original_code`,`name`),
  KEY `region_standard_id` (`region_standard_id`),
  KEY `original_code` (`original_code`),
  KEY `name` (`name`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=943 DEFAULT CHARSET=utf8 COMMENT='Predetermined list of regions used for distribution';


--
-- Table structure for table `region_free_text`
--

DROP TABLE IF EXISTS `region_free_text`;


CREATE TABLE `region_free_text` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `free_text` varchar(12500) COLLATE utf8_bin NOT NULL COMMENT 'Free text description of distribution; provided mainly to store full text descriptions from the Annual Checklist',
  PRIMARY KEY (`id`),
  KEY `free_text` (`free_text`(255))
) ENGINE=MyISAM AUTO_INCREMENT=10144 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


--
-- Table structure for table `region_standard`
--

DROP TABLE IF EXISTS `region_standard`;


CREATE TABLE `region_standard` (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `standard` varchar(50) NOT NULL COMMENT 'Standard used to describe the region',
  `version` varchar(10) DEFAULT NULL COMMENT 'Version of the standard used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard` (`standard`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Standards used for region table';


--
-- Table structure for table `scientific_name_element`
--

DROP TABLE IF EXISTS `scientific_name_element`;


CREATE TABLE `scientific_name_element` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_element` varchar(100) NOT NULL COMMENT 'Basic element of a scientific name; e.g. the epithet argentatus as used in Larus argentatus argenteus',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_element` (`name_element`)
) ENGINE=MyISAM AUTO_INCREMENT=204459 DEFAULT CHARSET=utf8 COMMENT='Individual elements used to generate a scientific name';


--
-- Table structure for table `scientific_name_status`
--

DROP TABLE IF EXISTS `scientific_name_status`;


CREATE TABLE `scientific_name_status` (
  `id` tinyint(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_status` varchar(50) NOT NULL COMMENT 'Name status of a taxon',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_status` (`name_status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Predetermined list of name statuses';


--
-- Table structure for table `scrutiny`
--

DROP TABLE IF EXISTS `scrutiny`;


CREATE TABLE `scrutiny` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scrutiny_date` date DEFAULT NULL COMMENT 'Most recent date a taxon name was verified; must parse correctly',
  `original_scrutiny_date` varchar(100) DEFAULT NULL COMMENT 'Date as used in the original database; may be incomplete',
  `specialist_id` int(10) UNSIGNED NOT NULL COMMENT 'Link to the specialist who examined the validity of a taxon',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`scrutiny_date`,`specialist_id`,`original_scrutiny_date`),
  KEY `scrutiny_date` (`scrutiny_date`),
  KEY `specialist_id` (`specialist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1271 DEFAULT CHARSET=utf8 COMMENT='Latest scrutiny date of a taxon';


--
-- Table structure for table `source_database`
--

DROP TABLE IF EXISTS `source_database`;


CREATE TABLE `source_database` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Full name of the source database',
  `abbreviated_name` varchar(50) DEFAULT NULL COMMENT 'Abbreviated name of the source database',
  `group_name_in_english` varchar(255) DEFAULT NULL COMMENT 'Name in English of the group(s) treated in the database',
  `authors_and_editors` varchar(255) DEFAULT NULL COMMENT 'Optional author(s) and editor(s) of the source database',
  `organisation` varchar(255) DEFAULT NULL COMMENT 'Optional organisation which has compiled or is owning the source database',
  `contact_person` varchar(255) DEFAULT NULL COMMENT 'Optional contact person of the source database',
  `version` varchar(25) DEFAULT NULL COMMENT 'Optional version number of the source database',
  `release_date` date DEFAULT NULL COMMENT 'Optional most recent release date of the source database',
  `abstract` text COMMENT 'Optional free text field describing the source database',
  `taxonomic_coverage` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`abbreviated_name`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='Information about source databases';


--
-- Table structure for table `specialist`
--

DROP TABLE IF EXISTS `specialist`;


CREATE TABLE `specialist` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=utf8 COMMENT='Specialists who have verified the validity of taxa';


--
-- Table structure for table `synonym`
--

DROP TABLE IF EXISTS `synonym`;


CREATE TABLE `synonym` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `taxon_id` int(10) UNSIGNED NOT NULL COMMENT 'Link to valid taxon to which the synonym relates',
  `author_string_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Link to author citation of the synonym',
  `scientific_name_status_id` tinyint(2) UNSIGNED NOT NULL COMMENT 'Link to the name status of the synonym',
  `original_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taxon_id` (`taxon_id`),
  KEY `author_string_id` (`author_string_id`),
  KEY `scientific_name_status_id` (`scientific_name_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7618428 DEFAULT CHARSET=utf8 COMMENT='Synonym details linked to a valid taxon';


--
-- Table structure for table `synonym_name_element`
--

DROP TABLE IF EXISTS `synonym_name_element`;


CREATE TABLE `synonym_name_element` (
  `taxonomic_rank_id` tinyint(3) UNSIGNED NOT NULL,
  `scientific_name_element_id` int(10) UNSIGNED NOT NULL,
  `synonym_id` int(10) UNSIGNED NOT NULL,
  `hybrid_order` tinyint(1) UNSIGNED DEFAULT NULL COMMENT 'Order of parents if synonym is a hybrid; see documentation for details',
  UNIQUE KEY `unique` (`taxonomic_rank_id`,`synonym_id`),
  KEY `taxonomic_rank_id` (`taxonomic_rank_id`),
  KEY `scientific_name_element_id` (`scientific_name_element_id`),
  KEY `synonym_id` (`synonym_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Name elements of a complete synonym';


--
-- Table structure for table `taxon`
--

DROP TABLE IF EXISTS `taxon`;


CREATE TABLE `taxon` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `taxonomic_rank_id` tinyint(3) UNSIGNED NOT NULL,
  `source_database_id` int(10) UNSIGNED DEFAULT NULL,
  `original_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taxonomic_rank_id` (`taxonomic_rank_id`),
  KEY `source_database_id` (`source_database_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7618427 DEFAULT CHARSET=utf8 COMMENT='Scientific name elements and hierarchy of a taxon';


--
-- Table structure for table `taxonomic_coverage`
--

DROP TABLE IF EXISTS `taxonomic_coverage`;
CREATE TABLE `taxonomic_coverage` (
  `source_database_id` int(10) NOT NULL,
  `taxon_id` int(10) NOT NULL,
  `sector` tinyint(2) NOT NULL,
  `point_of_attachment` tinyint(1) NOT NULL DEFAULT '0',
  KEY `source_database_id` (`source_database_id`),
  KEY `sector` (`sector`),
  KEY `taxon_id` (`taxon_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `taxon_detail`
--

DROP TABLE IF EXISTS `taxon_detail`;


CREATE TABLE `taxon_detail` (
  `taxon_id` int(10) UNSIGNED NOT NULL,
  `author_string_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Link to author citation of the taxon',
  `scientific_name_status_id` tinyint(2) UNSIGNED NOT NULL,
  `scrutiny_id` int(10) UNSIGNED DEFAULT NULL,
  `additional_data` text COMMENT 'Optional free text field describing the taxon',
  PRIMARY KEY (`taxon_id`),
  KEY `author_string_id` (`author_string_id`),
  KEY `taxononomic_status_id` (`scientific_name_status_id`),
  KEY `scrutiny_id` (`scrutiny_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Details pertaining to species and infraspecies';


--
-- Table structure for table `taxon_name_element`
--

DROP TABLE IF EXISTS `taxon_name_element`;


CREATE TABLE `taxon_name_element` (
  `taxon_id` int(10) UNSIGNED NOT NULL,
  `scientific_name_element_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`taxon_id`),
  KEY `scientific_name_element_id` (`scientific_name_element_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Table structure for table `taxonomic_rank`
--

DROP TABLE IF EXISTS `taxonomic_rank`;


CREATE TABLE `taxonomic_rank` (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rank` varchar(50) NOT NULL COMMENT 'Taxonomic rank (e.g. family, subspecies)',
  `marker_displayed` varchar(50) DEFAULT NULL,
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 COMMENT='Predetermined list of taxonomic ranks';


--
-- Table structure for table `uri`
--

DROP TABLE IF EXISTS `uri`;


CREATE TABLE `uri` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `resource_identifier` varchar(500) NOT NULL COMMENT 'Unique resource identifier (URI; including LSID)',
  `description` text COMMENT 'Short description of the URI',
  `uri_scheme_id` tinyint(2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_identifier` (`resource_identifier`(255)),
  KEY `uri_scheme_id` (`uri_scheme_id`)
) ENGINE=MyISAM AUTO_INCREMENT=356419 DEFAULT CHARSET=utf8 COMMENT='Unique resource identifiers';


--
-- Table structure for table `uri_scheme`
--

DROP TABLE IF EXISTS `uri_scheme`;


CREATE TABLE `uri_scheme` (
  `id` tinyint(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scheme` varchar(25) NOT NULL COMMENT 'Abbreviation of URI scheme',
  `name` varchar(255) NOT NULL COMMENT 'Full name of URI scheme',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`scheme`,`name`),
  KEY `scheme` (`scheme`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='Predetermined list of URI schemas';


--
-- Table structure for table `uri_to_source_database`
--

DROP TABLE IF EXISTS `uri_to_source_database`;


CREATE TABLE `uri_to_source_database` (
  `uri_id` int(10) UNSIGNED NOT NULL,
  `source_database_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`uri_id`,`source_database_id`),
  KEY `source_database_id` (`source_database_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links URIs to source databases';


--
-- Table structure for table `uri_to_taxon`
--

DROP TABLE IF EXISTS `uri_to_taxon`;


CREATE TABLE `uri_to_taxon` (
  `uri_id` int(10) UNSIGNED NOT NULL,
  `taxon_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`uri_id`,`taxon_id`),
  KEY `taxon_id` (`taxon_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Links URI(s) (including LSID) to taxon';











-- Dump completed on 2010-12-16 15:47:12

-- Added quick fix for adding non-ISO countries and languages to ISO tables

ALTER TABLE `language` ADD `standard` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `country` ADD `standard` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `country` CHANGE `iso` `iso` CHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ISO 3166-1-Alpha-2 code';
ALTER TABLE `common_name` CHANGE `country_iso` `country_iso` CHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Optional country code if usage is restricted to a particular country' ;




#PART2: importing files into MySQL

LOAD DATA INFILE 'C:/tables/author_string.txt' INTO TABLE author_string FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/common_name.txt' INTO TABLE common_name FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/common_name_element.txt' INTO TABLE common_name_element FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/country.txt' INTO TABLE country FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/distribution.txt' INTO TABLE distribution FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/distribution_free_text.txt' INTO TABLE distribution_free_text FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/distribution_status.txt' INTO TABLE distribution_status FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/habitat.txt' INTO TABLE habitat FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/habitat_standard.txt' INTO TABLE habitat_standard FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/habitat_to_taxon_detail.txt' INTO TABLE habitat_to_taxon_detail FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/hybrid.txt' INTO TABLE hybrid FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/language.txt' INTO TABLE `language` FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/reference.txt' INTO TABLE reference FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/reference_to_common_name.txt' INTO TABLE reference_to_common_name FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/reference_to_synonym.txt' INTO TABLE reference_to_synonym FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/reference_to_taxon.txt' INTO TABLE reference_to_taxon FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/region.txt' INTO TABLE region FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/region_free_text.txt' INTO TABLE region_free_text FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/region_standard.txt' INTO TABLE region_standard FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/scientific_name_element.txt' INTO TABLE scientific_name_element FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/scientific_name_status.txt' INTO TABLE scientific_name_status FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/scrutiny.txt' INTO TABLE scrutiny FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/source_database.txt' INTO TABLE source_database FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/specialist.txt' INTO TABLE specialist FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/synonym.txt' INTO TABLE synonym FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/synonym_name_element.txt' INTO TABLE synonym_name_element FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/taxon.txt' INTO TABLE taxon FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/taxon_detail.txt' INTO TABLE taxon_detail FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/taxon_name_element.txt' INTO TABLE taxon_name_element FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/taxonomic_rank.txt' INTO TABLE taxonomic_rank FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/uri.txt' INTO TABLE uri FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/uri_scheme.txt' INTO TABLE uri_scheme FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/uri_to_source_database.txt' INTO TABLE uri_to_source_database FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE 'C:/tables/uri_to_taxon.txt' INTO TABLE uri_to_taxon FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n';