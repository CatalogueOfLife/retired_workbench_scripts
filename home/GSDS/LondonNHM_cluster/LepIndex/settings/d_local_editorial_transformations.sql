/*The LepIndex specific editorial changes*/

/*Deleting Tineidae, Papilionidae & Pieridae, Gracillariidae (will use data provided by other GSDs (46, 31, 49))*/
DELETE FROM families WHERE family IN('Tineidae','Papilionidae','Pieridae','Gracillariidae');

/*The sp2000status for all "Accepted Names"  from LepIndex should be "Provisionally Accepted". This was confirmed by Ian Kitching in his email to Yuri dated 20 December 2011*/
UPDATE scientific_names SET sp2000_status_id = 4 WHERE sp2000_status_id = 1;

/*The standard editorial checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/standard_editorial_checks.sql

/*The standard integrity checks and cleanup for all data-sets in assembly schema*/
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_checks.sql
