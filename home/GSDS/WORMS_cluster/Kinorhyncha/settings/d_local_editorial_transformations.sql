UPDATE `databases` SET `taxonomic_coverage`="Animalia - Kinorhyncha", `is_new` = 2, `taxa`="Mud dragons", `coverage`="Global", `completeness` = 97, `confidence` = 5;

/*The standard editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/standard_editorial_checks.sql

/*WoRMS specific editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/worms_editorial_checks.sql

/*The standard integrity checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_checks.sql
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_corrections.sql

 

