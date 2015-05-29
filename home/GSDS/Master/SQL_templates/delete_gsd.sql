SET @query = CONCAT("
DELETE FROM ",
@dbtouse,
".`databases` WHERE `record_id` = @dbid");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;