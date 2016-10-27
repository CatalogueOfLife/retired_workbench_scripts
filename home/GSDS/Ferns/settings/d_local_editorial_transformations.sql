UPDATE `databases` SET `is_new` = 2, `version` = DATE_FORMAT(NOW(),'%b %Y'), `release_date` = CURRENT_DATE(), `web_site` = 'http://worldplants.webarchiv.kit.edu/ferns/';

DELETE FROM scientific_names WHERE species = 'yyy';


UPDATE scientific_names SET sp2000_status_id = 4 WHERE `author` LIKE "%comb. ined.%";

UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Cyatheales" ;
UPDATE families SET class = "Equisetopsida" WHERE `order` = "Equisetales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Gleicheniales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Hymenophyllales" ;
UPDATE families SET class = "Lycopodiopsida" WHERE `order` = "Isoetales" ;
UPDATE families SET class = "Lycopodiopsida" WHERE `order` = "Lycopodiales" ;
UPDATE families SET class = "Marattiopsida" WHERE `order` = "Marattiales" ;
UPDATE families SET class = "Psilotopsida" WHERE `order` = "Ophioglossales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Osmundales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Polypodiales" ;
UPDATE families SET class = "Psilotopsida" WHERE `order` = "Psilotales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Salviniales" ;
UPDATE families SET class = "Polypodiopsida" WHERE `order` = "Schizaeales" ;
UPDATE families SET class = "Lycopodiopsida" WHERE `order` = "Selaginellales" ;
UPDATE `families` SET `is_accepted_name` = 1;
UPDATE families SET hierarchy_code = CONCAT(`kingdom`,'-',`phylum`,'-',`class`,'-',`order`,'-',`family`);


/*The standard editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/standard_editorial_checks.sql

/* World Plants specific editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/world_plants_editorial_checks.sql

/*The standard integrity checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_checks.sql

/* World Plants specific correction script that omits deletion of duplicate taxa 
source /home/GSDS/Master/SQL_templates/world_plants_integrity_corrections.sql*/
