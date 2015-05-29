SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`databases` WHERE `record_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`common_names` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`distribution` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`families` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`scientific_names` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`references` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`scientific_name_references` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`specialists` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`lifezone` WHERE `database_id` = @dbid"
);
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;