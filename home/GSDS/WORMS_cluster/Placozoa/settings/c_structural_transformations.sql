SET @dbid = 123;
SET @dbabbr = 'W-Plz-';
SET @dbtouse = 'Buffer_Placozoa';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Placozoa", `is_new` = 2, `taxa`="Placozoans or pancake animals", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
