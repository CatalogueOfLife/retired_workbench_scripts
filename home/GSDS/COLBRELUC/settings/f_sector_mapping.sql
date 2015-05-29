SET @dbid = 0;

source /home/GSDS/Master/SQL_templates/set_target_assembly_database.sql
source /home/GSDS/Master/SQL_templates/delete_gsd.sql;


/* Move remaining sectors from the Assembly local DB to the Assembly Global DB */

source /home/GSDS/Master/SQL_templates/copy_into_Assembly_Global_database.sql