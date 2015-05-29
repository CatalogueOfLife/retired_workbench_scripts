/* This script retrieves previous family_code from the Assembly_Global and replaces temporary family_code values generated from GSD dataset with codes from CoL thus preventing orphan species from appearing on the tree. Will be included into all GSD sector mapping operations. */

SET foreign_key_checks = 0;

/*a fix to remove synonyms and infraspecies without accepted names*/
/*it comes here because otherwise troublesome issues won't appear in the log*/
DELETE FROM `scientific_names` WHERE `family_code` IS NULL;

SET @query = CONCAT("
CREATE TEMPORARY TABLE tmp_family_codes SELECT DISTINCT f.record_id, f.hierarchy_code, f.kingdom, f.phylum, f.class, f.`order`, f.family, f.superfamily, 
f.database_id, f.family_code, f.is_accepted_name, f.family_code AS family_code_to_replace, ag.family_code AS family_code_to_keep FROM families f
LEFT JOIN ", @dbtouse, ".`families` ag ON f.`order` = ag.`order` AND f.family = ag.family AND f.database_id = ag.database_id;");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT MAX(SUBSTRING_INDEX(`family_code_to_keep`, '-', -1)+1) INTO @max_code FROM tmp_family_codes;
SELECT "@max_code: ", @max_code;
UPDATE tmp_family_codes SET `family_code_to_keep` = CONCAT(SUBSTRING_INDEX(`family_code_to_replace`, '-', 1),"-",(SUBSTRING_INDEX(`family_code_to_replace`, '-', -1)+@max_code))
 WHERE `family_code_to_keep` IS NULL;


CREATE TABLE tmp_scientific_names SELECT DISTINCT scn.record_id, scn.name_code, scn.web_site, scn.genus, scn.subgenus, scn.species, scn.infraspecies_parent_name_code, scn.infraspecies, scn.infraspecies_marker, scn.author, scn.accepted_name_code, scn.comment, scn.scrutiny_date, scn.sp2000_status_id, scn.database_id, scn.specialist_id, scn.family_id, scn.specialist_code,  tfc.family_code_to_keep AS family_code, scn.is_accepted_name, scn.GSDTaxonGUID, scn.GSDNameGUID FROM scientific_names scn
LEFT JOIN tmp_family_codes tfc ON scn.family_code = tfc.family_code_to_replace;

DROP TABLE families;

CREATE TABLE families SELECT record_id, hierarchy_code, kingdom, phylum, class, `order`, family, superfamily, database_id, family_code_to_keep AS family_code, is_accepted_name FROM tmp_family_codes;

DROP TABLE scientific_names;

RENAME TABLE tmp_scientific_names TO scientific_names;

SET foreign_key_checks = 1;