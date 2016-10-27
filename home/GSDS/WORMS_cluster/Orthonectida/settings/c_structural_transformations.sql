SET @dbid = 149;
SET @dbabbr = 'W-Ort-';
SET @dbtouse = 'Buffer_Orthonectida';

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql

/*family_code substitution MUST go before deletion! - moved from sector replacement*/
/*Need to fix the issue with broken data before substitution can run again*/
/*source /home/GSDS/Master/SQL_templates/substitute_family_code.sql;*/