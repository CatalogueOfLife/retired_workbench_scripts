/* SET foreign_key_checks = 0; */



SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`families` SELECT 
NULL AS `record_id`,
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
FROM  `families`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`databases` SELECT 
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
FROM `databases`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`scientific_names` 
(`record_id`, `name_code`, `web_site`, `genus`, `subgenus`, `species`, `infraspecies_parent_name_code`, `infraspecies`, `infraspecies_marker`, `author`, `accepted_name_code`, `comment`, `scrutiny_date`, `sp2000_status_id`, `database_id`, `specialist_id`, `family_id`, `specialist_code`, `family_code`, `is_accepted_name`, `GSDTaxonGUID`, `GSDNameGUID`, `is_extinct`, `has_preholocene`, `has_modern`) SELECT 
NULL AS `record_id`, 
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
FROM `scientific_names`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`common_names` SELECT 
NULL AS `record_id`, 
`name_code`, 
`common_name`, 
`transliteration`, 
`language`, 
`country`, 
`area`, 
NULL AS `reference_id`, 
`database_id`, 
`is_infraspecies`, 
`reference_code`
FROM  `common_names`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`distribution` SELECT 
NULL AS `record_id`, 
`name_code`, 
`distribution`, 
`StandardInUse`, 
`DistributionStatus`,
`database_id`
FROM  `distribution`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`lifezone` SELECT 
NULL AS `record_id`,
`name_code`, 	
`lifezone`,
`database_id`
FROM  `lifezone`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`scientific_name_references` SELECT 
NULL AS `record_id`,
`name_code`,	
`reference_type`, 	
NULL AS `reference_id`,	
`reference_code`,
`database_id`
FROM  `scientific_name_references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`references` SELECT 
NULL AS `record_id`, 
`author`, 
`year`, 
`title`, 
`source`, 
`database_id`, 
`reference_code`
FROM  `references`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/*
SET @query = CONCAT("INSERT INTO ", 
@dbtouse, ".`sp2000_statuses` SELECT * FROM  `sp2000_statuses`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
*/


SET @query = CONCAT("
INSERT INTO ", @dbtouse, ".`specialists` SELECT 
NULL AS `record_id`,
`specialist_name`,
`specialist_code`,
`database_id`
FROM  `specialists`");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/* SET foreign_key_checks = 1; */
