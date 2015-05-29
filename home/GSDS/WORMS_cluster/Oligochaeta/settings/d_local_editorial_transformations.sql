/*The standard editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/standard_editorial_checks.sql

/*WoRMS specific editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/worms_editorial_checks.sql

/*The standard integrity checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_checks.sql
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_corrections.sql

/*Delete family Megascolecidae as instructed by Yuri on 12 September 2012 to be replaced with same family from NZOR*/
DELETE FROM families WHERE family = 'Megascolecidae';