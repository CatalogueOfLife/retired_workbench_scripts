source /home/GSDS/Master/SQL_templates/create_assembly_schema_myisam.sql

DROP TABLE IF EXISTS `Assembly_Global_Deploy`.`taxa`;

DROP TABLE IF EXISTS `Assembly_Global_Deploy`.`hard_coded_species_totals`;

DROP TABLE IF EXISTS `Assembly_Global_Deploy`.`hard_coded_taxon_lists`;

DROP TABLE IF EXISTS `Assembly_Global_Deploy`.`simple_search`;

source /home/GSDS/Master/SQL_templates/set_target_assembly_database.sql


SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy`.`families` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`databases` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`scientific_names`
(`record_id`, `name_code`, `web_site`, `genus`, `subgenus`, `species`, `infraspecies_parent_name_code`, `infraspecies`, `infraspecies_marker`, `author`, `accepted_name_code`, `comment`, `scrutiny_date`, `sp2000_status_id`, `database_id`, `specialist_id`, `family_id`, `specialist_code`, `family_code`, `is_accepted_name`, `GSDTaxonGUID`, `GSDNameGUID`,`is_extinct`,  `has_preholocene`,
 `has_modern`) SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`common_names` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`distribution` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`lifezone` SELECT
`record_id`,
`name_code`,
`lifezone`,
`database_id`
FROM  ", @dbtouse, ".`lifezone`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO `Assembly_Global_Deploy`.`scientific_name_references` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`references` SELECT
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
INSERT INTO `Assembly_Global_Deploy`.`specialists` SELECT
`record_id`,
`specialist_name`,
`specialist_code`,
`database_id`
FROM  ", @dbtouse, ".`specialists`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



