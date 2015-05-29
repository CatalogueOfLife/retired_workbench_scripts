SET @dbid = 109;
SET @dbabbr = 'W-Poy-';
SET @dbtouse = 'Buffer_Polycystina';

UPDATE `databases` SET `taxonomic_coverage`="Protozoa - Sarcomastigophora - Polycystina", `is_new` = 2, `taxa`="Polycystines (radiolarian protists)", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
