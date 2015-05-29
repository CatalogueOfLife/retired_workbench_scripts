DELETE FROM `common_names` WHERE `common_name` IS NULL OR `common_name` = "";

DELETE FROM `distribution` WHERE `distribution` IS NULL OR `distribution` = "";

#DELETE FROM `scientific_name_references` WHERE `reference_code` IN(SELECT DISTINCT `reference_code` FROM `references` WHERE (`title` IS NULL OR `title` = "") AND (`author` IS NULL OR `author` = ""));
DELETE FROM `references` WHERE (`title` IS NULL OR `title` = "") AND (`author` IS NULL OR `author` = "");


DELETE FROM `specialists` WHERE `specialist_name` IS NULL OR `specialist_name` = "";

/*checking for sp., spp.*/
DELETE FROM `scientific_names` WHERE (`species` IS NULL OR `species` LIKE "%sp.%" OR `species` LIKE "%spp.%") AND `infraspecies` IS NULL;
#DELETE FROM `scientific_names` WHERE (`genus` IS NULL OR `genus` = "" OR genus like "% %" OR `genus` LIKE '%sp.%' OR `genus` LIKE "%spp.%")  AND `infraspecies` IS NULL;
DELETE FROM `scientific_names` WHERE `genus` IS NULL OR `genus` = "" OR genus like "% %" OR `genus` LIKE '%sp.%' OR `genus` LIKE "%spp.%";


UPDATE `scientific_names` SET `family_id` = NULL;
UPDATE `scientific_names` SET `specialist_id` = NULL; 

UPDATE `scientific_names` SET `infraspecies_marker` = "forma" WHERE `infraspecies_marker` LIKE "f.%";
UPDATE `scientific_names` SET `infraspecies_marker` = "var." WHERE `infraspecies_marker` LIKE "Variety";
UPDATE `scientific_names` SET `infraspecies_marker` = "subsp." WHERE `infraspecies_marker` LIKE "Subspecies"; 
UPDATE `scientific_names` SET `sp2000_status_id` = 5 WHERE `sp2000_status_id` IS NULL AND `is_accepted_name` = 0; 

#/*these replacements must go before 'Not assigned' otherwise it will delete 'assigned' and leave 'Not'*/
#UPDATE `families` SET `family` = SUBSTRING_INDEX(`family`, ' ', 1) WHERE `family` LIKE "% %";
#UPDATE `families` SET `order` = SUBSTRING_INDEX(`order`, ' ', 1) WHERE `order` LIKE "% %";
#UPDATE `families` SET `class` = SUBSTRING_INDEX(`class`, ' ', 1) WHERE `class` LIKE "% %";
#UPDATE `families` SET `phylum` = SUBSTRING_INDEX(`phylum`, ' ', 1) WHERE `phylum` LIKE "% %";
#UPDATE `families` SET `kingdom` = SUBSTRING_INDEX(`kingdom`, ' ', 1) WHERE `kingdom` LIKE "% %";

/*these replacements will replace all Incertae sedis and other combinations of 2 or more words with "Not assigned".*/
UPDATE `families` SET `family` = "Not assigned" WHERE `family` LIKE "% %";
UPDATE `families` SET `order` = "Not assigned" WHERE `order` LIKE "% %";
UPDATE `families` SET `class` = "Not assigned" WHERE `class` LIKE "% %";
UPDATE `families` SET `phylum` = "Not assigned" WHERE `phylum` LIKE "% %";
UPDATE `families` SET `kingdom` = "Not assigned" WHERE `kingdom` LIKE "% %";


/*these replacements will replace all empty fields with "Not assigned".*/
UPDATE `families` SET `family` = "Not assigned" WHERE (`family` IS NULL OR `family` = '');
UPDATE `families` SET `order` = "Not assigned" WHERE (`order` IS NULL OR `order` = '');
UPDATE `families` SET `class` = "Not assigned" WHERE (`class` IS NULL OR `class` = '');
UPDATE `families` SET `phylum` = "Not assigned" WHERE (`phylum` IS NULL OR `phylum` = '');
UPDATE `families` SET `kingdom` = "Not assigned" WHERE (`kingdom` IS NULL OR `kingdom` = '');



UPDATE `families` SET `hierarchy_code` = CONCAT(`kingdom`,'-',`phylum`,'-',`class`,'-',`order`,'-',`family`);

UPDATE `scientific_name_references` SET `reference_type` = "NomRef" WHERE `reference_type` LIKE "subsequent type designation%";
UPDATE `scientific_name_references` SET `reference_type` = "NomRef" WHERE `reference_type` LIKE "Nom%";
UPDATE `scientific_name_references` SET `reference_type` = "TaxAccRef" WHERE `reference_type` LIKE "taxonomy source%";
UPDATE `scientific_name_references` SET `reference_type` = "TaxAccRef" WHERE `reference_type` LIKE "additional source%";
UPDATE `scientific_name_references` SET `reference_type` = "NomRef" WHERE `reference_type` LIKE "original description%";
UPDATE `scientific_name_references` SET `reference_type` = "TaxAccRef" WHERE `reference_type` LIKE "source of synonymy%";
UPDATE `scientific_name_references` SET `reference_type` = "TaxAccRef" WHERE `reference_type` LIKE "basis of record%";

/*correction of possible underscores in database names - these will be replaced by spaces*/
UPDATE `databases` SET database_name_displayed = REPLACE(database_name_displayed,'_',' ');
UPDATE `databases` SET database_name = REPLACE(database_name,'_',' ');