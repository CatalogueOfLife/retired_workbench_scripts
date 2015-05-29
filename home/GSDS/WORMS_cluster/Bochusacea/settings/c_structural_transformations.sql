SET @dbid = 86;
SET @dbabbr = 'W-Boc-';
SET @dbtouse = 'Buffer_Bochusacea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Malacostraca - Bochusacea", `is_new` = 2, `taxa`= null, `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
