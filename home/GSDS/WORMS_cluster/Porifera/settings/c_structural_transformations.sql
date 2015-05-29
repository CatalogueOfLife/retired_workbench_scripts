SET @dbid = 44;
SET @dbabbr = 'W-Por-';
SET @dbtouse = 'Buffer_Porifera';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Porifera", `is_new` = 2, `taxa`="Sponges", `coverage`="Global", `completeness` = 96, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
