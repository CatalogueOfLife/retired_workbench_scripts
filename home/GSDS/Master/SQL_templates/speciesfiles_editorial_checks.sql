-- specific Species Files checks here

UPDATE `databases` SET `is_new` = 2, `version` = DATE_FORMAT(NOW(),'%b %Y'), `release_date` = CURRENT_DATE();

DELETE FROM `common_names` WHERE `common_name` IS NULL OR `common_name` = "";

DELETE FROM `distribution` WHERE `distribution` IS NULL OR `distribution` = "";

DELETE FROM `specialists` WHERE `specialist_name` IS NULL OR `specialist_name` = "";

UPDATE `families` SET `kingdom` = 'Animalia';

UPDATE `families` SET `phylum` = 'Arthropoda';

UPDATE `families` SET `class` = 'Insecta';

UPDATE `families` SET `hierarchy_code` = CONCAT(`kingdom`,'-',`phylum`,'-',`class`,'-',`order`,'-',`family`);

UPDATE `families` SET `is_accepted_name` = 1;

UPDATE `scientific_names` SET `infraspecies_marker` = "" WHERE `infraspecies_marker` LIKE "subsp.";





/* Non-scientific epithets */
/* Create the log */
SELECT "non-scientific epithets: ", `name_code`, `genus`, `species`, `infraspecies`, `infraspecies_marker`  FROM `scientific_names` 
WHERE (`species` LIKE "sp.") OR (`species` LIKE "%spp.%");
/* Delete the records */
DELETE FROM `scientific_names` 
WHERE (`species` LIKE "sp.") OR (`species` LIKE "%spp.%");

/* Create the log */
SELECT "non-scientific epithets: ", `name_code`, `genus`, `species`, `infraspecies`, `infraspecies_marker`  FROM `scientific_names` 
WHERE (`genus` LIKE '%gen.%') OR (`genus` LIKE  '%Genus%');

/* Delete the records */
DELETE FROM `scientific_names` 
WHERE (`genus` LIKE '%gen.%') OR (`genus` LIKE  '%Genus%');



/* Incorrect infraspecies names (author strings etc) */
/* Create the log */
SELECT "Incorrect (infra)species: ", `name_code`, `genus`, `species`, `infraspecies` FROM `scientific_names` 
WHERE  `infraspecies` != "" AND `infraspecies` IS NOT NULL -- find infraspecies first
AND (`species` NOT REGEXP '^[0-9a-z]'  -- filter incorrect characters in species name
OR `infraspecies` NOT REGEXP '^[0-9a-z]');  -- incorrect characters in infraspecies name


/* Delete the records */
DELETE FROM `scientific_names` 
WHERE `infraspecies` != "" AND `infraspecies` IS NOT NULL 
AND (`species` NOT REGEXP '^[0-9a-z]'  
OR `infraspecies` NOT REGEXP '^[0-9a-z]');



/* Infraspecies multinomial names are included, e.g. syrenicus anatolicus, 
but first check the original database. Delete the taxon. Put change in log file. */
/* Create the log */
SELECT "Infraspecies with multiple names: ", `name_code`, `genus`, `species`, `infraspecies` FROM `scientific_names` 
WHERE `infraspecies` LIKE '% %'  AND 
`infraspecies` NOT LIKE 'f.%' AND 
`infraspecies` NOT LIKE 'var.%' AND
`infraspecies` NOT LIKE 'subsp.%';

/* Delete the records */
DELETE FROM `scientific_names` 
WHERE `infraspecies` LIKE '% %'  AND 
`infraspecies` NOT LIKE 'f.%' AND 
`infraspecies` NOT LIKE 'var.%' AND
`infraspecies` NOT LIKE 'subsp.%';





/* Infraspecies marker in infraspecies field should be removed, e.g. var or f. Put change in log file. 
Put change in log file. */
/* Create the log */
SELECT "Infraspecies starting with marker: ", `name_code`, `genus`, `species`, `infraspecies` FROM `scientific_names` 
WHERE `infraspecies` LIKE '% %' AND 
(`infraspecies` LIKE 'f.%' OR 
`infraspecies` LIKE 'var.%' OR
`infraspecies` LIKE 'subsp.%');

/* Update the records */
UPDATE `scientific_names` SET `infraspecies` = SUBSTRING_INDEX(`infraspecies`, ' ', -1)
WHERE `infraspecies` LIKE '% %' AND 
(`infraspecies` LIKE 'f.%' OR 
`infraspecies` LIKE 'var.%' OR
`infraspecies` LIKE 'subsp.%');




/* Change uppercase letters to lowercase letters. Result species name in lower case. */
UPDATE `scientific_names` SET `species` = LOWER(`species`);





/* Remove species records with  empty fields. Put change in log file. */
/* Create the log */
SELECT "Empty species name: ", `name_code`, `genus`, `infraspecies` FROM `scientific_names` 
WHERE `species` = '' OR `species` IS NULL;

/* Delete the records */
DELETE FROM `scientific_names` 
WHERE `species` = '' OR `species` IS NULL;




/* Remove reference records if most fields are empty. Discuss with Luisa. Put change in log file. */
/* Create the log */
SELECT "Empty reference: ", `author`, `year`, `reference_code` FROM `references` 
WHERE (`title` = '' OR `title` IS NULL) AND
(`source` = '' OR `source` IS NULL);

/* Delete the records */
DELETE FROM `references` 
WHERE (`title` = '' OR `title` IS NULL) AND
(`source` = '' OR `source` IS NULL);



/* In common names table the field is_infraspecies is not always correctly filled. 
Infraspecies field is filled then field value should be one. Put change in log file.  */
/* Create the log */
SELECT "Set is_infraspecies flag: ", t1.`name_code`, t1.`common_name`, t2.`genus`, t2.`species`, t2.`infraspecies` 
FROM `common_names` AS t1
LEFT JOIN `scientific_names` AS t2 ON t1.`name_code` = t2.`name_code` 
WHERE (t2.`infraspecies` != '' OR t2.`infraspecies` IS NOT NULL) AND
t1.`is_infraspecies` = 0;

/* Update the records */
UPDATE `common_names` AS t1
LEFT JOIN `scientific_names` AS t2 ON t1.`name_code` = t2.`name_code` 
SET t1.`is_infraspecies` = 1
WHERE (t2.`infraspecies` != '' OR t2.`infraspecies` IS NOT NULL) AND
t1.`is_infraspecies` = 0;



/* Remove leading space in author field in tables scientific  names and reference. */
UPDATE `scientific_names` SET `author` = TRIM(`author`);
UPDATE `references`  SET `author` = TRIM(`author`);




/* Update references of which the year does not start with 1 or 2; empty the year column for those */
/* Create the log */
SELECT "Reference with incorrect data for year: ", `reference_code`, `author`, `year` FROM `references` WHERE `year` NOT REGEXP '^[1-2]';

/* Update the records */
UPDATE `references` SET `year` = '' WHERE `year` NOT REGEXP '^[1-2]';
