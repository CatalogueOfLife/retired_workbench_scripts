DROP TABLE IF EXISTS AcceptedNames;
CREATE TABLE AcceptedNames
(`ID` VARCHAR(15) NOT NULL,
`Genus` VARCHAR(100),
`Species` VARCHAR(100),
`AuthorString` VARCHAR(100),
`InfraSpecies` VARCHAR(100),
`InfraSpMarker` VARCHAR(8),
`InfraSpecificAuthorString` VARCHAR(100),
`GSDNameStatus` VARCHAR(45),
`Sp2000NameStatus` VARCHAR(45),
`Distribution` VARCHAR(255),
PRIMARY KEY (`ID`))
ENGINE=MyISAM CHARSET=utf8;


DROP TABLE IF EXISTS `References`;
CREATE TABLE `References`
(`ReferenceID` VARCHAR(15) NOT NULL,
`Author` VARCHAR(100),
`Year` INTEGER(4),
`Title` VARCHAR(500),
`Details` VARCHAR(500), 
PRIMARY KEY (`ReferenceID`))
ENGINE=MyISAM CHARSET=utf8;

DROP TABLE IF EXISTS `SourceDatabase`;
CREATE TABLE `SourceDatabase` 
 (#`ID` INTEGER NOT NULL,
`DatabaseShortName` VARCHAR(500),
`DatabaseFullName` VARCHAR(500),
`DatabaseVersion` VARCHAR(5),
`ReleaseDate` VARCHAR(25),
`HomeURL` VARCHAR(250),
`SearchURL` VARCHAR(250),
`LogoURL` VARCHAR(100),
`StandardAbstract` VARCHAR(500),
`Custodian` VARCHAR(500)
#PRIMARY KEY (ID)
)
ENGINE=MyISAM CHARSET=utf8; 


DROP TABLE IF EXISTS `Synonyms`;
CREATE TABLE `Synonyms` 
 (`AcceptedNameID` VARCHAR(15),
`Genus` VARCHAR(100),
`SpeciesEpithet` VARCHAR(100),
`AuthorString` VARCHAR(100),
`GSDNameStatus` VARCHAR(100),
`Sp2000NameStatus` VARCHAR(100),
PRIMARY KEY (`AcceptedNameID`))
ENGINE=MyISAM CHARSET=utf8;

DROP TABLE IF EXISTS `Taxa`;
CREATE TABLE `Taxa` 
 (`TaxonIdentifier` VARCHAR(15) NOT NULL,
`ChildrenID` VARCHAR(15),
`Rank` VARCHAR(15),
`TaxonName` VARCHAR(45),
`InfraspecificGenus` VARCHAR(45),
`InfraspecificEpithet` VARCHAR(45),
`Authority` VARCHAR(100),
PRIMARY KEY (`TaxonIdentifier`))
ENGINE=MyISAM CHARSET=utf8;


LOAD DATA LOCAL INFILE 'Zobodat__Vespoidea_superfamily__acceptednames.txt' INTO TABLE `AcceptedNames` FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'Zobodat__Vespoidea_superfamily__synonyms.txt' INTO TABLE `Synonyms` FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'Zobodat__Vespoidea_superfamily__gsdinfo.txt' INTO TABLE `SourceDatabase` FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'Zobodat__Vespoidea_superfamily__references.txt' INTO TABLE `References` FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'Zobodat__Vespoidea_superfamily__taxa.txt' INTO TABLE `Taxa` FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
