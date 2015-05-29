SET @gsdabbr = (SELECT gsdabbr FROM _gsd_codes WHERE database_id = 113);
SELECT * FROM families WHERE family_code LIKE CONCAT(@gsdabbr,"%");