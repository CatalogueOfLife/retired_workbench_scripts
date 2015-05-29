SET @dbid = 125;
SET @dbabbr = 'W-Gtd-';
SET @dbtouse = 'Buffer_Gnathostomulida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Gnathostomulida", `is_new` = 2, `taxa`="Gnathostomulids or jaw worms", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
