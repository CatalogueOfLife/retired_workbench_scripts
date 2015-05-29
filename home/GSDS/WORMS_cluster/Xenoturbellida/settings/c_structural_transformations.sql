SET @dbid = 100;
SET @dbabbr = 'W-Xen-';
SET @dbtouse = 'Buffer_Xenoturbellida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Xenoturbellida", `is_new` = 2, `taxa`="Xenoturbellids", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
