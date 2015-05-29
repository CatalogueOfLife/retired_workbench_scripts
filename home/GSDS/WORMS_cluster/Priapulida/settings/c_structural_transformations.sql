SET @dbid = 124;
SET @dbabbr = 'W-Prl-';
SET @dbtouse = 'Buffer_Priapulida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Priapulida", `is_new` = 2, `taxa`="Priapulid worms or penis worms", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
