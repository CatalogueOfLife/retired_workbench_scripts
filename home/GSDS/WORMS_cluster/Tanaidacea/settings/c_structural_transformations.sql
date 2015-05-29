SET @dbid = 110;
SET @dbabbr = 'W-Tnd-';
SET @dbtouse = 'Buffer_Tanaidacea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Arthropoda-Malacostraca-Tanaidacea", `is_new` = 2, `taxa`="Tanaids", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
