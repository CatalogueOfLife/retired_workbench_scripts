
DROP TRIGGER IF EXISTS delfamcascade;
DELIMITER |
CREATE TRIGGER delfamcascade AFTER DELETE ON `families`
FOR EACH ROW 
BEGIN

DELETE FROM `scientific_names` WHERE family_code = old.family_code;

END 
|