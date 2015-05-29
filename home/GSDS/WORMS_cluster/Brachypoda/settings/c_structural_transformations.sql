SET @dbid = 87;
SET @dbabbr = 'Brc-';
SET @dbtouse = 'Buffer_Brachypoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Cephalocarida - Brachypoda", `is_new` = 2, `taxa`="Brachypods", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
