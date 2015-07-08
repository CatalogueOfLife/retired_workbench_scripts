SET @dbid = 108;
SET @dbabbr = 'W-Bch-';
SET @dbtouse = 'Buffer_Brachyura';

UPDATE `databases` SET `taxonomic_coverage`="Animalia - Arthropoda - Malacostraca - Decapoda - Infraorder Brachyura - Acidopsidae, Aethridae, Aphanodactylidae, Atelecyclidae, Belliidae, Bythograeidae, Calappidae, Camptandriidae, Cancridae, Carpiliidae, Chasmocarcinidae, Cheiragonidae, Conleyidae, Corystidae, Crossotonotidae, Cryptochiridae, Cyclodorippidae, Cymonomidae, Dacryopilumnidae, Dairidae, Dairoididae, Domeciidae, Dorippidae, Dotillidae, Dromiidae, Dynomenidae, Epialtidae, Eriphiidae, Ethusidae, Euryplacidae, Galenidae, Gecarcinidae, Gecarcinucidae, Geryonidae, Glyptograpsidae, Goneplacidae, Grapsidae, Heloeciidae, Hexapodidae, Homolidae, Homolodromiidae, Hymenosomatidae, Hypothalassiidae, Inachidae, Inachoididae, Iphiculidae, Latreilliidae, Leucosiidae, Litocheiridae, Macrophthalmidae, Majidae, Mathildellidae, Matutidae, Menippidae, Mictyridae, Ocypodidae, Oregoniidae, Orithyiidae, Oziidae, Palicidae, Panopeidae, Parthenopidae, Percnidae, Phyllotymolinidae, Pilumnidae, Pilumnoididae, Pinnotheridae, Pirimelidae, Plagusiidae, Planopilumnidae, Platyxanthidae, Polybiidae, Portunidae, Potamidae, Potamonautidae, Poupiniidae, Progeryonidae, Pseudorhombilidae, Pseudothelphusidae, Pseudoziidae, Raninidae, Retroplumidae, Scalopidiidae, Sesarmidae, Sotoplacidae, Tanaochelidae, Tetraliidae, Thiidae, Trapeziidae, Trichopeltariidae, Ucididae, Varunidae, Vultocinidae, Xanthidae, Xenograpsidae, Xenophthalmidae", `is_new` = 2, `taxa`="Crabs", `coverage`="Global", `completeness` = 100, `confidence` = 5;

source /home/GSDS/Master/SQL_templates/GSDS/ACEF3_WoRMS_structural_transformations.sql