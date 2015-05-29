SET @gsdabbr = (SELECT gsdabbr FROM _gsd_codes WHERE database_id = @dbid);

DELETE FROM common_names WHERE database_id = @dbid;
DELETE FROM distribution WHERE name_code LIKE CONCAT(@gsdabbr,"%");

DELETE FROM databases WHERE database_id = @dbid;
DELETE FROM families WHERE database_id = @dbid;
DELETE FROM scientific_names WHERE database_id = @dbid;
DELETE FROM references WHERE database_id = @dbid;/*field present only*/
DELETE FROM scientific_name_references WHERE name_code LIKE CONCAT(@gsdabbr,"%");
DELETE FROM specialists WHERE database_id = @dbid;/*field present only*/
DELETE FROM distribution WHERE name_code LIKE CONCAT(@gsdabbr,"%");
DELETE FROM lifezone WHERE name_code LIKE CONCAT(@gsdabbr,"%");

 
 
 


