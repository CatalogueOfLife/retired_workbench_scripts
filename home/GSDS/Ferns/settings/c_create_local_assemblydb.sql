/* assembly schema does not need to be modified for every GSD*/
/* however if assembly database structure needs to be updated for all gsds then follow the link below to change it */

source /home/GSDS/Master/SQL_templates/create_assembly_schema_myisam_with_triggers.sql


CREATE INDEX infraspecies_markers ON  scientific_names(infraspecies_marker);
CREATE INDEX authors ON  scientific_names(author);
CREATE INDEX accepted_name_codes ON  scientific_names(accepted_name_code);
CREATE INDEX family_codes_in_scientific_names ON  scientific_names(family_code); 
CREATE INDEX name_codes_in_distribution ON  distribution(name_code);
CREATE INDEX name_codes_in_lifezone ON  lifezone(name_code);
CREATE INDEX name_codes_in_scientific_name_references ON  scientific_name_references(name_code);
CREATE INDEX reference_codes_in_scientific_name_references ON  scientific_name_references(reference_code);
CREATE INDEX reference_codes_in_references ON  `references`(reference_code);
CREATE INDEX specialist_codes_in_scientific_names ON  scientific_names(specialist_code);