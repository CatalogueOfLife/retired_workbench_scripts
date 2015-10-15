/*The below fixes comma/colon issues in authors_editors lists*/
UPDATE `databases` SET authors_editors = REPLACE(authors_editors, ',', '');
UPDATE `databases` SET authors_editors = REPLACE(authors_editors, ';', ',');



/*
These are mispelled scientific names. Check for genus and/or species value in infraspecies field, if so, delete whole record
Put change in log file.
*/
/* Create the log */
/* Without subgenus */
SELECT "Misspelt infraspecies (no subgenus): ", `name_code`, `genus`, `species`, `infraspecies` FROM `scientific_names`
WHERE `infraspecies` LIKE '% %' AND
`infraspecies` LIKE CONCAT(`genus`, '%') AND
(`subgenus` IS NULL OR `subgenus` = '') AND
`infraspecies` NOT LIKE CONCAT(`genus`, ' ', `species`, '%');

/* With subgenus */
SELECT "Misspelt infraspecies (with subgenus): ", `name_code`, `genus`, `subgenus`, `species`, `infraspecies` FROM `scientific_names`
WHERE `infraspecies` LIKE '% %' AND
`infraspecies` LIKE CONCAT(`genus`, '%') AND
`subgenus` != '' AND
(`infraspecies` NOT LIKE CONCAT(`genus`, ' (', `subgenus`, ') ', `species`, '%') OR `infraspecies` NOT LIKE CONCAT(`genus`, ' ', `species`, '%'));

/* Delete the records */
/* Without subgenus */
DELETE FROM `scientific_names`
WHERE `infraspecies` LIKE '% %' AND
`infraspecies` LIKE CONCAT(`genus`, '%') AND
(`subgenus` IS NULL OR `subgenus` = '') AND
`infraspecies` NOT LIKE CONCAT(`genus`, ' ', `species`, '%');

/* With subgenus */
DELETE FROM `scientific_names`
WHERE `infraspecies` LIKE '% %' AND
`infraspecies` LIKE CONCAT(`genus`, '%') AND
`subgenus` != '' AND
(`infraspecies` NOT LIKE CONCAT(`genus`, ' (', `subgenus`, ') ', `species`, '%') OR `infraspecies` NOT LIKE CONCAT(`genus`, ' ', `species`, '%'));






/* Infraspecies multinomial names are included, e.g. syrenicus anatolicus,
but first check the original database. Delete the taxon. Put change in log file. */
/* Create the log */
SELECT "Incorrect infraspecies: ", `name_code`, `genus`, `species`, `infraspecies` FROM `scientific_names`
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





/* Infraspecies place holders that don't exist in infraspecies field should be removed. */
/* Create the log */
/* Mismatch infraspecies_parent_name_code and infraspecies */
SELECT "Infraspecies mismatch (infraspecies_parent_name_code set but infraspecies empty): ", `name_code`, `infraspecies_parent_name_code` FROM `scientific_names`
WHERE CHAR_LENGTH(`infraspecies_parent_name_code`) > 1 AND
(`infraspecies` IS NULL OR `infraspecies` = '');

/* Mismatch infraspecies_marker and infraspecies */
SELECT "Infraspecies mismatch (infraspecies_marker set but infraspecies empty): ", `name_code`, `infraspecies_marker` FROM `scientific_names`
WHERE CHAR_LENGTH(`infraspecies_marker`) > 1 AND
(`infraspecies` IS NULL OR `infraspecies` = '');

/* Delete the records */
DELETE FROM `scientific_names`
WHERE CHAR_LENGTH(`infraspecies_parent_name_code`) > 1 AND
(`infraspecies` IS NULL OR `infraspecies` = '');

DELETE FROM `scientific_names`
WHERE CHAR_LENGTH(`infraspecies_marker`) > 1 AND
(`infraspecies` IS NULL OR `infraspecies` = '');





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




/* Remove the time-stamp, and, change the format to dd-mm-yyyy. */
/* Update the records */
UPDATE `scientific_names` SET `scrutiny_date` = DATE_FORMAT(`scrutiny_date`, '%d-%b-%Y')
WHERE `scrutiny_date` LIKE '%:%' AND
(`scrutiny_date` != '' OR `scrutiny_date` IS NOT NULL);




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

