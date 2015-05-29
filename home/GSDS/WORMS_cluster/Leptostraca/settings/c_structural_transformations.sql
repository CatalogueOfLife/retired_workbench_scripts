SET @dbid = 105;
SET @dbabbr = 'W-Lpt-';
SET @dbtouse = 'Buffer_Leptostraca';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Arthropoda-Malacostraca-(superorder Leptostraca)-Nebaliacea", `is_new` = 2, `taxa`="Leptostraca", `coverage`="Global", `completeness` = 98, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
