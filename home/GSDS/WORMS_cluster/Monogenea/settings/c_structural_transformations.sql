SET @dbid = 126;
SET @dbabbr = 'W-Mon-';
SET @dbtouse = 'Buffer_Monogenea';

UPDATE `databases` SET `taxonomic_coverage`="Animalia-Platyhelminthes-Monogenea", `is_new` = 2, `taxa`="Monogenean flatworms", `coverage`="Global", `completeness` = 100, `confidence` = 3;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
