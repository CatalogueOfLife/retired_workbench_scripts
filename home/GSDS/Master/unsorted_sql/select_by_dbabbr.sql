/*AnnonBase*/
SET @dbid = 40;
SET @dbabbr = 'Ano-';


SELECT * FROM `distribution` WHERE name_code LIKE CONCAT(@dbabbr,'%') LIMIT 0, 25;


