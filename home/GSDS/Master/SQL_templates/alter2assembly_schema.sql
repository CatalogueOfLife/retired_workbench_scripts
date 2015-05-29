
ALTER TABLE `scientific_names` MODIFY `accepted_name_code` varchar(42);
ALTER TABLE `common_names` MODIFY `name_code` varchar(42);
ALTER TABLE `common_names` MODIFY `transliteration` varchar(700);
ALTER TABLE `distribution` MODIFY `name_code` varchar(42);
ALTER TABLE `distribution` ADD COLUMN `database_id` int(10) unsigned;
ALTER TABLE `distribution` MODIFY `DistributionStatus` varchar(45);
ALTER TABLE `lifezone` MODIFY `name_code` varchar(42);
ALTER TABLE `lifezone` ADD COLUMN `database_id` int(10) unsigned;
ALTER TABLE `scientific_name_references` ADD COLUMN `database_id` int(10) unsigned;
ALTER TABLE `specialists` MODIFY `database_id` int(10) unsigned;



DROP TRIGGER IF EXISTS delcascade;
DELIMITER $$
CREATE TRIGGER delcascade AFTER DELETE ON `databases`
FOR EACH ROW 
BEGIN

DELETE FROM `common_names` WHERE database_id = old.record_id;
DELETE FROM `distribution` WHERE database_id = old.record_id;
DELETE FROM `databases` WHERE database_id = old.record_id;
DELETE FROM `families` WHERE database_id = old.record_id;
DELETE FROM `scientific_names` WHERE database_id = old.record_id;
DELETE FROM `references` WHERE database_id = old.record_id;/*field present only*/
DELETE FROM `scientific_name_references` WHERE database_id = old.record_id;
DELETE FROM `specialists` WHERE database_id = old.record_id;/*field present only*/
DELETE FROM `distribution` WHERE database_id = old.record_id;
DELETE FROM `lifezone` WHERE database_id = old.record_id;

END $$

