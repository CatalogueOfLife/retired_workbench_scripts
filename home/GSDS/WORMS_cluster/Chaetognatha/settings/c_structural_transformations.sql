SET @dbid = 132;
SET @dbabbr = 'W-Cha-';
SET @dbtouse = 'Buffer_Chaetognatha';

UPDATE `databases` SET `taxonomic_coverage`= null, `is_new` = 2, `taxa`=null, `coverage`= null, `completeness` = null, `confidence` = null;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql
