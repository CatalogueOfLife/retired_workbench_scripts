
DROP TRIGGER IF EXISTS delrefscascade;
DELIMITER |
CREATE TRIGGER delrefscascade AFTER DELETE ON `scientific_name_references`
FOR EACH ROW 
BEGIN

DELETE FROM `references` WHERE reference_code = old.reference_code;

END 
|