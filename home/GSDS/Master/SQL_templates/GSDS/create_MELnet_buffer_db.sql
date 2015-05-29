#----------------------------
# Table structure for acceptednames
#----------------------------
CREATE TABLE `acceptednames` (
  `ID` varchar(255) PRIMARY KEY,
  `Kingdom` varchar(255) DEFAULT NULL,
  `Phylum` varchar(255) DEFAULT NULL,
  `Class` varchar(255) DEFAULT NULL,
  `Order` varchar(255) DEFAULT NULL,
  `SuperFamiliyName` varchar(255) DEFAULT NULL,
  `Family` varchar(255) DEFAULT NULL,
  `Genus` varchar(255) DEFAULT NULL,
  `Species` varchar(255) DEFAULT NULL,
  `AuthorString` varchar(255) DEFAULT NULL,
  `InfraSpecies` varchar(255) DEFAULT NULL,
  `InfraSpMarker` varchar(255) DEFAULT NULL,
  `InfraSpecificAuthorString` varchar(255) DEFAULT NULL,
  `AdditionalData` varchar(255) DEFAULT NULL,
  `Sp2000NameStatus` varchar(255) DEFAULT NULL,
  `Specialist` varchar(255) DEFAULT NULL,
  `ScrutinyDate` varchar(255) DEFAULT NULL,
  `GSDNameStatus` varchar(255) DEFAULT NULL,
  `Distribution` varchar(255) DEFAULT NULL,
  `OccurrenceStatus` varchar(255) DEFAULT NULL,
  `SpeciesURL` varchar(255) DEFAULT NULL,
   `V` varchar(255) DEFAULT NULL
  ) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for commonnames
#----------------------------
CREATE TABLE `commonnames` (
  `ID` varchar(255) PRIMARY KEY,
  `CommonName` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `Language` varchar(255) DEFAULT NULL,
  `referenceID` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for reference
#----------------------------
CREATE TABLE `reference` (
  `referenceID` varchar(255) PRIMARY KEY,
  `Year` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Details` varchar(255) DEFAULT NULL,
  `Authors` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for scientificnamereference
#----------------------------
CREATE TABLE `scientificnamereference` (
  `ID` varchar(255) PRIMARY KEY,
  `referenceType` varchar(255) DEFAULT NULL,
  `referenceID` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for sourcedatabase
#----------------------------
CREATE TABLE `sourcedatabase` (
  `TaxonomicCoverage` longtext DEFAULT NULL,
  `DatabaseShortName` varchar(255) DEFAULT NULL,
  `DatabaseFullName` varchar(255) DEFAULT NULL,
  `DatabaseVersion` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(255) DEFAULT NULL,
  `HomeURL` varchar(255) DEFAULT NULL,
  `SearchURL` varchar(255) DEFAULT NULL,
  `LogoURL` varchar(255) DEFAULT NULL,
  `StandardAbstract` longtext DEFAULT NULL,
  `Custodian` varchar(255) DEFAULT NULL,
  `EditorsAuthors` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for synonyms
#----------------------------
CREATE TABLE `synonyms` (
  `ID` varchar(255) PRIMARY KEY,
  `AcceptedName_ID` varchar(255) DEFAULT NULL,
  `Genus` varchar(255) DEFAULT NULL,
  `Species` varchar(255) DEFAULT NULL,
  `AutorString` varchar(255) DEFAULT NULL,
  `InfraSpecies` varchar(255) DEFAULT NULL,
  `InfraSpMarker` varchar(255) DEFAULT NULL,
  `InfraSpecificAutorString` varchar(255) DEFAULT NULL,
  `Sp2000NameStatus` varchar(255) DEFAULT NULL,
  `GSDNameStatus` varchar(255) DEFAULT NULL,
  `K` varchar(255) DEFAULT NULL
) DEFAULT CHARSET=utf8;


LOAD DATA LOCAL INFILE 'AcceptedNames.csv' INTO TABLE `acceptednames` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`ID`, `Kingdom`, `Phylum`, `Class`,  `Order`, `SuperFamiliyName`,  `Family`, `Genus`, `Species`, `AuthorString`, `InfraSpecies`, `InfraSpMarker`, `InfraSpecificAuthorString`, `AdditionalData`,  `Sp2000NameStatus`,`Specialist`,`ScrutinyDate`,`GSDNameStatus`,`Distribution`,`SpeciesURL`); 

LOAD DATA LOCAL INFILE 'CommonNames.csv' INTO TABLE `commonnames` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'  LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`ID`, `CommonName`, `Country`, `Language`,  `referenceID`); 

LOAD DATA LOCAL INFILE 'Reference.csv' INTO TABLE `reference` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`referenceID`, `Year`, `Title`, `Details`,  `Authors`); 

LOAD DATA LOCAL INFILE 'ScientificNameReference.csv' INTO TABLE `scientificnamereference` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`ID`, `referenceType`, `referenceID`); 

LOAD DATA LOCAL INFILE 'SourceDatabase.csv' INTO TABLE `sourcedatabase` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`TaxonomicCoverage`, `DatabaseShortName`, `DatabaseFullName`,`DatabaseVersion`,`ReleaseDate`,`HomeURL`,`SearchURL`,`LogoURL`,`StandardAbstract`,`Custodian`,`EditorsAuthors`); 

LOAD DATA LOCAL INFILE 'Synonyms.csv' INTO TABLE `synonyms` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`ID`, `AcceptedName_ID`, `Genus`,`Species`,`AutorString`,`InfraSpecies`,`InfraSpMarker`,`InfraSpecificAutorString`,`Sp2000NameStatus`,`GSDNameStatus`); 