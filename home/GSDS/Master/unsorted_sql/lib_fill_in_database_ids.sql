UPDATE `distribution` SET database_id = @dbid WHERE name_code LIKE CONCAT(@dbabbr,'%');

/*field present only with some database_id's*/
UPDATE `references` SET database_id = @dbid WHERE reference_code LIKE CONCAT(@dbabbr,'%');
UPDATE `scientific_name_references` SET database_id = @dbid WHERE name_code LIKE CONCAT(@dbabbr,'%');
UPDATE `specialists` SET database_id = @dbid WHERE specialist_code LIKE CONCAT(@dbabbr,'%'); /*field present only*/
UPDATE `lifezone` SET database_id = @dbid WHERE name_code LIKE CONCAT(@dbabbr,'%');


