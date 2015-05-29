DROP TRIGGER IF EXISTS trigpiping;
DELIMITER $$
CREATE TRIGGER trigpiping AFTER INSERT ON taxa
FOR EACH ROW BEGIN
IF new.phylum IN("MOLLUSCA","ARTHROPODA")
THEN
INSERT INTO pipe_ITIS.taxa
SET id = new.id,
taxonID = new.taxonID,
genus = new.genus,
specificEpithet = new.specificEpithet,
scientificNameAuthorship = new.scientificNameAuthorship,
infraspecificEpithet = new.infraspecificEpithet,
verbatimTaxonRank = new.verbatimTaxonRank,
taxonomicStatus = new.taxonomicStatus,
acceptedNameUsageID = new.acceptedNameUsageID,
parentNameUsageID = new.parentNameUsageID,
family = new.family,
`ordo` = new.`order`,
class = new.class,
phylum = new.phylum,
kingdom = new.kingdom,
higherClassification = new.higherClassification,
namePublishedIn = new.namePublishedIn,
taxonRemarks = new.taxonRemarks,
source = new.source,
updated = new.updated,
provider_id = new.provider_id,
gsd_comments = new.gsd_comments,
gsd_id = new.gsd_id,
gsd_status = new.gsd_status,
history_status = new.history_status,
history_comments = new.history_comments;
ELSEIF new.class IN("ACTINOPTERYGII")
THEN
INSERT INTO pipe_fishbase.taxa
SET id = new.id,
taxonID = new.taxonID,
genus = new.genus,
specificEpithet = new.specificEpithet,
scientificNameAuthorship = new.scientificNameAuthorship,
infraspecificEpithet = new.infraspecificEpithet,
verbatimTaxonRank = new.verbatimTaxonRank,
taxonomicStatus = new.taxonomicStatus,
acceptedNameUsageID = new.acceptedNameUsageID,
parentNameUsageID = new.parentNameUsageID,
family = new.family,
`ordo` = new.`order`,
class = new.class,
phylum = new.phylum,
kingdom = new.kingdom,
higherClassification = new.higherClassification,
namePublishedIn = new.namePublishedIn,
taxonRemarks = new.taxonRemarks,
source = new.source,
updated = new.updated,
provider_id = new.provider_id,
gsd_comments = new.gsd_comments,
gsd_id = new.gsd_id,
gsd_status = new.gsd_status,
history_status = new.history_status,
history_comments = new.history_comments;

END IF;
END $$