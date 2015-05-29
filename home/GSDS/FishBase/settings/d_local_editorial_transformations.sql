DELETE FROM `common_names` WHERE `common_name` IS NULL OR `common_name` = "";

DELETE FROM `distribution` WHERE `distribution` IS NULL OR `distribution` = "";

DELETE FROM `families` WHERE `kingdom` != 'Animalia';

DELETE FROM `references` WHERE `title` IS NULL OR `title` = "";

DELETE FROM `specialists` WHERE `specialist_name` IS NULL OR `specialist_name` = "";

