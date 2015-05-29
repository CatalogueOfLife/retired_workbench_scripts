SET @dbid = 111;
SET @dbabbr = 'W-Sca-';
SET @dbtouse = 'Buffer_Scaphopoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Mollusca-Scaphopoda", `is_new` = 2, `taxa`="Tusk shells", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql