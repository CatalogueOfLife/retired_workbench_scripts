 

source /home/GSDS/Master/SQL_templates/set_target_assembly_database.sql


/*family_code substitution MUST go before deletion! - now consider moving to editorial templates instead*/
/*Need to fix the issue with broken data before substitution can run again*/
/*source /home/GSDS/Master/SQL_templates/substitute_family_code.sql;*/

source /home/GSDS/Master/SQL_templates/delete_gsd.sql;


/* Move remaining sectors from the Assembly local DB to the Assembly Global DB */

source /home/GSDS/Master/SQL_templates/copy_into_Assembly_Global_database.sql

