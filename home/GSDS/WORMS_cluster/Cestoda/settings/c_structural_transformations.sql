SET @dbid = 127;
SET @dbabbr = 'W-Cst-';
SET @dbtouse = 'Buffer_Cestoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Platyhelminthes-Cestoda", `is_new` = 2, `taxa`="Tapeworms", `coverage`="Global", `completeness` = 100, `confidence` = 3;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
