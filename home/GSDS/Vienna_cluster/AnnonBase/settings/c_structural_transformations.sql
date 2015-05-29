SET @dbid = 40;
SET @dbabbr = 'Ano-';
SET @dbtouse = 'Buffer_AnnonBase';


/*The part below is only required to fix table names temporarily so they can be used by same struct. transformation template*/
/*Need to contact Heimo and ask to exclude exp2000_Annonaceae from table names*/
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_AcceptedInfraSpecificTaxa TO Buffer_AnnonBase.`AcceptedInfraSpecificTaxa`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_AcceptedSpecies TO Buffer_AnnonBase.`AcceptedSpecies`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_CommonNames TO Buffer_AnnonBase.`CommonNames`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_Distribution TO Buffer_AnnonBase.`Distribution`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_NameReferencesLinks TO Buffer_AnnonBase.NameReferencesLinks;
RENAME TABLE Buffer_AnnonBase.`exp2000_Annonaceae_References` TO Buffer_AnnonBase.`References`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_SourceDatabase TO Buffer_AnnonBase.`SourceDatabase`;
RENAME TABLE Buffer_AnnonBase.exp2000_Annonaceae_Synonyms TO Buffer_AnnonBase.`Synonyms`;

/*POST IMPORT CORRECTIONS IN BUFFER*/
UPDATE Buffer_AnnonBase.`AcceptedSpecies` SET Sp2000NameStatus = "accepted name" WHERE Sp2000NameStatus = "accepted";

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_Vienna_structural_transformations.sql
