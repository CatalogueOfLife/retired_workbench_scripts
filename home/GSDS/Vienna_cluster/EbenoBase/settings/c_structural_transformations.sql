SET @dbid = 116;
SET @dbabbr = 'Ebe-';
SET @dbtouse = 'Buffer_EbenoBase';


/*The part below is only required to fix table names temporarily so they can be used by same struct. transformation template*/
/*Need to contact Heimo and ask to exclude exp2000_Ebenaceae from table names*/
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_AcceptedInfraSpecificTaxa TO Buffer_EbenoBase.`AcceptedInfraSpecificTaxa`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_AcceptedSpecies TO Buffer_EbenoBase.`AcceptedSpecies`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_CommonNames TO Buffer_EbenoBase.`CommonNames`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_Distribution TO Buffer_EbenoBase.`Distribution`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_NameReferencesLinks TO Buffer_EbenoBase.NameReferencesLinks;
RENAME TABLE Buffer_EbenoBase.`exp2000_Ebenaceae_References` TO Buffer_EbenoBase.`References`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_SourceDatabase TO Buffer_EbenoBase.`SourceDatabase`;
RENAME TABLE Buffer_EbenoBase.exp2000_Ebenaceae_Synonyms TO Buffer_EbenoBase.`Synonyms`;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_Vienna_structural_transformations.sql
