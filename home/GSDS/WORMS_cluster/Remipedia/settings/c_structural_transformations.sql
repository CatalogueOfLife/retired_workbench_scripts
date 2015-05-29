SET @dbid = 91;
SET @dbabbr = 'W-Rem-';
SET @dbtouse = 'Buffer_Remipedia';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Remipedia", `is_new` = 2, `taxa`="Remipedes", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
