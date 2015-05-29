/*This marks and removes old data from China and ITIS associated with Ferns*/
UPDATE families SET database_id = 140 WHERE `order` IN("Lycopodiales", "Selaginellales", "Isoetales", "Ophioglossales", "Psilotales", "Equisetales", "Marattiales", "Osmundales", "Hymenophyllales", "Gleicheniales", "Schizaeales", "Salviniales", "Cyatheales", "Polypodiales");   
UPDATE scientific_names SET database_id = 140 WHERE family_code IN(SELECT DISTINCT family_code FROM families WHERE database_id = 140);
UPDATE common_names SET database_id = 140 WHERE name_code IN(SELECT DISTINCT name_code FROM scientific_names  WHERE database_id = 140);
UPDATE distribution SET database_id = 140 WHERE name_code IN(SELECT DISTINCT name_code FROM scientific_names  WHERE database_id = 140);	
UPDATE lifezone SET database_id = 140 WHERE name_code IN(SELECT DISTINCT name_code FROM scientific_names  WHERE database_id = 140);
UPDATE scientific_name_references SET database_id = 140 WHERE name_code IN(SELECT DISTINCT name_code FROM scientific_names  WHERE database_id = 140);