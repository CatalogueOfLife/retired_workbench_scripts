SET @dbid = 130;
SET @dbabbr = 'W-Msc-';
SET @dbtouse = 'Buffer_Mollusca';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Mollusca", `is_new` = 2, `taxa`="Marine molluscs", `coverage`="Global", `completeness` = 60, `confidence` = 3;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
