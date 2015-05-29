SET @dbid = 92;
SET @dbabbr = 'W-Tan-';
SET @dbtouse = 'Buffer_Tantulocarida';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Maxillopoda - Not assigned to the order - Basipodellidae, Deoterthridae, Doryphallophoridae & Microdajidae (subclass Tantulocarida)", `is_new` = 2, `taxa`="Tantulocaridans", `coverage`="Global", `completeness` = 97, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
