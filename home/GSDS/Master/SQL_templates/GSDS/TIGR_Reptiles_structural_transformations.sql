SET foreign_key_checks = 0;
/**
TRUNCATE TABLE `databases`;

SET @query = CONCAT("
INSERT INTO `databases` 
 SELECT
 CONCAT(`DatabaseShortName`, ': ', `DatabaseFullName`)  AS `database_name_displayed`,
 @dbid AS `record_id`,
 `DatabaseShortName` AS `database_name`,
 `DatabaseFullName` AS `database_full_name`,
  `HomeURL` AS `web_site`,
  `Custodian` AS `organization`,
  NULL AS `contact_person`,
  NULL AS `taxa`,
  NULL AS `taxonomic_coverage`,
  `StandardAbstract` AS `abstract`,
  `DatabaseVersion` AS `version`,
  `ReleaseDate` AS `release_date`,
  NULL AS `SpeciesCount`,
  NULL AS `SpeciesEst`,
  NULL AS `authors_editors`,
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
".`sourcedatabase`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



TRUNCATE TABLE `distribution`;

SET @query = CONCAT("
INSERT INTO `distribution` 
 SELECT
 NULL AS `record_id`,
 CONCAT(@dbabbr,nameids.newID) AS `name_code`,
 `Distribution` AS `distribution`,
 NULL AS `StandardInUse`, 
 NULL AS `DistributionStatus`,
@dbid AS `database_id`
 FROM ",
@dbtouse,
".`acceptednames` 
LEFT JOIN ",@dbtouse,".nameids nameids ON nameids.oldID = acceptednames.ID
WHERE `Distribution` IS NOT NULL
");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `families`;

SET @query = CONCAT("
INSERT INTO `families` 
SELECT DISTINCT NULL AS record_id, NULL AS hierarchy_code, tx1.TaxonName AS `kingdom`, tx2.TaxonName AS `phylum`, tx3.TaxonName AS `class`, tx4.TaxonName AS `order`, tx5.TaxonName AS `family`, NULL AS superfamily, ",@dbid," AS database_id, tx5.TaxonIdentifier AS `family_code`, NULL AS is_accepted_name FROM ",@dbtouse,".taxa tx1 
LEFT JOIN ",@dbtouse,".taxa tx2 ON tx2.TaxonIdentifier = tx1.ChildrenID
LEFT JOIN ",@dbtouse,".taxa tx3 ON tx3.TaxonIdentifier = tx2.ChildrenID
LEFT JOIN ",@dbtouse,".taxa tx4 ON tx4.TaxonIdentifier = tx3.ChildrenID
LEFT JOIN ",@dbtouse,".taxa tx5 ON tx5.TaxonIdentifier = tx4.ChildrenID
WHERE tx1.`Rank` = 'kingdom'
");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


TRUNCATE TABLE `scientific_names`;

SET @query = CONCAT("
INSERT INTO `scientific_names`
SELECT 
NULL AS `record_id`,
CONCAT(@dbabbr, `nameids`.`newID`) AS `name_code`,
NULL AS `web_site`,
`Genus` AS `genus`,
NULL AS `subgenus`,
`Species` AS `species`,
NULL AS `infraspecies_parent_name_code`,
InfraSpecies AS `infraspecies`,
InfraSpMarker AS `infraspecies_marker`,
CASE WHEN InfraSpecificAuthorString IS NULL THEN AuthorString  ELSE InfraSpecificAuthorString END AS `author`,
CASE WHEN InfraSpecies IS NULL THEN NULL ELSE CONCAT(@dbabbr, `nameids2`.`newID`) END AS `accepted_name_code`,
NULL AS `comment`,
NULL AS `scrutiny_date`,
`sp2000_statuses`.`record_id` AS `sp2000_status_id`,
@dbid AS `database_id`,
NULL AS `specialist_id`,
`families`.`record_id` AS `family_id`,
NULL AS `specialist_code`,
`families`.`family_code` AS `family_code`,
1 AS `is_accepted_name`,
NULL AS `GSDTaxonGUI`,
NULL AS `GSDNameGUI`
FROM ",
@dbtouse,
".`acceptednames` AcceptedSpecies
LEFT OUTER JOIN ",@dbtouse,".nameids  nameids ON nameids.oldID = AcceptedSpecies.ID
LEFT OUTER JOIN ",@dbtouse,".taxa  taxa ON taxa.ChildrenID = AcceptedSpecies.ID
LEFT OUTER JOIN ",@dbtouse,".nameids  nameids2 ON nameids.oldID = taxa.TaxonIdentifier
LEFT OUTER JOIN `families` ON 
 `AcceptedSpecies`.`Kingdom` = `families`.`kingdom`
LEFT OUTER JOIN `sp2000_statuses` ON
`AcceptedSpecies`.`Sp2000NameStatus` = `sp2000_statuses`.`sp2000_status`
");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

**/
SET foreign_key_checks = 1;