SET @dbid = 104;
SET @dbabbr = 'W-Pho-';
SET @dbtouse = 'Buffer_Phoronida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Phoronida", `is_new` = 2, `taxa`="Horseshoe worms", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
