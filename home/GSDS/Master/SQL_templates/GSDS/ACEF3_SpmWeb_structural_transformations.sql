SET foreign_key_checks = 0;

TRUNCATE TABLE `databases`;

SET @query = CONCAT("
INSERT INTO `databases` 
 SELECT
 CONCAT(`DatabaseShortName`, ': ', `DatabaseFullName`)  AS `database_name_displayed`,
 @dbid AS `record_id`,
 `DatabaseShortName` AS `database_name`,
 `DatabaseFullName` AS `database_full_name`,
  `HomeURL` AS `web_site`,
  `Organisation` AS `organization`,
  `ContactPerson` AS `contact_person`,
  `GroupNameInEnglish` AS `taxa`,
  `TaxonomicCoverage` AS `taxonomic_coverage`,
  `Abstract` AS `abstract`,
  `DatabaseVersion` AS `version`,
  `ReleaseDate` AS `release_date`,
  `Coverage` AS `SpeciesCount`,
  `Completeness` AS `SpeciesEst`,
  `AuthorsEditors` AS `authors_editors`,
  NULL AS `accepted_species_names`,
  NULL AS `accepted_infraspecies_names`,
  NULL AS `species_synonyms`,
  NULL AS `infraspecies_synonyms`,
  NULL AS `common_names`,
  NULL AS `total_names`,
  NULL AS `is_new`,
  NULL AS `coverage`,
  NULL AS `completeness`,
  NULL AS `confidence`
  FROM ",
@dbtouse,
".`SourceDatabase`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `families`;

SET @query = CONCAT("
INSERT INTO `families`
SELECT DISTINCT
NULL AS `record_id`,
CONCAT(`Kingdom`,'-', `Phylum`,'-', `Class`,'-', `Order`,'-', `Family`) AS `hierarchy_code`,
`Kingdom` AS `kingdom`,
`Phylum` AS `phylum`,
`Class` AS `class`,
`Order` AS `order`,
`Family` AS `family`,
`Superfamily` AS `superfamily`,
@dbid AS `database_id`,
NULL AS `family_code`,
NULL AS `is_accepted_name`
FROM ",
@dbtouse,
".`AcceptedSpecies`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE `families` SET `family_code` = CONCAT(@dbabbr,record_id);


TRUNCATE TABLE `distribution`;

SET @query = CONCAT("
INSERT INTO `distribution` 
 SELECT
 NULL AS `record_id`,
 CONCAT(@dbabbr,`AcceptedTaxonID`) AS `name_code`,
 `DistributionElement` AS `distribution`,
 `StandardInUse` AS `StandardInUse`, 
 `DistributionStatus` AS `DistributionStatus`,
@dbid AS `database_id`
 FROM ",
@dbtouse, 
".`Distribution`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

TRUNCATE TABLE `specialists`;

SET @query = CONCAT("
INSERT INTO `specialists`
SELECT DISTINCT 
NULL  AS `record_id`,
`LTSSpecialist` AS `specialist_name`,
NULL AS `specialist_code`,
@dbid AS `database_id`
FROM ",
@dbtouse,
".`AcceptedSpecies` 
WHERE `LTSSpecialist` IS NOT NULL OR 
`LTSSpecialist` != ''");
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



/* inserting accepted names, will take about 10 sec */

TRUNCATE TABLE `scientific_names`;

SET @query = CONCAT("
INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
CONCAT(@dbabbr,`AcceptedTaxonID`) AS `name_code`,
`SpeciesURL` AS `web_site`,
`Genus` AS `genus`,
`SubGenusName` AS `subgenus`,
`Species` AS `species`,
NULL AS `infraspecies_parent_name_code`,
NULL  AS `infraspecies`,
NULL  AS `infraspecies_marker`,
`AuthorString` AS `author`,
NULL  AS `accepted_name_code`,
`AdditionalData` AS `comment`,
`LTSDate` AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
`specialists`.`record_id` AS `specialist_id`,
`families`.`record_id` AS `family_id`,
`specialists`.`specialist_code` AS `specialist_code`,
`families`.`family_code` AS `family_code`,
1 AS `is_accepted_name`,
`GSDTaxonGUI` AS `GSDTaxonGUI`,
`GSDNameGUI` AS `GSDNameGUI`
FROM ",
@dbtouse,
".`AcceptedSpecies` AcceptedSpecies
LEFT OUTER JOIN `families` ON 
(`AcceptedSpecies`.`Kingdom` = `families`.`kingdom` AND
`AcceptedSpecies`.`Phylum` = `families`.`phylum` AND
`AcceptedSpecies`.`Class` = `families`.`class` AND
`AcceptedSpecies`.`Order` = `families`.`order` AND
`AcceptedSpecies`.`Superfamily` = `families`.`superfamily` AND
`AcceptedSpecies`.`Family` = `families`.`family`)
LEFT OUTER JOIN `specialists` ON
`AcceptedSpecies`.`LTSSpecialist` = `specialists`.`specialist_name`
LEFT OUTER JOIN `sp2000_statuses` ON
`AcceptedSpecies`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`
WHERE `AcceptedSpecies`.`IsFossil` = 0");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/* Inserting synonyms in just ~5 sec*/ 
SET @query = CONCAT("
INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
CONCAT(@dbabbr,`Synonyms`.`ID`) AS `name_code`,
NULL AS `web_site`,
`Synonyms`.`Genus` AS `genus`,
`Synonyms`.`SubGenusName` AS `subgenus`,
`Synonyms`.`Species` AS `species`,
NULL AS `infraspecies_parent_name_code`,
`Synonyms`.`InfraSpecies` AS `infraspecies`,
`Synonyms`.`InfraSpecificMarker` AS `infraspecies_marker`,
`Synonyms`.`AuthorString` AS `author`,
CONCAT(@dbabbr,`Synonyms`.`AcceptedTaxonID`) AS `accepted_name_code`,
NULL AS `comment`,
NULL AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
NULL AS `specialist_id`,
NULL AS `family_id`,
NULL AS `specialist_code`,
NULL AS `family_code`,
0 AS `is_accepted_name`,
NULL AS `GSDTaxonGUI`,
`Synonyms`.`GSDNameGUI` AS `GSDNameGUI` 
FROM ",
@dbtouse,
".`Synonyms` Synonyms
LEFT OUTER JOIN `sp2000_statuses` ON
`Synonyms`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET foreign_key_checks = 1;