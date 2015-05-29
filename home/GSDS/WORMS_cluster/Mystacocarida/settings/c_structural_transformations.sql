SET @dbid = 88;
SET @dbabbr = 'W-Mys-';
SET @dbtouse = 'Buffer_Mystacocarida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Maxillopoda - (subclass Mystacocarida) - Mystacocaridida", `is_new` = 2, `taxa`="Mystacocarids", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
