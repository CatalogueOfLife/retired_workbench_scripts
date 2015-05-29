SET @dbid = 129;
SET @dbabbr = 'W-Myx-';
SET @dbtouse = 'Buffer_Myxozoa';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Myxozoa", `is_new` = 2, `taxa`="Myxozoans", `coverage`="Global", `completeness` = 15, `confidence` = 3;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
