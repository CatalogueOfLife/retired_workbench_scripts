SET @dbid = 140;
SET @dbabbr = 'fer-';
SET @dbtouse = 'Buffer_Ferns';

SET foreign_key_checks = 0;

TRUNCATE TABLE `databases`;

SET @query = CONCAT("
INSERT INTO `databases` 
 SELECT
`database_name_displayed`,
@dbid,
`database_name`,
`database_full_name`,
`web_site`,
`organization`,
`contact_person`,
`taxa`,
`taxonomic_coverage`,
`abstract`,
`version`,
`release_date`,
`SpeciesCount`,
`SpeciesEst`,
 `authors_editors`,
`accepted_species_names`,
`accepted_infraspecies_names`,
`species_synonyms`,
`infraspecies_synonyms`,
`common_names`,
`total_names`,
`is_new`,
`coverage`,
`completeness`,
`confidence`
  FROM ",
@dbtouse,
".`databases`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `families`;

SET @query = CONCAT("
INSERT INTO `families`
SELECT DISTINCT
`record_id` AS `record_id`,
`hierarchy_code` AS `hierarchy_code`,
`kingdom` AS `kingdom`,
`phylum` AS `phylum`,
`class` AS `class`,
`order` AS `order`,
`family` AS `family`,
`superfamily` AS `superfamily`,
@dbid AS `database_id`,
`family_code` AS `family_code`,
NULL AS `is_accepted_name`
FROM ",
@dbtouse,
".`families`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#UPDATE `families` SET `family_code` = CONCAT(@dbabbr,record_id);


TRUNCATE TABLE `distribution`;

SET @query = CONCAT("
INSERT INTO `distribution` 
 SELECT
 NULL AS `record_id`,
`name_code` AS `name_code`,
 `distribution` AS `distribution`,
 `StandardInUse` AS `StandardInUse`, 
 NULL AS `DistributionStatus`,
@dbid AS `database_id`
 FROM ",
@dbtouse, 
".`distribution`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

TRUNCATE TABLE `specialists`;

SET @query = CONCAT("
INSERT INTO `specialists`
SELECT DISTINCT 
NULL  AS `record_id`,
'Hassler M.' AS `specialist_name`,
NULL AS `specialist_code`,
@dbid AS `database_id`
FROM ",
@dbtouse,
".`databases` 
");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE `specialists` SET `specialist_code` = CONCAT(@dbabbr,record_id);



TRUNCATE TABLE `sp2000_statuses`;

INSERT INTO `sp2000_statuses` 
VALUES (1,'accepted name'),
(2,'ambiguous synonym'),
(3,'misapplied name'),
(4,'provisionally accepted name'),
(5,'synonym');



/* inserting accepted names, synonyms and infraspecies */

TRUNCATE TABLE `scientific_names`;

SET @query = CONCAT("
INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
`name_code` AS `name_code`,
NULL AS `web_site`,
`genus` AS `genus`,
NULL AS `subgenus`,
`species` AS `species`,
`infraspecies_parent_name_code` AS `infraspecies_parent_name_code`,
`infraspecies`  AS `infraspecies`,
`infraspecies_marker`  AS `infraspecies_marker`,
`author` AS `author`,
`accepted_name_code`  AS `accepted_name_code`,
`comment` AS `comment`,
2013 AS `scrutiny_date`,
`name_status` AS `sp2000_status_id`,
@dbid AS `database_id`,
NULL AS `specialist_id`,
NULL AS `family_id`,
`specialists`.`specialist_code` AS `specialist_code`,
`family_code` AS `family_code`,
`is_accepted_name` AS `is_accepted_name`,
NULL AS `GSDTaxonGUI`,
NULL AS `GSDNameGUI`,
0 AS `is_extinct`,
0 AS `has_preholocene`,
1 AS `has_modern`
FROM ",
@dbtouse,
".`scientific_names` 
LEFT OUTER JOIN `specialists` ON
`specialists`.`specialist_name` = 'Hassler M.'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `common_names`;

SET @query = CONCAT("
INSERT INTO `common_names`(`record_id`, `name_code`, `common_name`, `reference_id`, `database_id`) 
 SELECT
`ID` AS `record_id`,
`name_code` AS `name_code`,
`common_name` AS `common_name`,
NULL AS `reference_id`,
@dbid AS `database_id`
 FROM ",
@dbtouse, 
".`common_names`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

TRUNCATE TABLE `scientific_name_references`;

SET @query = CONCAT("
INSERT INTO `scientific_name_references` 
 SELECT
`referenceID` AS `record_id`,
`name_code` AS `name_code`,
`reference_type` AS `reference_type`,
NULL AS `reference_id`,
`reference_code` AS `reference_code`,
@dbid AS `database_id`
 FROM ",
@dbtouse, 
".`references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

TRUNCATE TABLE `references`;

SET @query = CONCAT("
INSERT INTO `references` 
 SELECT
`referenceID` AS `record_id`,
`author` AS `author`,
`year` AS `year`,
NULL AS `title`,
`source` AS `source`,
@dbid AS `database_id`,
`reference_code` AS `reference_code`
 FROM ",
@dbtouse, 
".`references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET foreign_key_checks = 1;


