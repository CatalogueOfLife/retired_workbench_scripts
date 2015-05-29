SET @dbid = 112;
SET @dbabbr = 'W-Hyd-';
SET @dbtouse = 'Buffer_Hydrozoa';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Cnidaria-Hydrozoa", `is_new` = 2, `taxa`="Hydroids", `coverage`="Global", `completeness` = 95, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
