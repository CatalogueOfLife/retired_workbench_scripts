/*Check for duplicate species in scientific_names and merge duplicate records*/
SELECT "Duplicate accepted names:", sn.name_code, sn.sp2000_status_id, dups.genus, dups.species, dups.infraspecies_marker, dups.infraspecies, dups.author FROM (SELECT genus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt FROM scientific_names GROUP BY genus, species, infraspecies, infraspecies_marker, author, sp2000_status_id HAVING cnt > 1) dups LEFT JOIN scientific_names sn ON sn.genus = dups.genus AND sn.species = dups.species AND sn.author = dups.author WHERE sn.sp2000_status_id = 1;

SELECT "Accepted name to be retained", MAX(name_code), genus, species, infraspecies_marker, infraspecies, author FROM
(SELECT sn.name_code AS name_code, sn.sp2000_status_id AS sp2000_status_id, dups.genus AS genus, dups.species AS species, dups.infraspecies_marker AS infraspecies_marker, dups.infraspecies AS infraspecies, dups.author AS author FROM (SELECT genus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt FROM scientific_names GROUP BY genus, species, infraspecies, infraspecies_marker, author, sp2000_status_id HAVING cnt > 1) dups LEFT JOIN scientific_names sn
ON sn.genus = dups.genus AND sn.species = dups.species AND sn.author = dups.author WHERE sn.sp2000_status_id = 1) AS dups2 GROUP BY genus, species, infraspecies_marker, infraspecies, author;

SELECT "Accepted name to be deleted", sn.name_code AS name_code, sn.sp2000_status_id AS sp2000_status_id, dups.genus AS genus, dups.species AS species, dups.infraspecies_marker AS infraspecies_marker, dups.infraspecies AS infraspecies, dups.author AS author FROM (SELECT genus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt FROM scientific_names GROUP BY genus, species, infraspecies, infraspecies_marker, author, sp2000_status_id HAVING cnt > 1) dups LEFT JOIN scientific_names sn ON sn.genus = dups.genus AND sn.species = dups.species AND sn.author = dups.author WHERE sn.sp2000_status_id = 1
AND sn.name_code NOT IN (SELECT dups3.namecodes_to_keep FROM
(SELECT MAX(name_code) AS namecodes_to_keep, genus, species, infraspecies_marker, infraspecies, author FROM
(SELECT sn.name_code AS name_code, sn.sp2000_status_id AS sp2000_status_id, dups.genus AS genus, dups.species AS species, dups.infraspecies_marker AS infraspecies_marker, dups.infraspecies AS infraspecies, dups.author AS author FROM (SELECT genus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt
FROM scientific_names
GROUP BY genus, species, infraspecies, infraspecies_marker, author, sp2000_status_id HAVING cnt > 1) dups
LEFT JOIN scientific_names sn
ON sn.genus = dups.genus AND sn.species = dups.species AND sn.author = dups.author WHERE sn.sp2000_status_id = 1) AS dups2 GROUP BY genus, species, infraspecies_marker, infraspecies, author) AS dups3);


/* Ruud 09-09-15: WHERE NOT IN queries are notoriously slow. Rewritten with LEFT JOINs */

/*check if there are common_names without parent accepted_name
SELECT 'Common name without parent accepted name', record_id, common_name, name_code FROM common_names
WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
SELECT 'Common name without parent accepted name', t1.record_id, t1.common_name, t1.name_code FROM common_names AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;


/* Ruud: problem with tmp table was the lack of indices; added these from original table description */
CREATE TEMPORARY TABLE scientific_names_tmp 
(PRIMARY KEY (`record_id`,`name_code`),
  KEY `database_id` (`database_id`),
  KEY `family_id` (`family_id`),
  KEY `species` (`species`),
  KEY `infraspecies` (`infraspecies`),
  KEY `specialist_code` (`specialist_code`),
  KEY `accepted_name_code` (`accepted_name_code`),
  KEY `infraspecies_parent_name_code` (`infraspecies_parent_name_code`),
  KEY `name_code1` (`name_code`,`family_id`),
  KEY `record_id` (`record_id`,`family_id`),
  KEY `genus` (`genus`,`species`,`infraspecies`),
  KEY `sp2000_status_id` (`sp2000_status_id`),
  KEY `sp2000_status_id_2` (`sp2000_status_id`,`database_id`,`infraspecies`))
SELECT * FROM scientific_names;

/*check if there are synonyms without parent accepted_name SLOW!!! 40 min for lepindex*/
/* SELECT 'Synonym without parent accepted name', record_id, name_code, genus, species, infraspecies, accepted_name_code FROM scientific_names
WHERE is_accepted_name != 1 AND accepted_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp); */

/*check if there are infraspecies without parent accepted_name SLOW!!! takes 1:30 hour for lepindex*/
/* SELECT 'Infraspecies without parent accepted name', record_id, name_code, genus, species, infraspecies, accepted_name_code FROM scientific_names
WHERE infraspecies_parent_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp); */

/* quick check (instead of the 2 slow ones above) for synonyms and infraspecies without parent names - assuming those without family_code are the troublemakers */
SELECT 'Missing parent accepted name for synonym', record_id, name_code, genus, species, infraspecies, accepted_name_code FROM scientific_names
WHERE is_accepted_name != 1 AND family_code IS NULL;

SELECT 'Missing parent accepted name for infraspecies', record_id, name_code, genus, species, infraspecies, infraspecies_parent_name_code FROM scientific_names WHERE LENGTH(infraspecies)>1  AND family_code IS NULL;


/* Ruud 09-09-15: WHERE NOT IN queries are notoriously slow. Rewritten with LEFT JOINs */

/*check if there are any lifezone records without parent accepted_name
SELECT 'Lifezone without parent accepted name', record_id, name_code, lifezone FROM lifezone
WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
SELECT 'Lifezone without parent accepted name', t1.record_id, t1.name_code, t1.lifezone FROM lifezone AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;


/*check if there are any distribution records without parent accepted_name
SELECT 'Distribution without parent accepted name', record_id, name_code, distribution FROM distribution
WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
SELECT 'Distribution without parent accepted name', t1.record_id, t1.name_code, t1.distribution FROM distribution AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;


/*check if there are accepted names without parent family
SELECT 'Accepted name without parent family', record_id, name_code, genus, species, infraspecies, family_code FROM scientific_names
WHERE family_code NOT IN(SELECT DISTINCT family_code FROM families);*/
SELECT 'Accepted name without parent family', t1.record_id, t1.name_code, t1.genus, t1.species, t1.infraspecies, t1.family_code FROM scientific_names AS t1
LEFT JOIN families AS t2 ON t1.family_code = t2.family_code
WHERE t2.family_code IS NULL;


/*check if there are orphan reference links in scientific_name_references
SELECT 'Reference link to non-existing accepted name', record_id, reference_code, name_code FROM scientific_name_references
WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
SELECT 'Reference link to non-existing accepted name', t1.record_id, t1.reference_code, t1.name_code FROM scientific_name_references AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;


/*check if there are orphan reference links in scientific_name_references
SELECT 'Reference link to non-existing reference', record_id, reference_code, name_code FROM scientific_name_references
WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM `references`);*/
SELECT 'Reference link to non-existing reference', t1.record_id, t1.reference_code, t1.name_code FROM scientific_name_references AS t1
LEFT JOIN `references` AS t2 ON t1.reference_code = t2.reference_code
WHERE t2.reference_code IS NULL;


/*check if there are orphan specialists
SELECT 'Specialist not present in scientific names table', record_id, specialist_name, specialist_code FROM specialists
WHERE specialist_code NOT IN(SELECT DISTINCT specialist_code FROM scientific_names);*/
SELECT 'Specialist not present in scientific names table', t1.record_id, t1.specialist_name, t1.specialist_code FROM specialists AS t1
LEFT JOIN scientific_names AS t2 ON t1.specialist_code = t2.specialist_code
WHERE t2.specialist_code IS NULL;


/*check if there are orphan references
SELECT 'Reference without parent accepted or common name', record_id, author, year, title, reference_code FROM `references`
WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM scientific_name_references 
UNION SELECT DISTINCT reference_code FROM common_names);*/
SELECT 'Reference without parent accepted or common name', t1.record_id, t1.author, t1.year, t1.title, t1.reference_code FROM `references` AS t1
LEFT JOIN scientific_name_references AS t2 ON t1.reference_code = t2.reference_code
LEFT JOIN common_names AS t3 ON t1.reference_code = t3.reference_code
WHERE t2.reference_code IS NULL AND t3.reference_code IS NULL