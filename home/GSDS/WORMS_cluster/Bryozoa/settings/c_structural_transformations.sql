SET @dbid = 81;
SET @dbabbr = 'W-Bry-';
SET @dbtouse = 'Buffer_Bryozoa';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Bryozoa", `is_new` = 2, `taxa`="Bryozoans, moss animals", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql