DELETE FROM scientific_names WHERE species = 'yyy';

#delete Lacistemataceae from WP (keeping the IOPI version in the CoL). Deletion will be cascaded by triggers
DELETE FROM families WHERE family = "Lacistemataceae";
#now delete Geranium in Geraniaceae. Deletion will be cascaded by triggers
DELETE FROM scientific_names WHERE genus = "Geranium";

UPDATE scientific_names SET sp2000_status_id = 4 WHERE `author` LIKE "%comb. ined.%";

#Pteridophyllaceae -> Papaveraceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Papaveraceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Pteridophyllaceae%");
DELETE FROM families WHERE family LIKE "Pteridophyllaceae%";

#Parnassiaceae -> Celastraceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Celastraceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Parnassiaceae%");
DELETE FROM families WHERE family LIKE "Parnassiaceae%";

#Malesherbiaceae -> Passifloraceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Passifloraceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Malesherbiaceae%");
DELETE FROM families WHERE family LIKE "Malesherbiaceae%";

#Turneraceae -> Passifloraceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Passifloraceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Turneraceae%");
DELETE FROM families WHERE family LIKE "Turneraceae%";

#Hypseocharitaceae -> Geraniaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Geraniaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Hypseocharitaceae%");
DELETE FROM families WHERE family LIKE "Hypseocharitaceae%";

#Ledocarpaceae -> Vivianiaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Vivianiaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Ledocarpaceae%");
DELETE FROM families WHERE family LIKE "Ledocarpaceae%";

#01Nov13 Comandraceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Comandraceae%");
DELETE FROM families WHERE family LIKE "Comandraceae%";

#01Nov13 Thesiaceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Thesiaceae%");
DELETE FROM families WHERE family LIKE "Thesiaceae%";

#01Nov13 Cervantesiaceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Cervantesiaceae%");
DELETE FROM families WHERE family LIKE "Cervantesiaceae%";

#01Nov13 Nanodeaceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Nanodeaceae%");
DELETE FROM families WHERE family LIKE "Nanodeaceae%";

#01Nov13 Viscaceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Viscaceae%");
DELETE FROM families WHERE family LIKE "Viscaceae%";

#26Nov13 Rehmanniaceae -> Orobanchaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Orobanchaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Rehmanniaceae%");
DELETE FROM families WHERE family LIKE "Rehmanniaceae%";

#26Nov13 Pteleocarpaceae -> Gelsemiaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Gelsemiaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Pteleocarpaceae%");
DELETE FROM families WHERE family LIKE "Pteleocarpaceae%";

#01Jan2014 Morinaceae -> Caprifoliaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Caprifoliaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Morinaceae%");
DELETE FROM families WHERE family LIKE "Morinaceae%";

#Ixerbaceae -> Strasburgeriaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Strasburgeriaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Ixerbaceae%");
DELETE FROM families WHERE family LIKE "Ixerbaceae%";

#Valerianaceae -> Caprifoliaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Caprifoliaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Valerianaceae%");
DELETE FROM families WHERE family LIKE "Valerianaceae%";

#01Oct14 Amphorogynaceae -> Santalaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Santalaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Amphorogynaceae%");
DELETE FROM families WHERE family LIKE "Amphorogynaceae%";

#01Dec14 Medusagynaceae -> Ochnaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Ochnaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Medusagynaceae%");
DELETE FROM families WHERE family LIKE "Medusagynaceae%";

#Quiinaceae -> Ochnaceae
UPDATE scientific_names SET family_code = (SELECT family_code FROM families WHERE family = "Ochnaceae") WHERE family_code IN(SELECT family_code FROM families WHERE family LIKE "Quiinaceae%");
DELETE FROM families WHERE family LIKE "Quiinaceae%";


#Adjust names of a higher ranks
UPDATE families SET kingdom = "Plantae", phylum = "Tracheophyta", class = "Magnoliopsida";

UPDATE families SET `order`="Amborellales" WHERE family = "Amborellaceae";
UPDATE families SET `order`="Apiales" WHERE family = "Griseliniaceae";
UPDATE families SET `order`="Apiales" WHERE family = "Pennantiaceae";
UPDATE families SET `order`="Apiales" WHERE family = "Torricelliaceae";
UPDATE families SET `order`="Aquifoliales" WHERE family = "Phyllonomaceae";
UPDATE families SET `order`="Asterales" WHERE family = "Alseuosmiaceae";
UPDATE families SET `order`="Asterales" WHERE family = "Argophyllaceae";
UPDATE families SET `order`="Asterales" WHERE family = "Pentaphragmataceae";
UPDATE families SET `order`="Asterales" WHERE family = "Phellinaceae";
UPDATE families SET `order`="Austrobaileyales" WHERE family = "Austrobaileyaceae";
UPDATE families SET `order`="Austrobaileyales" WHERE family = "Trimeniaceae";
UPDATE families SET `order`="Berberidopsidales" WHERE family = "Aextoxicaceae";
UPDATE families SET `order`="Berberidopsidales" WHERE family = "Berberidopsidaceae";
UPDATE families SET `order`="Brassicales" WHERE family = "Bretschneideraceae";
UPDATE families SET `order`="Brassicales" WHERE family = "Emblingiaceae";
UPDATE families SET `order`="Brassicales" WHERE family = "Gyrostemonaceae";
UPDATE families SET `order`="Brassicales" WHERE family = "Pentadiplandraceae";
UPDATE families SET `order`="Brassicales" WHERE family = "Stixaceae";
UPDATE families SET `order`="Bruniales" WHERE family = "Bruniaceae";
UPDATE families SET `order`="Buxales" WHERE family = "Buxaceae";
UPDATE families SET `order`="Buxales" WHERE family = "Didymelaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Ancistrocladaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Asteropeiaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Barbeuiaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Basellaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Didiereaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Dioncophyllaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Drosophyllaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Frankeniaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Gisekiaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Lophiocarpaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Molluginaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Nyctaginaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Physenaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Phytolaccaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Plumbaginaceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Rhabdodendraceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Sarcobataceae";
UPDATE families SET `order`="Caryophyllales" WHERE family = "Stegnospermataceae";
UPDATE families SET `order`="Celastrales" WHERE family = "Celastraceae";
UPDATE families SET `order`="Celastrales" WHERE family = "Lepidobotryaceae";
UPDATE families SET `order`="Ceratophyllales" WHERE family = "Ceratophyllaceae";
UPDATE families SET `order`="Cornales" WHERE family = "Grubbiaceae";
UPDATE families SET `order`="Cornales" WHERE family = "Hydrostachyaceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Aphloiaceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Geissolomataceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Guamatelaceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Staphyleaceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Stachyuraceae";
UPDATE families SET `order`="Crossosomatales" WHERE family = "Strasburgeriaceae";
UPDATE families SET `order`="Cucurbitales" WHERE family = "Apodanthaceae";
UPDATE families SET `order`="Cucurbitales" WHERE family = "Coriariaceae";
UPDATE families SET `order`="Cucurbitales" WHERE family = "Corynocarpaceae";
UPDATE families SET `order`="Cucurbitales" WHERE family = "Cucurbitaceae";
UPDATE families SET `order`="Dilleniales" WHERE family = "Dilleniaceae";
UPDATE families SET `order`="Ericales" WHERE family = "Roridulaceae";
UPDATE families SET `order`="Ericales" WHERE family = "Tetrameristaceae";
UPDATE families SET `order`="Fabales" WHERE family = "Polygalaceae";
UPDATE families SET `order`="Fabales" WHERE family = "Quillajaceae";
UPDATE families SET `order`="Fabales" WHERE family = "Surianaceae";
UPDATE families SET `order`="Fagales" WHERE family = "Juglandaceae";
UPDATE families SET `order`="Fagales" WHERE family = "Myricaceae";
UPDATE families SET `order`="Garryales" WHERE family = "Metteniusaceae";
UPDATE families SET `order`="Garryales" WHERE family = "Oncothecaceae";
UPDATE families SET `order`="Geraniales" WHERE family = "Geraniaceae";
UPDATE families SET `order`="Geraniales" WHERE family = "Melianthaceae";
UPDATE families SET `order`="Gunnerales" WHERE family = "Gunneraceae";
UPDATE families SET `order`="Gunnerales" WHERE family = "Myrothamnaceae";
UPDATE families SET `order`="Huerteales" WHERE family = "Dipentodontaceae";
UPDATE families SET `order`="Huerteales" WHERE family = "Tapisciaceae";
UPDATE families SET `order`="Lamiales" WHERE family = "Carlemanniaceae";
UPDATE families SET `order`="Lamiales" WHERE family = "Mazaceae";
UPDATE families SET `order`="Lamiales" WHERE family = "Peltantheraceae";
UPDATE families SET `order`="Lamiales" WHERE family = "Thomandersiaceae";
UPDATE families SET `order`="Laurales" WHERE family = "Atherospermataceae";
UPDATE families SET `order`="Laurales" WHERE family = "Siparunaceae";
UPDATE families SET `order`="Magnoliales" WHERE family = "Degeneriaceae";
UPDATE families SET `order`="Magnoliales" WHERE family = "Eupomatiaceae";
UPDATE families SET `order`="Magnoliales" WHERE family = "Himantandraceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Achariaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Balanopaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Bonnetiaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Calophyllaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Clusiaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Ctenolophonaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Dichapetalaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Elatinaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Erythroxylaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Euphroniaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Goupiaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Humiriaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Hypericaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Ixonanthaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Linaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Malpighiaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Ochnaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Passifloraceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Podostemaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Rafflesiaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Rhizophoraceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Salicaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Trigoniaceae";
UPDATE families SET `order`="Malpighiales" WHERE family = "Violaceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Combretaceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Crypteroniaceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Lythraceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Onagraceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Penaeaceae";
UPDATE families SET `order`="Myrtales" WHERE family = "Vochysiaceae";
UPDATE families SET `order`="Nymphaeales" WHERE family = "Hydatellaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Brunelliaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Cephalotaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Connaraceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Cunoniaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Elaeocarpaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Huaceae";
UPDATE families SET `order`="Oxalidales" WHERE family = "Oxalidaceae";
UPDATE families SET `order`="Picramniales" WHERE family = "Picramniaceae";
UPDATE families SET `order`="Piperales" WHERE family = "Hydnoraceae";
UPDATE families SET `order`="Proteales" WHERE family = "Platanaceae";
UPDATE families SET `order`="Proteales" WHERE family = "Proteaceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Berberidaceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Circaeasteraceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Eupteleaceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Lardizabalaceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Menispermaceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Papaveraceae";
UPDATE families SET `order`="Ranunculales" WHERE family = "Ranunculaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Barbeyaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Cannabaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Dirachmaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Elaeagnaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Moraceae";
UPDATE families SET `order`="Rosales" WHERE family = "Rhamnaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Rosaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Ulmaceae";
UPDATE families SET `order`="Rosales" WHERE family = "Urticaceae";
UPDATE families SET `order`="Sabiales" WHERE family = "Sabiaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Anacardiaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Biebersteiniaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Burseraceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Kirkiaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Meliaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Nitrariaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Rutaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Sapindaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Simaroubaceae";
UPDATE families SET `order`="Sapindales" WHERE family = "Tetradiclidaceae"; 
UPDATE families SET `order`="Saxifragales" WHERE family = "Altingiaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Aphanopetalaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Cercidiphyllaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Crassulaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Cynomoriaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Daphniphyllaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Grossulariaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Haloragaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Hamamelidaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Iteaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Paeoniaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Peridiscaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Saxifragaceae";
UPDATE families SET `order`="Saxifragales" WHERE family = "Tetracarpaeaceae";
UPDATE families SET `order`="Solanales" WHERE family = "Solanaceae";
UPDATE families SET `order`="Trochodendrales" WHERE family = "Trochodendraceae";
UPDATE families SET `order`="Vahliales" WHERE family = "Vahliaceae";
UPDATE families SET `order`="Vitales" WHERE family = "Vitaceae";
UPDATE families SET `order`="Zygophyllales" WHERE family = "Krameriaceae";
UPDATE families SET `order`="Zygophyllales" WHERE family = "Zygophyllaceae";


UPDATE families SET hierarchy_code = CONCAT(`kingdom`,'-',`phylum`,'-',`class`,'-',`order`,'-',`family`);


/*The standard editorial checks and cleanup for all data-sets in assembly schema */
source /home/GSDS/Master/SQL_templates/standard_editorial_checks.sql 


/*The standard integrity checks and cleanup for all data-sets in assembly schema */
source /home/GSDS/Master/SQL_templates/assembly_database_integrity_checks.sql 

