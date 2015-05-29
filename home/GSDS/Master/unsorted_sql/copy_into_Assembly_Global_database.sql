SET foreign_key_checks = 0;



INSERT INTO `Assembly_Global`.`families` SELECT 
NULL AS `record_id`,
`hierarchy_code`,	
`kingdom`,	
`phylum`,	
`class`,	
`order`,	
`family`,	
`superfamily`, 	
`database_id`, 	
`family_code`
FROM  `families`;



INSERT INTO `Assembly_Global`.`databases` SELECT 
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
`is_new`
FROM `databases`;



INSERT INTO `Assembly_Global`.`scientific_names` SELECT 
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
NULL AS `specialist_id`, 
NULL AS `family_id`, 
`specialist_code`, 
`family_code`, 
`is_accepted_name`, 
`GSDTaxonGUI`, 
`GSDNameGUI`
FROM `scientific_names`;



INSERT INTO `Assembly_Global`.`common_names` SELECT 
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
FROM  `common_names`;



INSERT INTO `Assembly_Global`.`distribution` SELECT 
NULL AS `record_id`, 
`name_code`, 
`distribution`, 
`StandardInUse`, 
`DistributionStatus`
FROM  `distribution`;



INSERT INTO `Assembly_Global`.`lifezone` SELECT 
NULL AS `record_id`,
`name_code`, 	
`lifezone`
FROM  `lifezone`;



INSERT INTO `Assembly_Global`.`scientific_name_references` SELECT 
NULL AS `record_id`,
`name_code`,	
`reference_type`, 	
NULL AS `reference_id`,	
`reference_code`
FROM  `scientific_name_references`;



INSERT INTO `Assembly_Global`.`references` SELECT 
NULL AS `record_id`, 
`author`, 
`year`, 
`title`, 
`source`, 
`database_id`, 
`reference_code`
FROM  `references`;



/*INSERT INTO `Assembly_Global`.`sp2000_statuses` SELECT * FROM  `sp2000_statuses`;*/



INSERT INTO `Assembly_Global`.`specialists` SELECT 
NULL AS `record_id`,
`specialist_name`,
`specialist_code`,
`database_id`
FROM  `specialists`;

/* 
INSERT INTO `Assembly_Global`.`taxa` SELECT * FROM  `taxa`;
INSERT INTO `Assembly_Global`.`hard_coded_species_totals` SELECT * FROM  `hard_coded_species_totals`;
INSERT INTO `Assembly_Global`.`hard_coded_taxon_lists` SELECT * FROM  `hard_coded_taxon_lists`;
INSERT INTO `Assembly_Global`.`simple_search` SELECT * FROM  `simple_search`;
*/

SET foreign_key_checks = 1;
