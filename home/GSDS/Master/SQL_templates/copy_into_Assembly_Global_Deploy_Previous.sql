source /home/GSDS/Master/SQL_templates/create_assembly_schema_myisam_after_opt.sql

SET @dbtouse = 'Assembly_Global_Deploy';

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`taxa` SELECT
`record_id`,
 `lsid`,
 `name`,
 `name_with_italics`,
 `taxon`,
 `name_code`,
 `parent_id`,
 `sp2000_status_id`,
 `database_id`,
 `is_accepted_name`,
 `is_species_or_nonsynonymic_higher_taxon`,
 `HierarchyCode`,
 `is_extinct`,
 `has_preholocene`,
 `has_modern`
FROM  ", @dbtouse, ".`taxa`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

/*
SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`hard_coded_species_totals` SELECT
 `taxon`,
 `species_count`
FROM  ", @dbtouse, ".`hard_coded_species_totals`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
*/

/*
SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`hard_coded_taxon_lists` SELECT
 `rank`,
 `accepted_names_only`,
 `name`
FROM  ", @dbtouse, ".`hard_coded_taxon_lists`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
*/

/*
SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`simple_search` SELECT
 `record_id`,
 `taxa_id`,
 `words`
FROM  ", @dbtouse, ".`simple_search`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
*/

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`families` SELECT
`record_id`,
`hierarchy_code`,
`kingdom`,
`phylum`,
`class`,
`order`,
`family`,
`superfamily`,
`database_id`,
`family_code`,
`is_accepted_name`
FROM  ", @dbtouse, ".`families`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`databases` SELECT
`database_name_displayed`,
`record_id`,
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
FROM ", @dbtouse, ".`databases`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`scientific_names` SELECT
`record_id`,
`name_code`,
`web_site`,
`genus`,
`subgenus`,
`species`,
`infraspecies_parent_name_code`,
`infraspecies`,
`infraspecies_marker`,
`author`,
`accepted_name_code`,
`comment`,
`scrutiny_date`,
`sp2000_status_id`,
`database_id`,
`specialist_id`,
`family_id`,
`specialist_code`,
`family_code`,
`is_accepted_name`,
`GSDTaxonGUID`,
`GSDNameGUID`,
 `is_extinct`,
 `has_preholocene`,
 `has_modern`
FROM ", @dbtouse, ".`scientific_names`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`common_names` SELECT
`record_id`,
`name_code`,
`common_name`,
`transliteration`,
`language`,
`country`,
`area`,
`reference_id`,
`database_id`,
`is_infraspecies`,
`reference_code`
FROM  ", @dbtouse, ".`common_names`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`distribution` SELECT
`record_id`,
`name_code`,
`distribution`,
`StandardInUse`,
`DistributionStatus`,
`database_id`
FROM  ", @dbtouse, ".`distribution`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`lifezone` SELECT
`record_id`,
`name_code`,
`lifezone`,
`database_id`
FROM  ", @dbtouse, ".`lifezone`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`scientific_name_references` SELECT
`record_id`,
`name_code`,
`reference_type`,
`reference_id`,
`reference_code`,
`database_id`
FROM  ", @dbtouse, ".`scientific_name_references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`references` SELECT
`record_id`,
`author`,
`year`,
`title`,
`source`,
`database_id`,
`reference_code`
FROM  ", @dbtouse, ".`references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy_Previous`.`specialists` SELECT
`record_id`,
`specialist_name`,
`specialist_code`,
`database_id`
FROM  ", @dbtouse, ".`specialists`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



