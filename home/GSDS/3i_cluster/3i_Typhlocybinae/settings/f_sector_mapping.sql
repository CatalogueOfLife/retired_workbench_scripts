USE `Assembly_GSDdatabase`;


/* Delete GSDdatabase (database_id = 00) sectors from the global Assembly database*/
/* Schema is set to cascade deletions to related tables ON DELETE in databases*/

DELETE FROM `Assembly_Global`.`databases` WHERE `record_id` = 00;


/* Delete unneeded sectors first from the local Assembly database*/
/* Schema is set to cascade deletions to related tables ON DELETE in families*/
/* For GSDdatabase there is so far nothing to delete, therefore commenting out */
/* DELETE FROM `families` WHERE `Assembly_GSDdatabase`.`genus` NOT IN() ; */



/* Move remaining sectors from the Assembly local DB to the Assembly Global DB */

source /home/GSDS/Master/global_editorial_settings/copy_into_Assembly_Global_database.sql
