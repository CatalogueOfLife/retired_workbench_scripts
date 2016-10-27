#----------------------------
# Table structure for AcceptedInfraSpecificTaxa
#----------------------------
CREATE TABLE `AcceptedInfraSpecificTaxa` (
`AcceptedTaxonID` varchar(50) PRIMARY KEY,
`ParentSpeciesID` varchar(50) default NULL,
`InfraSpeciesEpithet` varchar(50) default NULL,
`InfraSpecificAuthorString` varchar(50) default NULL,
`InfraSpecificMarker` varchar(10) default NULL,
`GSDNameStatus` varchar(50) default NULL,
`Sp2000NameStatus` varchar(50) default NULL,
`IsFossil` tinyint(1) default NULL,
`LifeZone` varchar(50) default NULL,
`AdditionalData` varchar(255) default NULL,
`LTSSpecialist` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`LTSDate` varchar(50) default NULL,
`InfraSpeciesURL` varchar(255) default NULL,
`GSDTaxonGUI` varchar(255) default NULL,
`GSDNameGUI`  varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for AcceptedSpecies
#----------------------------
CREATE TABLE `AcceptedSpecies` (
`AcceptedTaxonID` varchar(50) PRIMARY KEY,
`Kingdom` varchar(50) default NULL,
`Phylum` varchar(50) default NULL,
`Class` varchar(50) default NULL,
`Order` varchar(50) default NULL,
`Superfamily` varchar(50) default NULL,
`Family` varchar(50) default NULL,
`Genus` varchar(50) default NULL,
`SubGenusName` varchar(50) default NULL,
`Species` varchar(50) default NULL,
`AuthorString` varchar(50)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`GSDNameStatus` varchar(50) default NULL,
`Sp2000NameStatus` varchar(50) default NULL,
`IsFossil` tinyint(1) default NULL,
`LifeZone` varchar(50) default NULL,
`AdditionalData` varchar(255) default NULL,
`LTSSpecialist` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`LTSDate` varchar(50) default NULL,
`SpeciesURL` varchar(255) default NULL,
`GSDTaxonGUI` varchar(255) default NULL,
`GSDNameGUI` varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for CommonNames
#----------------------------
CREATE TABLE `CommonNames` (
`record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`AcceptedTaxonID` varchar(50) NOT NULL,
`CommonName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`Transliteration` varchar(255) default NULL,
`Language` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`Country`  varchar(255) default NULL,
`Area`  varchar(255) default NULL,
`ReferenceID` varchar(50) default NULL,
PRIMARY KEY (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci;

#----------------------------
# Table structure for Distribution
#----------------------------
CREATE TABLE `Distribution` (
`record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`AcceptedTaxonID` varchar(50) NOT NULL,
`Distribution` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`StandardInUse` varchar(50) default NULL,
`DistributionStatus` varchar(50) default NULL,
PRIMARY KEY (`record_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci;


#----------------------------
# Table structure for References
#----------------------------
CREATE TABLE `References` (
`ReferenceID` varchar(50) PRIMARY KEY,
`Authors` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`Year` varchar(255) default NULL,
`Title` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`Details` varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#----------------------------
# Table structure for NameReferencesLinks
#----------------------------
CREATE TABLE `NameReferencesLinks` (
`ID` integer(10) PRIMARY KEY,
`ReferenceType` varchar(50) default NULL,
`ReferenceID` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for SourceDatabase
#----------------------------
CREATE TABLE `SourceDatabase` (
`record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`DatabaseFullName` varchar(255) NOT NULL,
`DatabaseShortName` varchar(50) NOT NULL,
`DatabaseVersion` varchar(50) NOT NULL,
`ReleaseDate` varchar(50) NOT NULL,
`AuthorsEditors` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`TaxonomicCoverage` varchar(255) NOT NULL,
`GroupNameInEnglish` varchar(255) NOT NULL,
`Abstract` text  CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
`Organisation` varchar(255) NOT NULL,
`HomeURL` varchar(255) default NULL,
`Coverage` varchar(50) default NULL,
`Completeness` integer(3) default NULL,
`Confidence` integer(1) default NULL,
`LogoFileName`  varchar(255) default NULL,
`ContactPerson` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
PRIMARY KEY (`record_id`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for Synonyms
#----------------------------
CREATE TABLE `Synonyms` (
`ID` integer(10) PRIMARY KEY,
`AcceptedTaxonID` varchar(50) NOT NULL,
`Genus` varchar(50) NOT NULL,
`SubGenusName` varchar(50) default NULL,
`Species` varchar(50) NOT NULL,
`AuthorString` varchar(50)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`InfraSpecies` varchar(50) default NULL,
`InfraSpecificMarker` varchar(50) default NULL,
`InfraSpecificAuthorString`  varchar(50)  CHARACTER SET utf8 COLLATE utf8_general_ci default NULL,
`GSDNameStatus` varchar(50) default NULL,
`Sp2000NameStatus` varchar(50) default NULL,
`GSDNameGUI` varchar(255) default NULL 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE 'AcceptedInfraSpecificTaxa.csv' INTO TABLE `AcceptedInfraSpecificTaxa` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES 
(`AcceptedTaxonID`, `ParentSpeciesID`, `InfraSpeciesEpithet`, `InfraSpecificAuthorString`, @dummy, `InfraSpecificMarker`, `GSDNameStatus`, `Sp2000NameStatus`, `IsFossil`, `LifeZone`, `AdditionalData`, `LTSSpecialist`, `LTSDate`, `InfraSpeciesURL`, `GSDTaxonGUI`, `GSDNameGUI`, @dummy);


LOAD DATA LOCAL INFILE 'AcceptedSpecies.csv' INTO TABLE `AcceptedSpecies` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'  IGNORE 1 LINES
(`AcceptedTaxonID`, `Kingdom`, `Phylum`, `Class`, `Order`, `Superfamily`, `Family`, `Genus`, `SubGenusName`, `Species`, `AuthorString`, `GSDNameStatus`, `Sp2000NameStatus`, `IsFossil`, `LifeZone`, `AdditionalData`, `LTSSpecialist`, `LTSDate`, `SpeciesURL`, `GSDTaxonGUI`, `GSDNameGUI`);

LOAD DATA LOCAL INFILE 'CommonNames.csv' INTO TABLE `CommonNames` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'  IGNORE 1 LINES
(`AcceptedTaxonID`, `CommonName`, `Transliteration`, `Country`, `Area`, `Language`, `ReferenceID`);

LOAD DATA LOCAL INFILE 'Distribution.csv' INTO TABLE `Distribution` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'  IGNORE 1 LINES
(`AcceptedTaxonID`, `Distribution`, `StandardInUse`, `DistributionStatus`);

LOAD DATA LOCAL INFILE 'NameReferencesLinks.csv' INTO TABLE NameReferencesLinks CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(`ID`, `ReferenceType`, `ReferenceID`);

LOAD DATA LOCAL INFILE 'References.csv' INTO TABLE `References` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(`ReferenceID`, `Authors`, `Year`, `Title`, `Details`);

LOAD DATA LOCAL INFILE 'SourceDatabase.csv' INTO TABLE `SourceDatabase` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(`DatabaseFullName`, `DatabaseShortName`, `DatabaseVersion`, `ReleaseDate`, `AuthorsEditors`, `TaxonomicCoverage`, `GroupNameInEnglish`, `Abstract`, `Organisation`, `HomeURL`, `Coverage`, `Completeness`, `Confidence`, `LogoFileName`, `ContactPerson`);

LOAD DATA LOCAL INFILE 'Synonyms.csv' INTO TABLE `Synonyms` CHARACTER SET utf8  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(`ID`, `AcceptedTaxonID`, `Genus`, `SubGenusName`, `Species`, `AuthorString`, `InfraSpecies`, `InfraSpecificMarker`, `InfraSpecificAuthorString`, `GSDNameStatus`, `Sp2000NameStatus`, `GSDNameGUI`);
