SET @dbid = 122;
SET @dbabbr = 'W-Gtr-';
SET @dbtouse = 'Buffer_Gastrotricha';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Gastrotricha", `is_new` = 2, `taxa`="Gastrotrichs or hairy backs", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
