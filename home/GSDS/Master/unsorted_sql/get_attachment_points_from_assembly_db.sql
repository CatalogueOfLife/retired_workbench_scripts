SELECT database_name, database_id, level, level_name, level_rank FROM
(SELECT DISTINCT
d.database_name, f.database_id, f.kingdom AS level, 'kingdom' AS level_name, 0 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1
UNION
SELECT DISTINCT
d.database_name, f.database_id, f.phylum AS level, 'phylum' AS level_name, 1 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1
UNION
SELECT DISTINCT
d.database_name, f.database_id, f.class AS level, 'class' AS level_name, 2 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1
UNION
SELECT DISTINCT
d.database_name, f.database_id, f.`order` AS level, 'order' AS level_name, 3 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1
UNION
SELECT DISTINCT
d.database_name, f.database_id, f.`superfamily` AS level, 'superfamily' AS level_name, 4 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1
UNION
SELECT DISTINCT
d.database_name, f.database_id, f.`family` AS level, 'family' AS level_name, 3 AS level_rank, count(*) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1 
) AS attachment_points
ORDER BY database_name, level_rank


/* Now same as above but presented in a different way - grouped by GSDS*/

SELECT DISTINCT d.database_name, /*d.record_id,*/ k.level AS Kingdom, p.level AS Phylum, c.level AS Class FROM `databases` d
LEFT JOIN 
(SELECT DISTINCT
d.database_name, f.database_id, f.kingdom AS level, count(DISTINCT f.kingdom) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1) AS k ON d.record_id = k.database_id 
LEFT JOIN 
(SELECT DISTINCT
d.database_name, f.database_id, f.phylum AS level, count(DISTINCT f.phylum) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1) AS p ON d.record_id = p.database_id 
LEFT JOIN 
(SELECT DISTINCT
d.database_name, f.database_id, f.class AS level, count(DISTINCT f.class) as is_same
FROM `families` f
LEFT JOIN `databases` d ON  f.database_id = d.record_id
GROUP BY f.database_id 
HAVING is_same = 1) AS c ON d.record_id = c.database_id
ORDER BY d.database_name



