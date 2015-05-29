SET @dbid = 90;
SET @dbabbr = 'W-Pol-';
SET @dbtouse = 'Buffer_Polychaeta';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Annelida - Polychaeta", `is_new` = 2, `taxa`="Bristle worms", `coverage`="Global", `completeness` = 92, `confidence` = 4;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
