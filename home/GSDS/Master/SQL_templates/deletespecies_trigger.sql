
DROP TRIGGER IF EXISTS delfamcascade;
DELIMITER |
CREATE TRIGGER delspcascade AFTER DELETE ON `scientific_names`
FOR EACH ROW 
BEGIN

DELETE FROM `common_names` WHERE name_code = old.name_code;
DELETE FROM `distribution` WHERE name_code = old.name_code;
DELETE FROM `lifezone` WHERE name_code = old.name_code;
DELETE FROM `scientific_name_references` WHERE name_code = old.name_code;
DELETE FROM `common_names` WHERE name_code = old.name_code;

END 
|