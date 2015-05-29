#----------------------------
# Table structure for acceptednames
#----------------------------
CREATE TABLE `acceptednames` (
  `ID` varchar(255) PRIMARY KEY,
  `Genus` varchar(255) DEFAULT NULL, 
  `Species` varchar(255) DEFAULT NULL,
  `AuthorString` varchar(255) DEFAULT NULL,
  `InfraSpecies` varchar(255) DEFAULT NULL,
  `InfraSpMarker` varchar(255) DEFAULT NULL,
  `InfraSpecificAuthorString` varchar(255) DEFAULT NULL,
  `GSDNameStatus` varchar(255) DEFAULT NULL, 
  `Sp2000NameStatus` varchar(255) DEFAULT NULL,  
  `Distribution` varchar(255) DEFAULT NULL
  ) DEFAULT CHARSET=utf8;

  LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__acceptednames.txt' INTO TABLE `acceptednames` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`ID`, `Genus`, `Species`, `AuthorString`, `InfraSpecies`, `InfraSpMarker`, `InfraSpecificAuthorString`, `GSDNameStatus`, `Sp2000NameStatus`,`Distribution`);

CREATE INDEX Genus ON acceptednames (Genus);
CREATE INDEX Species ON acceptednames (Species);

#----------------------------
# Table structure for taxa
#----------------------------
CREATE TABLE `taxa` (
ID integer(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TaxonIdentifier` varchar(255) DEFAULT NULL,
  `ChildrenID` varchar(255) DEFAULT NULL, 
  `Rank` varchar(255) DEFAULT NULL,
  `TaxonName` varchar(255) DEFAULT NULL,
  `InfraspecificGenus` varchar(255) DEFAULT NULL,
  `InfraspecificEpithet` varchar(255) DEFAULT NULL,
  `Authority` varchar(255) DEFAULT NULL
  ) DEFAULT CHARSET=utf8;


  LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__taxa.txt' INTO TABLE `taxa` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`TaxonIdentifier`,`ChildrenID`,`Rank`,`TaxonName`,`InfraspecificGenus`,`InfraspecificEpithet`,`Authority`);

CREATE INDEX TaxonIdentifier ON taxa (TaxonIdentifier);
CREATE INDEX ChildrenID ON taxa (ChildrenID);
CREATE INDEX Rank ON taxa (Rank);

#----------------------------
# Table structure for reference
#----------------------------
CREATE TABLE `reference` (
  `Identifier` varchar(255) PRIMARY KEY,
  `Author` varchar(255) DEFAULT NULL,
  `Year` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Details` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__references.txt' INTO TABLE `reference` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`Identifier`, `Author`, `Year`, `Title`, `Details`); 


#----------------------------
# Table structure for synonyms
#----------------------------
CREATE TABLE `synonyms` (
  `AcceptedNameID` varchar(255) DEFAULT NULL,
  `Genus` varchar(255) DEFAULT NULL,
  `SpeciesEpithet` varchar(255) DEFAULT NULL,
  `AuthorString` varchar(255) DEFAULT NULL,
  `GSDNameStatus` varchar(255) DEFAULT NULL,
  `Sp2000NameStatus` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__synonyms.txt' INTO TABLE `synonyms` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES (`AcceptedNameID`,`Genus`,`SpeciesEpithet`,`AuthorString`,`GSDNameStatus`,`Sp2000NameStatus`); 


#----------------------------
# Table structure for sourcedatabase
#----------------------------
CREATE TABLE `sourcedatabase` (
  `DatabaseShortName` varchar(255) DEFAULT NULL,
  `DatabaseFullName` varchar(255) DEFAULT NULL,
  `DatabaseVersion` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(255) DEFAULT NULL,
  `HomeURL` varchar(255) DEFAULT NULL,
  `SearchURL` varchar(255) DEFAULT NULL,
  `LogoURL` varchar(255) DEFAULT NULL,
  `StandardAbstract` longtext DEFAULT NULL,
  `Custodian` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__gsdinfo.txt' INTO TABLE `sourcedatabase` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`DatabaseShortName`,`DatabaseFullName`,`DatabaseVersion`,`ReleaseDate`,`HomeURL`,`SearchURL`,`LogoURL`,`StandardAbstract`,`Custodian`);


#----------------------------
# Table structure for commonnames
#----------------------------
CREATE TABLE `commonnames` (
  `Identifier` varchar(255) PRIMARY KEY,
  `CommonName` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `Language` varchar(255) DEFAULT NULL,
`Reftype` varchar(255) DEFAULT NULL,
`Author` varchar(255) DEFAULT NULL,
`Year` integer(4),
`Title` varchar(255) DEFAULT NULL,
`Details` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;


LOAD DATA LOCAL INFILE '/var/www/exposed/The_Reptile_Database__Reptilia_class__commonnames.txt' INTO TABLE `commonnames` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'  LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`Identifier`,`CommonName`,`Country`,`Language`,`Reftype`,`Author`,`Year`,`Title`,`Details`);


#----------------------------
# Table structure for nameids
#----------------------------
CREATE TABLE `nameids` (
  `newID` integer(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `oldID` varchar(255) NOT NULL
  ) DEFAULT CHARSET=utf8;

INSERT INTO nameids SELECT NULL, `ID` FROM `acceptednames`;
CREATE INDEX oldID ON nameids (oldID);
#----------------------------
# Table structure for taxa_denormalized
#----------------------------
CREATE TABLE `taxa_denormalized` (
  `ID` integer(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
   `kingdom` varchar(45),
   `phylum` varchar(45),
   `class` varchar(45),
   `order` varchar(45),
   `family` varchar(45),
   `genus` varchar(45),
   `familyID` varchar(45),
   `speciesID` varchar(45),
   `infraspeciesID` varchar(45)
  ) DEFAULT CHARSET=utf8;


INSERT INTO `taxa_denormalized` 
SELECT DISTINCT NULL AS `ID`,
 tx1.TaxonName AS `kingdom`, 
tx2.TaxonName AS `phylum`, 
tx3.TaxonName AS `class`, 
tx4.TaxonName AS `order`, 
tx5.TaxonName AS `family`, 
tx5.TaxonIdentifier AS `familyID`, 
tx6.TaxonName AS `genus`,  
tx7.TaxonIdentifier AS `speciesID`, 
tx8.TaxonIdentifier AS `infraspeciesID` 
FROM taxa tx1 
LEFT JOIN taxa tx2 ON tx2.TaxonIdentifier = tx1.ChildrenID
LEFT JOIN taxa tx3 ON tx3.TaxonIdentifier = tx2.ChildrenID
LEFT JOIN taxa tx4 ON tx4.TaxonIdentifier = tx3.ChildrenID
LEFT JOIN taxa tx5 ON tx5.TaxonIdentifier = tx4.ChildrenID
LEFT JOIN taxa tx6 ON tx6.TaxonIdentifier = tx5.ChildrenID
LEFT JOIN taxa tx7 ON tx7.TaxonIdentifier = tx6.ChildrenID
LEFT JOIN taxa tx8 ON tx8.TaxonIdentifier = tx7.ChildrenID
WHERE tx1.`Rank` = 'kingdom';