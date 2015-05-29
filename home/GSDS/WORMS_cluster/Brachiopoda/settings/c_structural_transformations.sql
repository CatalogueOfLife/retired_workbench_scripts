SET @dbid = 57;
SET @dbabbr = 'W-Bra-';
SET @dbtouse = 'Buffer_Brachiopoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Brachiopoda", `is_new` = 2, `taxa`="Lamp-shells", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
