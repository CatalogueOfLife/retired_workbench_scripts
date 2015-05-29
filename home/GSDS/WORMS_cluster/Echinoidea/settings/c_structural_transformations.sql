SET @dbid = 106;
SET @dbabbr = 'W-Ech-';
SET @dbtouse = 'Buffer_Echinoidea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Echinodermata-Echinoidea", `is_new` = 2, `taxa`="Sea urchins", `coverage`="Global", `completeness` = 94, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
