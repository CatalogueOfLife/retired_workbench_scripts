SET @dbid = 94;
SET @dbabbr = 'W-Iso-';
SET @dbtouse = 'Buffer_Isopoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Malacostraca - Isopoda", `is_new` = 2, `taxa`="Pillbugs, slaters and woodlice", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
