USE `Assembly_GSDdatabase`;

DELETE FROM `distribution` WHERE `distribution` IS NULL OR `distribution` = "";

DELETE FROM `families` WHERE `kingdom` != 'Animalia';

DELETE FROM `references` WHERE `title` IS NULL OR `title` = "";

DELETE FROM `specialists` WHERE `specialist_name` IS NULL OR `specialist_name` = "";

