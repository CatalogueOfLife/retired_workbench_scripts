SET @dbid = 107;
SET @dbabbr = 'W-Hol-';
SET @dbtouse = 'Buffer_Holothuroidea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Echinodermata-Holothuroidea", `is_new` = 2, `taxa`="Sea cucumbers", `coverage`="Global", `completeness` = 98, `confidence` = 4;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
