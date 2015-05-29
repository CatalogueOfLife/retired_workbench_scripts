CREATE TEMPORARY TABLE  `estimates_tmp` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kingdom` varchar(50) DEFAULT NULL,
  `phylum` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `order` varchar(50) DEFAULT NULL,
  `superfamily` varchar(50) DEFAULT NULL, 
  `family` varchar(50) DEFAULT NULL,
  `genus` varchar(50) DEFAULT NULL,
  `databases` varchar(255) DEFAULT NULL,
  `record_code` varchar(50) DEFAULT NULL,
  `estimate` int(10) unsigned,
  PRIMARY KEY (`record_id`)
);

DROP TABLE IF EXISTS `estimates`;
CREATE TABLE  `estimates` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kingdom` varchar(50) DEFAULT NULL,
  `phylum` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `order` varchar(50) DEFAULT NULL,
  `superfamily` varchar(50) DEFAULT NULL, 
  `family` varchar(50) DEFAULT NULL,
  `genus` varchar(50) DEFAULT NULL,
  `databases` varchar(255) DEFAULT NULL,
  `record_code` varchar(50) DEFAULT NULL,
  `estimate` int(10) unsigned,
  PRIMARY KEY (`record_id`)
);

INSERT INTO `estimates_tmp` 
SELECT DISTINCT NULL, `kingdom`, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `kingdom`, `phylum`, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `kingdom`, `phylum`, `class`, NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `kingdom`, `phylum`, `class`, `order`, NULL, NULL, NULL, NULL, NULL, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `kingdom`, `phylum`, `class`, `order`, `superfamily`, NULL, NULL, NULL, NULL, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `kingdom`, `phylum`, `class`, `order`, `superfamily`, `family`, NULL, NULL, `family_code`, NULL FROM `families`
UNION
SELECT DISTINCT NULL, `f`.`kingdom`, `f`.`phylum`, `f`.`class`, `f`.`order`, `f`.`superfamily`, `f`.`family`, `s`.`genus`, NULL, `s`.`name_code`, NULL 
FROM  `scientific_names` s 
LEFT JOIN `families` f ON `f`.`record_id`=`s`.`family_id`
WHERE `s`.`is_accepted_name` = 1 AND `s`.`genus` IS NOT NULL;

INSERT INTO `estimates` SELECT * FROM `estimates_tmp` ORDER BY `kingdom`,`phylum`,`class`,`order`,`superfamily`,`family`,`genus`; 