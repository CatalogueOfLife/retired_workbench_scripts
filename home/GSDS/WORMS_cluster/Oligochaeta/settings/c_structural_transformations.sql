SET @dbid = 99;
SET @dbabbr = 'W-Oli-';
SET @dbtouse = 'Buffer_Oligochaeta';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Annelida - Clitellata - Capilloventrida, Crassiclitellata, Enchytraeida, Haplotaxida & Lumbriculida (subclass Oligochaeta)", `is_new` = 2, `taxa`="Earthworms, oligochaetes", `coverage`="Global", `completeness` = 99, `confidence` = 3;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
