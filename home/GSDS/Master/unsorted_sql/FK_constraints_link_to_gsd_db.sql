ALTER TABLE `common_names`
    ADD CONSTRAINT link_to_gsd_db 
    FOREIGN KEY (database_id)
    REFERENCES `databases` (record_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

