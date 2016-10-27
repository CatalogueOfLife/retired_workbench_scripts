SET @dbid = 154;

/* Delete unneeded sectors first from the local Assembly database*/
/* DELETE FROM `families` WHERE `family` NOT IN("...","...") ; */

source /home/GSDS/Master/SQL_templates/sector_replacement_standard.sql;
