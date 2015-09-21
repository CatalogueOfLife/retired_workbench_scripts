/*Drop all triggers as they will interferre, will restore them back when corrections are completed*/
DROP TRIGGER IF EXISTS delfamcascade;
DROP TRIGGER IF EXISTS delrefscascade;
DROP TRIGGER IF EXISTS delspcascade;

/*Merge duplicate entries by leaving entries with max id assuming they are the latest and most up-to-date ones*/
CREATE TEMPORARY TABLE duplicates_to_delete AS
SELECT "Accepted name to be deleted", sn.name_code AS name_code, sn.sp2000_status_id AS sp2000_status_id, dups.genus AS genus, dups.subgenus AS subgenus,
	dups.species AS species, dups.infraspecies_marker AS infraspecies_marker, dups.infraspecies AS infraspecies, dups.author AS author
FROM
	(SELECT genus, subgenus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt
	FROM scientific_names
	GROUP BY genus, subgenus, species, infraspecies, infraspecies_marker, author, sp2000_status_id
	HAVING cnt > 1) AS dups
LEFT JOIN scientific_names sn ON sn.genus = dups.genus AND sn.subgenus = dups.subgenus AND sn.species = dups.species AND sn.author = dups.author
WHERE sn.sp2000_status_id = 1 AND sn.name_code NOT IN
	(SELECT dups3.namecodes_to_keep FROM
		(SELECT MAX(name_code) AS namecodes_to_keep, genus, subgenus, species, infraspecies_marker, infraspecies, author FROM
			(SELECT sn.name_code AS name_code, sn.sp2000_status_id AS sp2000_status_id, dups.genus AS genus, dups.subgenus AS subgenus, dups.species AS species,
				dups.infraspecies_marker AS infraspecies_marker, dups.infraspecies AS infraspecies, dups.author AS author
			FROM
				(SELECT genus, subgenus, species, infraspecies_marker, infraspecies, author, sp2000_status_id, count(*) as cnt
				FROM scientific_names
				GROUP BY genus, subgenus, species, infraspecies, infraspecies_marker, author, sp2000_status_id HAVING cnt > 1) AS dups
			LEFT JOIN scientific_names sn ON sn.genus = dups.genus AND sn.subgenus = dups.subgenus AND sn.species = dups.species AND sn.author = dups.author
			WHERE sn.sp2000_status_id = 1) AS dups2
		GROUP BY genus, subgenus, species, infraspecies_marker, infraspecies, author) AS dups3);


/*DELETE QUICK FROM scientific_names WHERE name_code IN(SELECT name_code FROM duplicates_to_delete);*/
DELETE QUICK FROM scientific_names
USING scientific_names
INNER JOIN duplicates_to_delete ON scientific_names.name_code = duplicates_to_delete.name_code;




/* Ruud 09-09-15: WHERE NOT IN queries are notoriously slow. Rewritten with LEFT JOINs */

/*Delete violating records from assembly database
DELETE FROM common_names WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
DELETE QUICK t1 FROM common_names AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;

/* already created in checks script !!! therefore - commenting out*/
/* CREATE TEMPORARY TABLE scientific_names_tmp AS SELECT * FROM scientific_names; */



/*Delete violating records from assembly database
DELETE QUICK FROM scientific_names WHERE is_accepted_name != 1 AND accepted_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp);*/
DELETE QUICK t1 FROM scientific_names AS t1
LEFT JOIN scientific_names_tmp AS t2 ON t1.accepted_name_code = t2.name_code
WHERE t2.name_code IS NULL AND t1.is_accepted_name != 1;


/*Delete violating records from assembly database
DELETE QUICK FROM scientific_names WHERE infraspecies_parent_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp);*/
DELETE QUICK t1 FROM scientific_names AS t1
LEFT JOIN scientific_names_tmp AS t2 ON t1.infraspecies_parent_name_code = t2.name_code
WHERE t1.infraspecies_parent_name_code IS NOT NULL AND t2.name_code IS NULL;


/*Delete violating records from assembly database
DELETE QUICK FROM lifezone WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
DELETE QUICK t1 FROM lifezone AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;
OPTIMIZE TABLE lifezone;

/*Delete violating records from assembly database
DELETE QUICK FROM distribution WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
DELETE QUICK t1 FROM distribution AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;
OPTIMIZE TABLE distribution;


/*Delete violating records from assembly database
DELETE QUICK FROM scientific_names WHERE family_code NOT IN(SELECT DISTINCT family_code FROM families);*/
DELETE QUICK t1 FROM scientific_names AS t1
LEFT JOIN families AS t2 ON t1.family_code = t2.family_code
WHERE t2.family_code IS NULL;
OPTIMIZE TABLE scientific_names;


/*Delete violating records from assembly database
DELETE QUICK FROM scientific_name_references WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);*/
DELETE QUICK t1 FROM scientific_name_references AS t1
LEFT JOIN scientific_names AS t2 ON t1.name_code = t2.name_code
WHERE t2.name_code IS NULL;


/*Delete violating records from assembly database
DELETE QUICK FROM scientific_name_references WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM `references`);*/
DELETE QUICK t1 FROM scientific_name_references AS t1
LEFT JOIN `references` AS t2 ON t1.reference_code = t2.reference_code
WHERE t2.reference_code IS NULL;
OPTIMIZE TABLE scientific_name_references;


/*Delete violating records from assembly database
DELETE FROM specialists WHERE specialist_code NOT IN(SELECT DISTINCT specialist_code FROM scientific_names)*/;
DELETE QUICK t1 FROM specialists AS t1
LEFT JOIN `scientific_names` AS t2 ON t1.specialist_code = t2.specialist_code
WHERE t2.specialist_code IS NULL;


/*Delete violating records from assembly database
DELETE QUICK FROM `references` WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM scientific_name_references
UNION SELECT DISTINCT reference_code FROM common_names);*/
DELETE t1 FROM `references` AS t1
LEFT JOIN scientific_name_references AS t2 ON t1.reference_code = t2.reference_code
LEFT JOIN common_names AS t3 ON t1.reference_code = t3.reference_code
WHERE t2.reference_code IS NULL AND t3.reference_code IS NULL;
OPTIMIZE TABLE `references`;

/*restoring triggers in case they are needed for manual corrections*/
source /home/GSDS/Master/SQL_templates/assembly_local_triggers.sql;

