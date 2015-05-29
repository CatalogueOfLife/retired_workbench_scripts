SELECT DISTINCT
NULL as record_id,
NULL as lsid,
kingdom as name,
kingdom as name_with_italics,
"Kingdom" as taxon,
NULL as name_code,
0 as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families`
UNION
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
phylum as name,
phylum as name_with_italics,
"Phylum" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
phylum as child, 
kingdom as parent
FROM `families`) as f2 ON f2.child = f1.phylum
UNION
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
class as name,
class as name_with_italics,
"Class" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
class as child, 
phylum as parent
FROM `families`) as f2 ON f2.child = f1.class
UNION
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
`order` as name,
`order` as name_with_italics,
"Order" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
`order` as child, 
`class` as parent
FROM `families`) as f2 ON f2.child = f1.`order`
/* UNION 
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
`superfamily` as name,
`superfamily` as name_with_italics,
"Superfamily" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
`superfamily` as child, 
`order` as parent
FROM `families` WHERE `superfamily` IS NOT NULL AND `superfamily` !='') as f2 ON f2.child = f1.`superfamily`
 UNION
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
`family` as name,
`family` as name_with_italics,
"Family" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
`family` as child, 
`superfamily` as parent
FROM `families` WHERE `superfamily` IS NOT NULL AND `superfamily` !='') as f2 ON f2.child = f1.`family`
*/ UNION
SELECT DISTINCT
NULL as record_id,
NULL as lsid,
`family` as name,
`family` as name_with_italics,
"Family" as taxon,
NULL as name_code,
f2.parent as parent_id,
0 as sp2000_status_id,
database_id as database_id,
1 as is_accepted_name,
1 as is_species_or_nonsynonymic_higher_taxon 
FROM `families` f1 
LEFT JOIN (SELECT DISTINCT
`family` as child, 
`order` as parent
FROM `families`) as f2 ON f2.child = f1.`family`