SET @dbid = 85;
SET @dbabbr = 'W-Nem-';
SET @dbtouse = 'Buffer_Nemertea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Nemertea", `is_new` = 2, `taxa`="Ribbon worms", `coverage`="Global", `completeness` = 100, `confidence` = 4;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
