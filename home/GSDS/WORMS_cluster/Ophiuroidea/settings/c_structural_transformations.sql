SET @dbid = 59;
SET @dbabbr = 'W-Oph-';
SET @dbtouse = 'Buffer_Ophiuroidea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Echinodermata - Ophiuroidea", `is_new` = 2, `taxa`="Brittle stars and basket stars", `coverage`="Global", `completeness` = 95, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
