DROP TRIGGER IF EXISTS delfamcascade;
DROP TRIGGER IF EXISTS delspcascade;
DROP TRIGGER IF EXISTS delrefscascade;
DELIMITER $$
CREATE TRIGGER delfamcascade AFTER DELETE ON `families`
FOR EACH ROW 
BEGIN

DELETE FROM `scientific_names` WHERE family_code = old.family_code;

END;

CREATE TRIGGER delspcascade AFTER DELETE ON `scientific_names`
FOR EACH ROW 
BEGIN

DELETE FROM `common_names` WHERE name_code = old.name_code;
DELETE FROM `distribution` WHERE name_code = old.name_code;
DELETE FROM `lifezone` WHERE name_code = old.name_code;
DELETE FROM `scientific_name_references` WHERE name_code = old.name_code;
DELETE FROM `common_names` WHERE name_code = old.name_code;

END;

CREATE TRIGGER delrefscascade AFTER DELETE ON `scientific_name_references`
FOR EACH ROW 
BEGIN

DELETE FROM `references` WHERE reference_code = old.reference_code;

END;

$$