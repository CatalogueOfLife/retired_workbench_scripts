SET @dbid = 60;
SET @dbabbr = 'W-Rha-';
SET @dbtouse = 'Buffer_Proseriata_Kalyptorhynchia';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Platyhelminthes - Turbellaria - Proseriata, Kalyptorhynchia", `is_new` = 2, `taxa`="Freeliving flatworms", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
