SET @dbid = 93;
SET @dbabbr = 'W-The-';
SET @dbtouse = 'Buffer_Thermosbaenacea';

UPDATE `databases` SET `taxonomic_coverage`="AAnimalia - Arthropoda - Malacostraca - Thermosbaenacea", `is_new` = 2, `taxa`="Hot-springs shrimps", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
