SET @dbid = 117;
SET @dbabbr = 'Che-';
SET @dbtouse = 'Buffer_ChenoBase';


/*The part below is only required to fix table names temporarily so they can be used by same struct. transformation template*/
/*Need to contact Heimo and ask to exclude exp2000_Chenopodiaceae from table names*/
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_AcceptedInfraSpecificTaxa TO Buffer_ChenoBase.`AcceptedInfraSpecificTaxa`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_AcceptedSpecies TO Buffer_ChenoBase.`AcceptedSpecies`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_CommonNames TO Buffer_ChenoBase.`CommonNames`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_Distribution TO Buffer_ChenoBase.`Distribution`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_NameReferencesLinks TO Buffer_ChenoBase.NameReferencesLinks;
RENAME TABLE Buffer_ChenoBase.`exp2000_Chenopodiaceae_References` TO Buffer_ChenoBase.`References`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_SourceDatabase TO Buffer_ChenoBase.`SourceDatabase`;
RENAME TABLE Buffer_ChenoBase.exp2000_Chenopodiaceae_Synonyms TO Buffer_ChenoBase.`Synonyms`;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_Vienna_structural_transformations.sql

