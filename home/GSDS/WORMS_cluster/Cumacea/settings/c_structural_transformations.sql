SET @dbid = 58;
SET @dbabbr = 'W-Cum-';
SET @dbtouse = 'Buffer_Cumacea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Malacostraca - Cumacea", `is_new` = 2, `taxa`="Cumaceans or hooded shrimps", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
