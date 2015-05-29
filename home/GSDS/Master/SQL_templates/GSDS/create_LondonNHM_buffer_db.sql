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
`LTSSpecialist` varchar(255) default NULL,
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
`AuthorString` varchar(50) default NULL,
`GSDNameStatus` varchar(50) default NULL,
`Sp2000NameStatus` varchar(50) default NULL,
`IsFossil` tinyint(1) default NULL,
`LifeZone` varchar(50) default NULL,
`AdditionalData` varchar(255) default NULL,
`LTSSpecialist` varchar(255) default NULL,
`LTSDate` varchar(50) default NULL,
`SpeciesURL` varchar(255) default NULL,
`GSDTaxonGUI` varchar(255) default NULL,
`GSDNameGUI` varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


#----------------------------
# Table structure for SourceDatabase
#----------------------------
CREATE TABLE `SourceDatabase` (
`record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`DatabaseFullName` varchar(255) NOT NULL,
`DatabaseShortName` varchar(50) NOT NULL,
`DatabaseVersion` varchar(5) NOT NULL,
`ReleaseDate` varchar(50) NOT NULL,
`AuthorsEditors` varchar(255) NOT NULL,
`TaxonomicCoverage` varchar(255) NOT NULL,
`GroupNameInEnglish` varchar(255) NOT NULL,
`Abstract` text NOT NULL,
`Organisation` varchar(255) NOT NULL,
`HomeURL` varchar(255) default NULL,
`Coverage` varchar(50) default NULL,
`Completeness` integer(3) default NULL,
`Confidence` integer(1) default NULL,
`LogoFileName`  varchar(255) default NULL,
`ContactPerson` varchar(255) NOT NULL,
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
`AuthorString` varchar(50) default NULL,
`InfraSpecies` varchar(50) default NULL,
`InfraSpecificMarker` varchar(50) default NULL,
`InfraSpecificAuthorString`  varchar(50) default NULL,
`GSDNameStatus` varchar(50) default NULL,
`Sp2000NameStatus` varchar(50) default NULL,
`GSDNameGUI` varchar(255) default NULL 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOAD DATA LOCAL INFILE 'extracted/AcceptedInfraSpecificTaxa.csv' INTO TABLE `AcceptedInfraSpecificTaxa` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES 
(`AcceptedTaxonID`, `ParentSpeciesID`, `InfraSpeciesEpithet`, `InfraSpecificAuthorString`,  `InfraSpecificMarker`, `GSDNameStatus`,  `Sp2000NameStatus`, `IsFossil`, `LifeZone`, `AdditionalData`, `LTSSpecialist`, `LTSDate`, `InfraSpeciesURL`, `GSDTaxonGUI`, `GSDNameGUI`); 

LOAD DATA LOCAL INFILE 'extracted/AcceptedSpecies.csv' INTO TABLE `AcceptedSpecies` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 LINES
(`AcceptedTaxonID`, `Kingdom`, `Phylum`, `Class`, `Order`, `Superfamily`, `Family`, `Genus`, `SubGenusName`, `Species`, `AuthorString`, `GSDNameStatus`, `Sp2000NameStatus`, `IsFossil`, `LifeZone`, `AdditionalData`, `LTSSpecialist`, `LTSDate`, `SpeciesURL`, `GSDTaxonGUI`, `GSDNameGUI`);

LOAD DATA LOCAL INFILE 'extracted/SourceDatabase.csv' INTO TABLE `SourceDatabase` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'  LINES TERMINATED BY '\n' IGNORE 1 LINES
(`DatabaseFullName`, `DatabaseShortName`, `DatabaseVersion`, `ReleaseDate`, `AuthorsEditors`, `TaxonomicCoverage`, `GroupNameInEnglish`, `Abstract`, `Organisation`, `HomeURL`, `Coverage`, `Completeness`, `Confidence`, `LogoFileName`, `ContactPerson`);


LOAD DATA LOCAL INFILE 'extracted/Synonyms.csv' INTO TABLE `Synonyms` CHARACTER SET utf8 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES
(`ID`, `AcceptedTaxonID`, `Genus`, `SubGenusName`, `Species`, `AuthorString`, `InfraSpecies`, `InfraSpecificMarker`, `InfraSpecificAuthorString`, `GSDNameStatus`, `Sp2000NameStatus`, `GSDNameGUI`);

show tables;