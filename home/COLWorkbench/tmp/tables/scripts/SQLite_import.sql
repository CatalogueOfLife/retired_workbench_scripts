-- HINT: this script will import the data into SQLite database
-- steps to folow:
-- using commandline invoke sqlite3 with name of the new database: sqlite3 icol2011ac5Dec.db
-- 
-- .read path/to/this/file/SQLite_import.sql from within SQLite commandline


--
-- Table structure for table `author_string`
--

DROP TABLE IF EXISTS `author_string`;
CREATE TABLE `author_string` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `string` varchar(255) NOT NULL 
);


--
-- Table structure for table `common_name`
--

DROP TABLE IF EXISTS `common_name`;
CREATE TABLE `common_name` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `taxon_id` int(10) NOT NULL,
  `common_name_element_id` int(10) NOT NULL,
  `language_iso` char(3),
  `country_iso` char(3)
);


--
-- Table structure for table `common_name_element`
--

DROP TABLE IF EXISTS `common_name_element`;
CREATE TABLE `common_name_element` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `transliteration` varchar(255)
);


--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `iso` char(3) NOT NULL PRIMARY KEY,
  `name` varchar(100) NOT NULL ,
  `standard` TINYINT( 1 ) NOT NULL DEFAULT 1
);


--
-- Table structure for table `distribution`
--

DROP TABLE IF EXISTS `distribution`;
CREATE TABLE `distribution` (
  `taxon_detail_id` int(10) NOT NULL,
  `region_id` smallint(5) NOT NULL,
  `distribution_status_id` tinyint(3)
);


--
-- Table structure for table `distribution_free_text`
--

DROP TABLE IF EXISTS `distribution_free_text`;
CREATE TABLE `distribution_free_text` (
  `taxon_detail_id` int(10) NOT NULL,
  `region_free_text_id` int(10) NOT NULL
);


--
-- Table structure for table `distribution_status`
--

DROP TABLE IF EXISTS `distribution_status`;
CREATE TABLE `distribution_status` (
  `id` tinyint(3) NOT NULL PRIMARY KEY,
  `status` varchar(100) NOT NULL
);


--
-- Table structure for table `habitat`
--

DROP TABLE IF EXISTS `habitat`;
CREATE TABLE `habitat` (
  `id` smallint(5) NOT NULL PRIMARY KEY,
  `habitat_standard_id` tinyint(3) NOT NULL,
  `original_code` varchar(25) NOT NULL ,
  `name` varchar(255) NOT NULL
);


--
-- Table structure for table `habitat_standard`
--

DROP TABLE IF EXISTS `habitat_standard`;
CREATE TABLE `habitat_standard` (
  `id` tinyint(3) NOT NULL PRIMARY KEY,
  `standard` varchar(50) NOT NULL ,
  `version` varchar(10)
);


--
-- Table structure for table `habitat_to_taxon_detail`
--

DROP TABLE IF EXISTS `habitat_to_taxon_detail`;
CREATE TABLE `habitat_to_taxon_detail` (
  `habitat_id` smallint(5) NOT NULL PRIMARY KEY,
  `taxon_detail_id` int(10) NOT NULL
);


--
-- Table structure for table `hybrid`
--

DROP TABLE IF EXISTS `hybrid`;
CREATE TABLE `hybrid` (
  `taxon_id` int(10) NOT NULL PRIMARY KEY,
  `parent_taxon_id` int(10) NOT NULL
);


--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `iso` char(3) NOT NULL PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `standard` TINYINT( 1 ) NOT NULL DEFAULT 1
);


--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
CREATE TABLE `reference` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `authors` varchar(255)  ,
  `year` varchar(25)  ,
  `title` varchar(255)  ,
  `text` text ,
  `uri_id` int(10)
);


--
-- Table structure for table `reference_to_common_name`
--

DROP TABLE IF EXISTS `reference_to_common_name`;
CREATE TABLE `reference_to_common_name` (
  `reference_id` int(10) NOT NULL,
  `common_name_id` int(10) NOT NULL
);


--
-- Table structure for table `reference_to_synonym`
--

DROP TABLE IF EXISTS `reference_to_synonym`;
CREATE TABLE `reference_to_synonym` (
  `reference_id` int(10) NOT NULL,
  `synonym_id` int(10) NOT NULL
);


--
-- Table structure for table `reference_to_taxon`
--

DROP TABLE IF EXISTS `reference_to_taxon`;
CREATE TABLE `reference_to_taxon` (
  `reference_id` int(10) NOT NULL,
  `taxon_id` int(10) NOT NULL
);


--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` smallint(5) NOT NULL PRIMARY KEY,
  `region_standard_id` tinyint(3) NOT NULL,
  `original_code` varchar(25) NOT NULL ,
  `name` varchar(255) NOT NULL ,
  `parent_id` smallint(5)
);


--
-- Table structure for table `region_free_text`
--

DROP TABLE IF EXISTS `region_free_text`;
CREATE TABLE `region_free_text` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `free_text` varchar(12500) NOT NULL
);


--
-- Table structure for table `region_standard`
--

DROP TABLE IF EXISTS `region_standard`;
CREATE TABLE `region_standard` (
  `id` tinyint(3) NOT NULL PRIMARY KEY,
  `standard` varchar(50) NOT NULL ,
  `version` varchar(10)
);


--
-- Table structure for table `scientific_name_element`
--

DROP TABLE IF EXISTS `scientific_name_element`;
CREATE TABLE `scientific_name_element` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `name_element` varchar(100) NOT NULL 
);


--
-- Table structure for table `scientific_name_status`
--

DROP TABLE IF EXISTS `scientific_name_status`;
CREATE TABLE `scientific_name_status` (
  `id` tinyint(2) NOT NULL PRIMARY KEY,
  `name_status` varchar(50) NOT NULL 
);


--
-- Table structure for table `scrutiny`
--

DROP TABLE IF EXISTS `scrutiny`;
CREATE TABLE `scrutiny` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `scrutiny_date` date  ,
  `original_scrutiny_date` varchar(100)  ,
  `specialist_id` int(10) NOT NULL
);


--
-- Table structure for table `source_database`
--

DROP TABLE IF EXISTS `source_database`;
CREATE TABLE `source_database` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `name` varchar(255) NOT NULL ,
  `abbreviated_name` varchar(50)  ,
  `group_name_in_english` varchar(255)  ,
  `authors_and_editors` varchar(255)  ,
  `organisation` varchar(255)  ,
  `contact_person` varchar(255)  ,
  `version` varchar(25)  ,
  `release_date` date  ,
  `abstract` text ,
  `taxonomic_coverage` text   
);


--
-- Table structure for table `specialist`
--

DROP TABLE IF EXISTS `specialist`;
CREATE TABLE `specialist` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `name` varchar(100) NOT NULL 
);


--
-- Table structure for table `synonym`
--

DROP TABLE IF EXISTS `synonym`;
CREATE TABLE `synonym` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `taxon_id` int(10) NOT NULL ,
  `author_string_id` int(10)  ,
  `scientific_name_status_id` tinyint(2) NOT NULL ,
  `original_id` varchar(100)
);


--
-- Table structure for table `synonym_name_element`
--

DROP TABLE IF EXISTS `synonym_name_element`;
CREATE TABLE `synonym_name_element` (
  `taxonomic_rank_id` tinyint(3) NOT NULL,
  `scientific_name_element_id` int(10) NOT NULL,
  `synonym_id` int(10) NOT NULL,
  `hybrid_order` tinyint(1)
);


--
-- Table structure for table `taxon`
--

DROP TABLE IF EXISTS `taxon`;
CREATE TABLE `taxon` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `taxonomic_rank_id` tinyint(3) NOT NULL,
  `source_database_id` int(10) ,
  `original_id` varchar(100)
);


--
-- Table structure for table `taxonomic_coverage`
--

DROP TABLE IF EXISTS `taxonomic_coverage`;
CREATE TABLE `taxonomic_coverage` (
  `source_database_id` int(10) NOT NULL,
  `taxon_id` int(10) NOT NULL,
  `sector` tinyint(2) NOT NULL,
  `point_of_attachment` tinyint(1) NOT NULL DEFAULT 0
);

--
-- Table structure for table `taxon_detail`
--

DROP TABLE IF EXISTS `taxon_detail`;
CREATE TABLE `taxon_detail` (
  `taxon_id` int(10) NOT NULL PRIMARY KEY,
  `author_string_id` int(10)  ,
  `scientific_name_status_id` tinyint(2) NOT NULL,
  `scrutiny_id` int(10) ,
  `additional_data` text
);


--
-- Table structure for table `taxon_name_element`
--

DROP TABLE IF EXISTS `taxon_name_element`;
CREATE TABLE `taxon_name_element` (
  `taxon_id` int(10) NOT NULL PRIMARY KEY,
  `scientific_name_element_id` int(10) NOT NULL,
  `parent_id` int(10)
);


--
-- Table structure for table `taxonomic_rank`
--

DROP TABLE IF EXISTS `taxonomic_rank`;
CREATE TABLE `taxonomic_rank` (
  `id` tinyint(3) NOT NULL PRIMARY KEY,
  `rank` varchar(50) NOT NULL ,
  `marker_displayed` varchar(50) ,
  `standard` tinyint(1) NOT NULL DEFAULT 0
);


--
-- Table structure for table `uri`
--

DROP TABLE IF EXISTS `uri`;
CREATE TABLE `uri` (
  `id` int(10) NOT NULL PRIMARY KEY,
  `resource_identifier` varchar(500) NOT NULL ,
  `description` text ,
  `uri_scheme_id` tinyint(2) NOT NULL
);


--
-- Table structure for table `uri_scheme`
--

DROP TABLE IF EXISTS `uri_scheme`;
CREATE TABLE `uri_scheme` (
  `id` tinyint(2) NOT NULL PRIMARY KEY,
  `scheme` varchar(25) NOT NULL ,
  `name` varchar(255) NOT NULL
);


--
-- Table structure for table `uri_to_source_database`
--

DROP TABLE IF EXISTS `uri_to_source_database`;
CREATE TABLE `uri_to_source_database` (
  `uri_id` int(10) NOT NULL,
  `source_database_id` int(10) NOT NULL
);


--
-- Table structure for table `uri_to_taxon`
--

DROP TABLE IF EXISTS `uri_to_taxon`;
CREATE TABLE `uri_to_taxon` (
  `uri_id` int(10) NOT NULL,
  `taxon_id` int(10) NOT NULL
);



-- Added quick fix for adding non-ISO countries and languages to ISO tables
-- here for SQLite these fixes are applied to create table commands directly
--ALTER TABLE `language` ADD `standard` TINYINT( 1 ) NOT NULL DEFAULT '1';
--ALTER TABLE `country` ADD `standard` TINYINT( 1 ) NOT NULL DEFAULT '1';
--ALTER TABLE `country` CHANGE `iso` `iso` CHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ISO 3166-1-Alpha-2 code';
--ALTER TABLE `common_name` CHANGE `country_iso` `country_iso` CHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT 'Optional country code if usage is restricted to a particular country';




--PART2: importing files
.separator "	"
.import 'C:/tables/author_string.txt' author_string
.import 'C:/tables/common_name.txt' common_name
.import 'C:/tables/common_name_element.txt' common_name_element
.import 'C:/tables/country.txt' country
.import 'C:/tables/distribution.txt' distribution
.import 'C:/tables/distribution_free_text.txt' distribution_free_text
.import 'C:/tables/distribution_status.txt' distribution_status
.import 'C:/tables/habitat.txt' habitat
.import 'C:/tables/habitat_standard.txt' habitat_standard
.import 'C:/tables/habitat_to_taxon_detail.txt' habitat_to_taxon_detail
.import 'C:/tables/hybrid.txt' hybrid
.import 'C:/tables/language.txt' language
.import 'C:/tables/reference.txt' reference
.import 'C:/tables/reference_to_common_name.txt' reference_to_common_name
.import 'C:/tables/reference_to_synonym.txt' reference_to_synonym
.import 'C:/tables/reference_to_taxon.txt' reference_to_taxon
.import 'C:/tables/region.txt' region
.import 'C:/tables/region_free_text.txt' region_free_text
.import 'C:/tables/region_standard.txt' region_standard
.import 'C:/tables/scientific_name_element.txt' scientific_name_element
.import 'C:/tables/scientific_name_status.txt' scientific_name_status
.import 'C:/tables/scrutiny.txt' scrutiny
.import 'C:/tables/source_database.txt' source_database
.import 'C:/tables/specialist.txt' specialist
.import 'C:/tables/synonym.txt' synonym
.import 'C:/tables/synonym_name_element.txt' synonym_name_element
.import 'C:/tables/taxon.txt' taxon
.import 'C:/tables/taxon_detail.txt' taxon_detail
.import 'C:/tables/taxon_name_element.txt' taxon_name_element
.import 'C:/tables/taxonomic_rank.txt' taxonomic_rank
.import 'C:/tables/uri.txt' uri
.import 'C:/tables/uri_scheme.txt' uri_scheme
.import 'C:/tables/uri_to_source_database.txt' uri_to_source_database
.import 'C:/tables/uri_to_taxon.txt' uri_to_taxon  