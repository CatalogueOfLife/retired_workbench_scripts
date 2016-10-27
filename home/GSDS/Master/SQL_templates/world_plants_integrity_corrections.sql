/*Drop all triggers as they will interferre, will restore them back when corrections are completed*/
DROP TRIGGER IF EXISTS delfamcascade;
DROP TRIGGER IF EXISTS delrefscascade;
DROP TRIGGER IF EXISTS delspcascade; 


/*Delete violating records from assembly database*/
DELETE FROM common_names WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);

/* already created in checks script !!! therefore - commenting out*/
/* CREATE TEMPORARY TABLE scientific_names_tmp AS SELECT * FROM scientific_names; */

/*Delete violating records from assembly database*/
DELETE QUICK FROM scientific_names WHERE is_accepted_name != 1 AND accepted_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp);

/*Delete violating records from assembly database*/
DELETE QUICK FROM scientific_names WHERE infraspecies_parent_name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names_tmp);


/*Delete violating records from assembly database*/
DELETE QUICK FROM lifezone WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);
OPTIMIZE TABLE lifezone;

/*Delete violating records from assembly database*/
DELETE QUICK FROM distribution WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);
OPTIMIZE TABLE distribution;


/*Delete violating records from assembly database*/
DELETE QUICK FROM scientific_names WHERE family_code NOT IN(SELECT DISTINCT family_code FROM families);
OPTIMIZE TABLE scientific_names;


/*Delete violating records from assembly database*/
DELETE QUICK FROM scientific_name_references WHERE name_code NOT IN(SELECT DISTINCT name_code FROM scientific_names);



/*Delete violating records from assembly database*/
DELETE QUICK FROM scientific_name_references WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM `references`);
OPTIMIZE TABLE scientific_name_references;


/*Delete violating records from assembly database*/
DELETE FROM specialists WHERE specialist_code NOT IN(SELECT DISTINCT specialist_code FROM scientific_names);


/*Delete violating records from assembly database*/
DELETE QUICK FROM `references` WHERE reference_code NOT IN(SELECT DISTINCT reference_code FROM scientific_name_references 
UNION SELECT DISTINCT reference_code FROM common_names);
OPTIMIZE TABLE `references`;

/*restoring triggers in case they are needed for manual corrections*/
source /home/GSDS/Master/SQL_templates/assembly_local_triggers.sql;

