SELECT CONCAT_WS('',
'UPDATE `databases` SET `taxonomic_coverage`="', `taxonomic_coverage`,
'", `is_new` = 2' ,
', `taxa`="', `taxa`,
'", `coverage`="', `coverage`, 
'", `completeness` = ', `completeness`,
', `confidence` = ', `confidence`, 
' WHERE record_id = ', record_id,
';') FROM Assembly_Global_Deploy.`databases`
 WHERE database_name LIKE("WoRMS%")
INTO OUTFILE '/home/GSDS/Master/unsorted_sql/worms_metadata_restore_assembly.sql' FIELDS TERMINATED BY ' ' ESCAPED BY '' LINES TERMINATED BY '\n';

SELECT CONCAT_WS('',
'UPDATE `_source_database_details` SET `taxonomic_coverage`="', `taxonomic_coverage`,
'", `is_new` = 2' ,
', `english_name`="', `taxa`,
'", `coverage`="', `coverage`, 
'", `completeness` = ', `completeness`,
', `confidence` = ', `confidence`, 
' WHERE id = ', record_id,
';') FROM Assembly_Global_Deploy.`databases`
 WHERE database_name LIKE("WoRMS%")
INTO OUTFILE '/home/GSDS/Master/unsorted_sql/worms_metadata_restore_baseschema.sql' FIELDS TERMINATED BY ' ' ESCAPED BY '' LINES TERMINATED BY '\n';

