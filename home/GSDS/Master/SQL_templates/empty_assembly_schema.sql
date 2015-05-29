SET foreign_key_checks = 0;

TRUNCATE TABLE  `databases`;

TRUNCATE TABLE  `families`;

TRUNCATE TABLE  `scientific_names`;

TRUNCATE TABLE  `common_names` ;

TRUNCATE TABLE  `distribution`;

TRUNCATE TABLE  `lifezone`;

TRUNCATE TABLE  `scientific_name_references`;


TRUNCATE TABLE  `references`;

TRUNCATE TABLE  `specialists` ;


#tables below are usually created by Jorit's optimiser
TRUNCATE TABLE  `taxa` ;

TRUNCATE TABLE  `hard_coded_species_totals`;

TRUNCATE TABLE  `hard_coded_taxon_lists`;

TRUNCATE TABLE  `simple_search`; 

SET foreign_key_checks = 1;
