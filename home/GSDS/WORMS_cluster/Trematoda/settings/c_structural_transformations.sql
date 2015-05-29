SET @dbid = 128;
SET @dbabbr = 'W-Trm-';
SET @dbtouse = 'Buffer_Trematoda';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Platyhelminthes-Trematoda", `is_new` = 2, `taxa`="Flukes", `coverage`="Global", `completeness` = null, `confidence` = null;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
