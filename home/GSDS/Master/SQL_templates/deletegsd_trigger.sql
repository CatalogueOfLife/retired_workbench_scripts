DROP TRIGGER IF EXISTS delgsdcascade;
DELIMITER |
CREATE TRIGGER delgsdcascade AFTER DELETE ON `databases`
FOR EACH ROW 
BEGIN

DELETE FROM `common_names` WHERE database_id = old.record_id;
DELETE FROM `distribution` WHERE database_id = old.record_id;
DELETE FROM `families` WHERE database_id = old.record_id;
DELETE FROM `scientific_names` WHERE database_id = old.record_id;
DELETE FROM `references` WHERE database_id = old.record_id;/*field present only*/
DELETE FROM `scientific_name_references` WHERE database_id = old.record_id;
DELETE FROM `specialists` WHERE database_id = old.record_id;/*field present only*/
DELETE FROM `lifezone` WHERE database_id = old.record_id;

END

|

DELIMITER ;



