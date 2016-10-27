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
NULL AS `hierarchy_code`,
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

/* inserting accepted names, will take about 95 sec */

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
CONCAT(@dbabbr,`AcceptedTaxonID`) AS `accepted_name_code`,
`AdditionalData` AS `comment`,
`LTSDate` AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
`specialists`.`record_id` AS `specialist_id`,
`families`.`record_id` AS `family_id`,
`specialists`.`specialist_code` AS `specialist_code`,
`families`.`family_code` AS `family_code`,
1 AS `is_accepted_name`,
`GSDTaxonGUI` AS `GSDTaxonGUID`,
`GSDNameGUI` AS `GSDNameGUID`,
0 AS `is_extinct`,
0 AS `has_preholocene`,
1 AS `has_modern`
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
`AcceptedSpecies`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/* Inserting infraspecies */
SET @query = CONCAT("
INSERT INTO `scientific_names`
SELECT
NULL AS `record_id`,
CONCAT(@dbabbr,`AIT`.`AcceptedTaxonID`) AS `name_code`,
NULL AS `web_site`,
`sn`.`genus` AS `genus`,
NULL AS `subgenus`,
`sn`.`species` AS `species`,
CONCAT(@dbabbr,`AIT`.`ParentSpeciesID`) AS `infraspecies_parent_name_code`,
`AIT`.`InfraSpeciesEpithet` AS `infraspecies`,
`AIT`.`InfraSpecificMarker` AS `infraspecies_marker`,
`AIT`.`InfraSpecificAuthorString` AS `author`,
CONCAT(@dbabbr,`AIT`.`AcceptedTaxonID`) AS `accepted_name_code`,
`AIT`.`AdditionalData` AS `comment`,
`AIT`.`LTSDate` AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
NULL AS `specialist_id`,
NULL AS `family_id`,
`specialists`.`specialist_code` AS `specialist_code`,
sn.family_code AS `family_code`,
1 AS `is_accepted_name`,
NULL AS `GSDTaxonGUID`,
`AIT`.`GSDNameGUI` AS `GSDNameGUID`,
0 AS `is_extinct`,
0 AS `has_preholocene`,
1 AS `has_modern`
FROM ",
@dbtouse,
".`AcceptedInfraSpecificTaxa` AIT
LEFT OUTER JOIN scientific_names sn ON
CONCAT(@dbabbr,`AIT`.`ParentSpeciesID`) = `sn`.`name_code`
LEFT OUTER JOIN `sp2000_statuses` ON
`AIT`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`
LEFT OUTER JOIN `specialists` ON
`AIT`.`LTSSpecialist` = `specialists`.`specialist_name`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `lifezone`;

SET @query = CONCAT("
INSERT INTO `lifezone`
SELECT
NULL AS `record_id`,
CONCAT(@dbabbr,`AcceptedSpecies`.`AcceptedTaxonID`) AS `name_code`,
`LifeZone` AS `lifezone`,
@dbid AS `database_id`
FROM ",
@dbtouse,
".`AcceptedSpecies` AcceptedSpecies
WHERE `AcceptedSpecies`.`LifeZone` IS NOT NULL OR `AcceptedSpecies`.`LifeZone` != ''");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/* Inserting accepted infraspecies lifezones */

SET @query = CONCAT("
INSERT INTO `lifezone`
SELECT
NULL AS `record_id`,
CONCAT(@dbabbr,`AIT`.`AcceptedTaxonID`) AS `name_code`,
`LifeZone` AS `lifezone`,
@dbid AS `database_id`
FROM ",
@dbtouse,
".`AcceptedInfraSpecificTaxa` AIT
LEFT OUTER JOIN scientific_names sn ON
CONCAT(@dbabbr,`AIT`.`ParentSpeciesID`) = `sn`.`name_code`
WHERE `AIT`.`LifeZone` IS NOT NULL OR `AIT`.`LifeZone` != ''");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



/* Inserting synonyms */
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
IF(`Synonyms`.`InfraSpecies`, `Synonyms`.`InfraSpecificAuthorString`, `Synonyms`.`AuthorString`) AS author,
CONCAT(@dbabbr,`Synonyms`.`AcceptedTaxonID`) AS `accepted_name_code`,
NULL AS `comment`,
NULL AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
NULL AS `specialist_id`,
NULL AS `family_id`,
sn.`specialist_code` AS `specialist_code`,
sn.`family_code` AS `family_code`,
0 AS `is_accepted_name`,
NULL AS `GSDTaxonGUID`,
`Synonyms`.`GSDNameGUI` AS `GSDNameGUID` ,
0 AS `is_extinct`,
0 AS `has_preholocene`,
1 AS `has_modern`
FROM ",
@dbtouse,
".`Synonyms` Synonyms
LEFT OUTER JOIN scientific_names sn ON
CONCAT(@dbabbr,`Synonyms`.`AcceptedTaxonID`) = `sn`.`name_code`
LEFT OUTER JOIN `sp2000_statuses` ON
`Synonyms`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;




TRUNCATE TABLE `common_names`;
SET @query = CONCAT("
INSERT INTO `common_names`
SELECT
NULL,
CONCAT(@dbabbr, `AcceptedTaxonID`) AS `name_code`,
CONVERT(`CommonName` USING utf8) AS `common_name`,
`Transliteration` AS `transliteration`,
`Language` AS `language`,
`Country` AS `country`,
`Area` AS `area`,
 NULL AS `reference_ID`,
@dbid AS `database_ID`,
IF(`sn`.`infraspecies` IS NOT NULL OR `sn`.`infraspecies`  != '', 1, 0) AS `is_infraspecies`,
IF(`ReferenceID`, CONCAT(@dbabbr, `ReferenceID`), NULL ) AS `reference_code`
 FROM ",
@dbtouse,
".`CommonNames`
LEFT OUTER JOIN scientific_names sn ON
CONCAT(@dbabbr,`CommonNames`.`AcceptedTaxonID`) = `sn`.`name_code`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `distribution`;

SET @query = CONCAT("
INSERT INTO `distribution`
 SELECT
 NULL AS `record_id`,
 CONCAT(@dbabbr, `AcceptedTaxonID`) AS `name_code`,
 `Distribution` AS `distribution`,
 `StandardInUse` AS `StandardInUse`,
 `DistributionStatus` AS `DistributionStatus`,
@dbid AS `database_id`
 FROM ",
@dbtouse,
".`Distribution`
LEFT OUTER JOIN scientific_names sn ON
CONCAT(@dbabbr,`Distribution`.`AcceptedTaxonID`) = `sn`.`name_code`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



TRUNCATE TABLE `references`;
SET @query = CONCAT("
INSERT INTO `references`
SELECT
NULL AS `record_id`,
`Authors` AS `author`,
`Year` AS `year`,
NULL AS `title`,
`Title` AS `source`,
@dbid AS `database_id`,
CONCAT(@dbabbr, `ReferenceID`) AS `reference_code`
 FROM ",
@dbtouse,
".`References`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `scientific_name_references`;
SET @query = CONCAT("
INSERT INTO `scientific_name_references`
SELECT
NULL AS `record_id`,
CONCAT(@dbabbr, `ID`) AS `name_code`,
`ReferenceType` AS `reference_type`,
NULL AS `reference_id`,
CONCAT(@dbabbr, `ReferenceID`) AS `reference_code`,
@dbid AS `database_id`
 FROM ",
@dbtouse,
".`NameReferencesLinks`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET foreign_key_checks = 1;
