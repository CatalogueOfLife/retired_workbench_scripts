SET @dbid = 10;
SET @dbabbr = 'Fis-';
SET @dbtouse = 'Buffer_FishBase';

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql

/*
USE `Assembly_FishBase`;



TRUNCATE TABLE `databases`;

INSERT INTO `databases` 
 SELECT
 CONCAT(`DatabaseShortName`, ': ', `DatabaseFullName`)  AS `database_name_displayed`,
 10 AS `record_id`,
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
  NULL AS `is_new`
  FROM `Buffer_FishBase`.`SourceDatabase`;



TRUNCATE TABLE `distribution`;

INSERT INTO `distribution` 
 SELECT
 NULL AS `record_id`,
 CONCAT('FishBase',`AcceptedTaxonID`) AS `name_code`,
 `Distribution` AS `distribution`,
 `StandardInUse` AS `StandardInUse`, 
 `DistributionStatus` AS `DistributionStatus`,
10 AS `database_id`,



/* FROM `Buffer_FishBase`.`Distribution`;

TRUNCATE TABLE `families`;

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
10 AS `database_id`,
NULL AS `family_code`
FROM `Buffer_FishBase`.`AcceptedSpecies`;
UPDATE `families` SET `family_code` = CONCAT('FishBase',record_id);



TRUNCATE TABLE `specialists`;

INSERT INTO `specialists`
SELECT DISTINCT 
NULL  AS `record_id`,
`LTSSpecialist` AS `specialist_name`,
NULL AS `specialist_code`,
10 AS `database_id`
FROM `Buffer_FishBase`.`AcceptedSpecies` 
WHERE `LTSSpecialist` IS NOT NULL OR 
`LTSSpecialist` != "";
UPDATE `specialists` SET `specialist_code` = CONCAT('FishBase',record_id);



/* inserting accepted names, will take about 10 sec */

TRUNCATE TABLE `scientific_names`;

INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
CONCAT('FishBase',`AcceptedTaxonID`) AS `name_code`,
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
10 AS `database_id`,
`specialists`.`record_id` AS `specialist_id`,
`families`.`record_id` AS `family_id`,
CONCAT('FishBase',`specialists`.`specialist_code`) AS `specialist_code`,
CONCAT('FishBase',`families`.`family_code`) AS `family_code`,
1 AS `is_accepted_name`,
`GSDTaxonGUI` AS `GSDTaxonGUI`,
`GSDNameGUI` AS `GSDNameGUI`
FROM `Buffer_FishBase`.`AcceptedSpecies` AcceptedSpecies
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
WHERE `AcceptedSpecies`.`IsFossil` = 0;



/* Inserting synonyms in just 5 sec*/ 

INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
CONCAT('FishBase',`Synonyms`.`ID`) AS `name_code`,
NULL AS `web_site`,
`Synonyms`.`Genus` AS `genus`,
`Synonyms`.`SubGenusName` AS `subgenus`,
`Synonyms`.`Species` AS `species`,
NULL AS `infraspecies_parent_name_code`,
`Synonyms`.`InfraSpecies` AS `infraspecies`,
`Synonyms`.`InfraSpecificMarker` AS `infraspecies_marker`,
`Synonyms`.`AuthorString` AS `author`,
CONCAT('FishBase',`Synonyms`.`AcceptedTaxonID`) AS `accepted_name_code`,
NULL AS `comment`,
NULL AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
10 AS `database_id`,
NULL AS `specialist_id`,
NULL AS `family_id`,
NULL AS `specialist_code`,
NULL AS `family_code`,
0 AS `is_accepted_name`,
NULL AS `GSDTaxonGUI`,
`Synonyms`.`GSDNameGUI` AS `GSDNameGUI` 
FROM `Buffer_FishBase`.`Synonyms` Synonyms
LEFT OUTER JOIN `sp2000_statuses` ON
`Synonyms`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`;



TRUNCATE TABLE `common_names`;

INSERT INTO `common_names` 
SELECT
NULL, 
`AcceptedTaxonID`,
`CommonName`,
`Transliteration`,
`Language`,
`Country`,
`Area`,
 NULL,
 10,
 NULL,
 `ReferenceID`
 FROM `Buffer_FishBase`.`CommonNames`;
*/