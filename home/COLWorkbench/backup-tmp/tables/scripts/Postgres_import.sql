/**
 * catalogue-of-life-for-postgresql
 * @link http://code.google.com/p/catalogue-of-life-for-postgresql/
 * @license http://www.opensource.org/licenses/bsd-license.php New BSD License
 * @package catalogue-of-life-for-postgresql
 * @author Armand Turpel <geocontexter@gmail.com>
 * @version $Rev: 50 $ / $LastChangedDate: 2011-10-29 20:41:53 +0200 (sam., 29 oct. 2011) $ / $LastChangedBy: armand.turpel $
 */

/**
 *
 * Catalogue of Life script ver. 1.0.3 for postgresql(>=9.1)
 */

DROP SCHEMA IF EXISTS icol2011ac5Dec CASCADE;
CREATE SCHEMA icol2011ac5Dec;

------------------------------------------
--------- Install modules ----------------
------------------------------------------

CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

------------------------------------------
------ Install tables and functions ------
------------------------------------------

--
-- Table structure for table author_string
--

CREATE SEQUENCE icol2011ac5Dec.col_author_string_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.author_string
(
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_author_string_id_seq'::regclass),
  string character varying(255) NOT NULL,
  CONSTRAINT author_string_id PRIMARY KEY (id),
  CONSTRAINT author_string_string UNIQUE (string)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table common_name
--

CREATE SEQUENCE icol2011ac5Dec.col_common_name_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.common_name (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_common_name_id_seq'::regclass),
  taxon_id int NOT NULL,
  common_name_element_id int NOT NULL,
  language_iso char(3) DEFAULT NULL,
  country_iso char(3) DEFAULT NULL,
  CONSTRAINT common_name_id PRIMARY KEY (id),
  CONSTRAINT common_name_unique UNIQUE (taxon_id,common_name_element_id,language_iso,country_iso)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX common_name_taxon_id
  ON icol2011ac5Dec.common_name
  USING btree
  (taxon_id);

CREATE INDEX common_name_taxon_common_name_element_id
  ON icol2011ac5Dec.common_name
  USING btree
  (common_name_element_id);

CREATE INDEX common_name_language_iso
  ON icol2011ac5Dec.common_name
  USING btree
  (language_iso);

CREATE INDEX common_name_country_iso
  ON icol2011ac5Dec.common_name
  USING btree
  (country_iso);

--
-- Table structure for table common_name_element
--

CREATE SEQUENCE icol2011ac5Dec.col_common_name_element_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.common_name_element (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_common_name_element_id_seq'::regclass),
  name varchar(255) NOT NULL,
  transliteration varchar(255) DEFAULT NULL,
  CONSTRAINT common_name_element_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table country
--

CREATE TABLE icol2011ac5Dec.country (
  iso char(3) NOT NULL,
  name varchar(100) NOT NULL,
  standard smallint NOT NULL DEFAULT 1,
  CONSTRAINT country_iso PRIMARY KEY (iso),
  CONSTRAINT country_name UNIQUE (name)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table distribution
--

CREATE TABLE icol2011ac5Dec.distribution (
  taxon_detail_id int NOT NULL,
  region_id smallint NOT NULL,
  distribution_status_id smallint DEFAULT NULL,
  CONSTRAINT distribution_taxon_detail_region_id PRIMARY KEY (taxon_detail_id,region_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX distribution_region_id
  ON icol2011ac5Dec.distribution
  USING btree
  (region_id);

CREATE INDEX distribution_region_distribution_status_id
  ON icol2011ac5Dec.distribution
  USING btree
  (distribution_status_id);

--
-- Table structure for table distribution_free_text
--

CREATE TABLE icol2011ac5Dec.distribution_free_text (
  taxon_detail_id int NOT NULL,
  region_free_text_id int NOT NULL,
  CONSTRAINT distribution_free_text_unique UNIQUE (taxon_detail_id,region_free_text_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX distribution_free_text_taxon_detail_id
  ON icol2011ac5Dec.distribution_free_text
  USING btree
  (taxon_detail_id);

CREATE INDEX distribution_free_text_region_free_text_id
  ON icol2011ac5Dec.distribution_free_text
  USING btree
  (region_free_text_id);

--
-- Table structure for table distribution_status
--

CREATE SEQUENCE icol2011ac5Dec.col_distribution_status_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.distribution_status (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_distribution_status_id_seq'::regclass),
  status varchar(100) NOT NULL,
  CONSTRAINT distribution_status_id PRIMARY KEY (id),
  CONSTRAINT distribution_status_status UNIQUE (status)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table habitat
--

CREATE SEQUENCE icol2011ac5Dec.col_habitat_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.habitat (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_habitat_id_seq'::regclass),
  habitat_standard_id smallint NOT NULL,
  original_code varchar(25) NOT NULL,
  name varchar(255) NOT NULL,
  CONSTRAINT habitat_id PRIMARY KEY (id),
  CONSTRAINT habitat_unique UNIQUE (habitat_standard_id,original_code,name)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX habitat_habitat_standard_id
  ON icol2011ac5Dec.habitat
  USING btree
  (habitat_standard_id);

CREATE INDEX habitat_original_code
  ON icol2011ac5Dec.habitat
  USING btree
  (original_code);

CREATE INDEX habitat_name
  ON icol2011ac5Dec.habitat
  USING btree
  (name);

--
-- Table structure for table habitat_standard
--

CREATE SEQUENCE icol2011ac5Dec.col_habitat_standard_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.habitat_standard (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_habitat_standard_id_seq'::regclass),
  standard varchar(50) NOT NULL,
  version varchar(10) DEFAULT NULL,
  CONSTRAINT habitat_standard_id PRIMARY KEY (id),
  CONSTRAINT habitat_standard_standard UNIQUE (standard)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table habitat_to_taxon_detail
--

CREATE TABLE icol2011ac5Dec.habitat_to_taxon_detail (
  habitat_id smallint NOT NULL,
  taxon_detail_id int NOT NULL,
  CONSTRAINT habitat_to_taxon_detail_id PRIMARY KEY (habitat_id,taxon_detail_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX habitat_to_taxon_detail_taxon_detail_id
  ON icol2011ac5Dec.habitat_to_taxon_detail
  USING btree
  (taxon_detail_id);

--
-- Table structure for table hybrid
--

CREATE TABLE icol2011ac5Dec.hybrid (
  taxon_id int NOT NULL,
  parent_taxon_id int NOT NULL,
  CONSTRAINT hybrid_id PRIMARY KEY (taxon_id,parent_taxon_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX hybrid_parent_taxon_id
  ON icol2011ac5Dec.hybrid
  USING btree
  (parent_taxon_id);

--
-- Table structure for table language
--

CREATE TABLE icol2011ac5Dec.language (
  iso char(3) NOT NULL,
  name varchar(100) NOT NULL,
  standard smallint NOT NULL DEFAULT 1,
  CONSTRAINT language_iso PRIMARY KEY (iso)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX language_name
  ON icol2011ac5Dec.language
  USING btree
  (name);

--
-- Table structure for table reference
--

CREATE SEQUENCE icol2011ac5Dec.col_reference_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.reference (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_reference_id_seq'::regclass),
  authors varchar(255) DEFAULT NULL,
  year varchar(25) DEFAULT NULL,
  title varchar(1000) DEFAULT NULL,
  text text,
  uri_id int DEFAULT NULL,
  CONSTRAINT reference_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX reference_authors
  ON icol2011ac5Dec.reference
  USING btree
  (authors);

CREATE INDEX reference_year
  ON icol2011ac5Dec.reference
  USING btree
  (year);

CREATE INDEX reference_uri_id
  ON icol2011ac5Dec.reference
  USING btree
  (uri_id);

--
-- Table structure for table reference_to_common_name
--

CREATE TABLE icol2011ac5Dec.reference_to_common_name (
  reference_id int NOT NULL,
  common_name_id int NOT NULL,
  CONSTRAINT reference_to_common_name_id PRIMARY KEY (reference_id,common_name_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX reference_to_common_name_common_name_id
  ON icol2011ac5Dec.reference_to_common_name
  USING btree
  (common_name_id);

--
-- Table structure for table reference_to_synonym
--

CREATE TABLE icol2011ac5Dec.reference_to_synonym (
  reference_id int NOT NULL,
  synonym_id int NOT NULL,
  CONSTRAINT reference_to_synonym_id PRIMARY KEY (reference_id,synonym_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX reference_to_synonym_synonym_id
  ON icol2011ac5Dec.reference_to_synonym
  USING btree
  (synonym_id);

--
-- Table structure for table reference_to_taxon
--

CREATE TABLE icol2011ac5Dec.reference_to_taxon (
  reference_id int NOT NULL,
  taxon_id int NOT NULL,
  CONSTRAINT reference_to_taxon_id PRIMARY KEY (reference_id,taxon_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX reference_to_taxon_taxon_id
  ON icol2011ac5Dec.reference_to_taxon
  USING btree
  (taxon_id);

--
-- Table structure for table region
--

CREATE SEQUENCE icol2011ac5Dec.col_region_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.region (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_region_id_seq'::regclass),
  region_standard_id smallint NOT NULL,
  original_code varchar(25) NOT NULL,
  name varchar(255) NOT NULL,
  parent_id smallint DEFAULT NULL,
  CONSTRAINT region_id PRIMARY KEY (id),
  CONSTRAINT region_unique UNIQUE (region_standard_id,original_code,name)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX region_region_standard_id
  ON icol2011ac5Dec.region
  USING btree
  (region_standard_id);

CREATE INDEX region_original_code
  ON icol2011ac5Dec.region
  USING btree
  (original_code);

CREATE INDEX region_name
  ON icol2011ac5Dec.region
  USING btree
  (name);

CREATE INDEX region_parent_id
  ON icol2011ac5Dec.region
  USING btree
  (parent_id);

--
-- Table structure for table region_free_text
--

CREATE SEQUENCE icol2011ac5Dec.col_region_free_text_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.region_free_text (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_region_free_text_id_seq'::regclass),
  free_text varchar(12500) NOT NULL,
  CONSTRAINT region_free_text_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

/*
CREATE INDEX region_free_text_free_text
  ON icol2011ac5Dec.region_free_text
  USING btree
  (free_text);
*/
--
-- Table structure for table region_standard
--

CREATE SEQUENCE icol2011ac5Dec.col_region_standard_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.region_standard (
  id smallint NOT NULL DEFAULT nextval('icol2011ac5Dec.col_region_standard_id_seq'::regclass),
  standard varchar(50) NOT NULL,
  version varchar(10) DEFAULT NULL,
  CONSTRAINT region_standard_id PRIMARY KEY (id),
  CONSTRAINT region_standard_standard UNIQUE (standard)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table scientific_name_element
--

CREATE SEQUENCE icol2011ac5Dec.col_scientific_name_element_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.scientific_name_element (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_scientific_name_element_id_seq'::regclass),
  name_element varchar(100) NOT NULL,
  CONSTRAINT scientific_name_element_id PRIMARY KEY (id),
  CONSTRAINT scientific_name_element_name_element UNIQUE (name_element)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table scientific_name_status
--

CREATE SEQUENCE icol2011ac5Dec.col_scientific_name_status_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.scientific_name_status (
  id smallint NOT NULL DEFAULT nextval('icol2011ac5Dec.col_scientific_name_status_id_seq'::regclass),
  name_status varchar(50) NOT NULL,
  CONSTRAINT scientific_name_status_id PRIMARY KEY (id),
  CONSTRAINT scientific_name_status_name_status UNIQUE (name_status)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table scrutiny
--

CREATE SEQUENCE icol2011ac5Dec.col_scrutiny_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.scrutiny (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_scrutiny_id_seq'::regclass),
  scrutiny_date date DEFAULT NULL,
  original_scrutiny_date varchar(100) DEFAULT NULL,
  specialist_id int NOT NULL,
  CONSTRAINT scrutiny_id PRIMARY KEY (id),
  CONSTRAINT scrutiny_unique UNIQUE (scrutiny_date,specialist_id,original_scrutiny_date)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX scrutiny_scrutiny_date
  ON icol2011ac5Dec.scrutiny
  USING btree
  (scrutiny_date);

CREATE INDEX scrutiny_specialist_id
  ON icol2011ac5Dec.scrutiny
  USING btree
  (specialist_id);

--
-- Table structure for table source_database
--

CREATE SEQUENCE icol2011ac5Dec.col_source_database_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.source_database (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_source_database_id_seq'::regclass),
  name varchar(255) NOT NULL,
  abbreviated_name varchar(50) DEFAULT NULL,
  group_name_in_english varchar(255) DEFAULT NULL,
  authors_and_editors varchar(255) DEFAULT NULL,
  organisation varchar(255) DEFAULT NULL,
  contact_person varchar(255) DEFAULT NULL,
  version varchar(25) DEFAULT NULL,
  release_date date DEFAULT NULL,
  abstract text,
  CONSTRAINT source_database_id PRIMARY KEY (id),
  CONSTRAINT source_database_name UNIQUE (name,abbreviated_name)
)
WITH (
  OIDS=FALSE
);
/**/;

--
-- Table structure for table specialist
--

CREATE SEQUENCE icol2011ac5Dec.col_specialist_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.specialist (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_specialist_id_seq'::regclass),
  name varchar(100) NOT NULL,
  CONSTRAINT specialist_id PRIMARY KEY (id),
  CONSTRAINT specialist_name UNIQUE (name)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table synonym
--

CREATE SEQUENCE icol2011ac5Dec.col_synonym_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.synonym (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_synonym_id_seq'::regclass),
  taxon_id int NOT NULL,
  author_string_id int DEFAULT NULL,
  scientific_name_status_id smallint NOT NULL,
  original_id varchar(100) DEFAULT NULL,
  CONSTRAINT synonym_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX synonym_taxon_id
  ON icol2011ac5Dec.synonym
  USING btree
  (taxon_id);

CREATE INDEX synonym_author_string_id
  ON icol2011ac5Dec.synonym
  USING btree
  (author_string_id);

CREATE INDEX synonym_scientific_name_status_id
  ON icol2011ac5Dec.synonym
  USING btree
  (scientific_name_status_id);

--
-- Table structure for table synonym_name_element
--

CREATE TABLE icol2011ac5Dec.synonym_name_element (
  taxonomic_rank_id smallint NOT NULL,
  scientific_name_element_id int NOT NULL,
  synonym_id int NOT NULL,
  hybrid_order smallint DEFAULT NULL,
  CONSTRAINT synonym_name_element_unique UNIQUE (taxonomic_rank_id,synonym_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX synonym_name_element_taxonomic_rank_id
  ON icol2011ac5Dec.synonym_name_element
  USING btree
  (taxonomic_rank_id);

CREATE INDEX synonym_name_element_scientific_name_element_id
  ON icol2011ac5Dec.synonym_name_element
  USING btree
  (scientific_name_element_id);

CREATE INDEX synonym_name_element_synonym_id
  ON icol2011ac5Dec.synonym_name_element
  USING btree
  (synonym_id);

--
-- Table structure for table taxon
--

CREATE SEQUENCE icol2011ac5Dec.col_taxon_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.taxon (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_taxon_id_seq'::regclass),
  taxonomic_rank_id smallint NOT NULL,
  source_database_id int DEFAULT NULL,
  original_id varchar(100) DEFAULT NULL,
  CONSTRAINT taxon_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX taxon_taxonomic_rank_id
  ON icol2011ac5Dec.taxon
  USING btree
  (taxonomic_rank_id);

CREATE INDEX taxon_source_database_id
  ON icol2011ac5Dec.taxon
  USING btree
  (source_database_id);

--
-- Table structure for table taxon_detail
--

CREATE TABLE icol2011ac5Dec.taxon_detail (
  taxon_id int NOT NULL,
  author_string_id int DEFAULT NULL,
  scientific_name_status_id smallint NOT NULL,
  scrutiny_id int DEFAULT NULL,
  additional_data text,
  CONSTRAINT taxon_detail_taxon_id PRIMARY KEY (taxon_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX taxon_detail_author_string_id
  ON icol2011ac5Dec.taxon_detail
  USING btree
  (author_string_id);

CREATE INDEX taxon_detail_scientific_name_status_id
  ON icol2011ac5Dec.taxon_detail
  USING btree
  (scientific_name_status_id);

CREATE INDEX taxon_detail_scrutiny_id
  ON icol2011ac5Dec.taxon_detail
  USING btree
  (scrutiny_id);

--
-- Table structure for table taxon_name_element
--

CREATE TABLE icol2011ac5Dec.taxon_name_element (
  taxon_id int NOT NULL,
  scientific_name_element_id int NOT NULL,
  parent_id int DEFAULT NULL,
  CONSTRAINT taxon_name_element_taxon_id PRIMARY KEY (taxon_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX taxon_name_element_scientific_name_element_id
  ON icol2011ac5Dec.taxon_name_element
  USING btree
  (scientific_name_element_id);

CREATE INDEX taxon_name_element_parent_id
  ON icol2011ac5Dec.taxon_name_element
  USING btree
  (parent_id);

--
-- Table structure for table taxonomic_rank
--

CREATE SEQUENCE icol2011ac5Dec.col_taxonomic_rank_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.taxonomic_rank (
  id smallint NOT NULL DEFAULT nextval('icol2011ac5Dec.col_taxonomic_rank_id_seq'::regclass),
  rank varchar(50) NOT NULL,
  marker_displayed varchar(50) DEFAULT NULL,
  standard smallint NOT NULL DEFAULT '0',
  CONSTRAINT taxonomic_rank_id PRIMARY KEY (id),
  CONSTRAINT taxonomic_rank_rank UNIQUE (rank)
)
WITH (
  OIDS=FALSE
);

--
-- Table structure for table uri
--

CREATE SEQUENCE icol2011ac5Dec.col_uri_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


CREATE TABLE icol2011ac5Dec.uri (
  id int NOT NULL DEFAULT nextval('icol2011ac5Dec.col_uri_id_seq'::regclass),
  resource_identifier varchar(500) NOT NULL,
  description text,
  uri_scheme_id smallint NOT NULL,
  CONSTRAINT uri_id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX uri_resource_identifier
  ON icol2011ac5Dec.uri
  USING btree
  (resource_identifier);

CREATE INDEX uri_uri_scheme_id
  ON icol2011ac5Dec.uri
  USING btree
  (uri_scheme_id);

--
-- Table structure for table uri_scheme
--

CREATE SEQUENCE icol2011ac5Dec.col_uri_scheme_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE icol2011ac5Dec.uri_scheme (
  id smallint NOT NULL DEFAULT nextval('icol2011ac5Dec.col_uri_scheme_id_seq'::regclass),
  scheme varchar(25) NOT NULL,
  name varchar(255) NOT NULL,
  CONSTRAINT uri_scheme_id PRIMARY KEY (id),
  CONSTRAINT uri_scheme_unique UNIQUE (scheme,name)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX uri_scheme_scheme
  ON icol2011ac5Dec.uri_scheme
  USING btree
  (scheme);

--
-- Table structure for table uri_to_source_database
--

CREATE TABLE icol2011ac5Dec.uri_to_source_database (
  uri_id int NOT NULL,
  source_database_id int NOT NULL,
  CONSTRAINT uri_to_source_database_id PRIMARY KEY (uri_id,source_database_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX uri_to_source_database_source_database_id
  ON icol2011ac5Dec.uri_to_source_database
  USING btree
  (source_database_id);

--
-- Table structure for table uri_to_taxon
--

CREATE TABLE icol2011ac5Dec.uri_to_taxon (
  uri_id int NOT NULL,
  taxon_id int NOT NULL,
  CONSTRAINT uri_to_taxon_id PRIMARY KEY (uri_id,taxon_id)
)
WITH (
  OIDS=FALSE
);

CREATE INDEX uri_to_taxon_taxon_id
  ON icol2011ac5Dec.uri_to_taxon
  USING btree
  (taxon_id);

-- FUNCTIONS

-- get taxonomic branch of a given taxon_id

CREATE OR REPLACE FUNCTION icol2011ac5Dec.taxon_get_branch(IN taxon_id integer)
  RETURNS TABLE(taxon_id integer, scientific_name_element_id integer, parent_id integer, name_element text, rank text, source_database_id integer, level integer) AS
$BODY$

with recursive _taxon_get_branch(taxon_id, scientific_name_element_id, parent_id, name_element, rank, source_database_id, level) as (
  SELECT tne.taxon_id, tne.scientific_name_element_id, tne.parent_id, sne.name_element, tr.rank, t.source_database_id, 0  FROM icol2011ac5Dec.taxon_name_element tne
   INNER JOIN icol2011ac5Dec.scientific_name_element sne
   ON tne.scientific_name_element_id = sne.id
   INNER JOIN icol2011ac5Dec.taxon t
   ON tne.taxon_id = t.id
   INNER JOIN icol2011ac5Dec.taxonomic_rank tr
   ON t.taxonomic_rank_id = tr.id
    WHERE tne.taxon_id = $1
  union all
  SELECT tne.taxon_id, tne.scientific_name_element_id, tne.parent_id, sne.name_element, tr.rank, t.source_database_id, a.level+1 FROM _taxon_get_branch a
        INNER JOIN icol2011ac5Dec.taxon_name_element tne
        ON a.parent_id = tne.taxon_id
   INNER JOIN icol2011ac5Dec.scientific_name_element sne
   ON tne.scientific_name_element_id = sne.id
   INNER JOIN icol2011ac5Dec.taxon t
   ON tne.taxon_id = t.id
   INNER JOIN icol2011ac5Dec.taxonomic_rank tr
   ON t.taxonomic_rank_id = tr.id
)
SELECT taxon_id, scientific_name_element_id, parent_id, name_element, rank, source_database_id, level FROM _taxon_get_branch ORDER BY level desc;

$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;


/**
 * Update start value of each sequence
 *
 * USAGE:
   SELECT icol2011ac5Dec.reset_sequences();
 */
CREATE OR REPLACE FUNCTION icol2011ac5Dec.reset_sequences()
  RETURNS void AS
$BODY$
DECLARE

    _result       RECORD;
    _sequence     RECORD;
    _table        text := '';

BEGIN

    FOR _sequence IN

    SELECT relname AS seq_name
    FROM pg_class
    WHERE relkind = 'S'
    AND   relname LIKE 'col_%'
    AND relnamespace IN (
    SELECT oid
      FROM pg_namespace
     WHERE nspname NOT LIKE 'pg_%'
       AND nspname != 'information_schema'
    ) ORDER BY relname

    LOOP

        -- strip '_id_seq' and 'col_' from the sequence name to get the table name

    EXECUTE 'SELECT replace(' || quote_literal(_sequence.seq_name) || ',' || quote_literal('_id_seq') || ',' || quote_literal('') || ')' INTO _table;
    EXECUTE 'SELECT replace(' || quote_literal(_table) || ',' || quote_literal('col_') || ',' || quote_literal('') || ')' INTO _table;

        -- get the last id from table and update the start sequence value

    EXECUTE 'SELECT CAST(id AS bigint) FROM icol2011ac5Dec.' || _table || ' ORDER BY id DESC LIMIT 1' INTO _result;

    IF (_result.id IS NOT NULL) THEN
        RAISE NOTICE 'sequence (%) start at (%)', _sequence.seq_name, _result.id;
        EXECUTE 'ALTER SEQUENCE icol2011ac5Dec.' || _sequence.seq_name || ' RESTART WITH ' || _result.id + 1;
    END IF;
    END LOOP;

    RAISE NOTICE 'Reset sequences done';

END;

$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;


-- build taxon_cache table

CREATE OR REPLACE FUNCTION icol2011ac5Dec.build_taxon_cache()
  RETURNS boolean AS
$BODY$
DECLARE

    _taxon_name_element     RECORD;
    _taxon_branch           RECORD;
    _author_rec             RECORD;
    _status                 RECORD;
    _database               RECORD;

    _species_flag           boolean := false;
    _species_full_name      varchar(255);
    _taxon_cache_id         int;
    _species_region         text;

    _kingdom_id             int;
    _kingdom_name           varchar(255);
    _phylum_id              int;
    _phylum_name            varchar(255);
    _class_id               int;
    _class_name             varchar(255);
    _order_id               int;
    _order_name             varchar(255);
    _family_id              int;
    _family_name            varchar(255);
    _genus_id               int;
    _genus_name             varchar(255);
    _species_id             int;
    _species_name           varchar(255);
    _infraspecies_id        int;
    _infraspecies_name      varchar(255);
    _infraspecies_rank      varchar(255);
    _species_author_id      int;
    _species_author_name    varchar(255);


BEGIN

    DROP TABLE IF EXISTS icol2011ac5Dec.__taxon_cache;

    CREATE TABLE icol2011ac5Dec.__taxon_cache
    (
        id serial,
        t_taxon_id int,
        t_kingdom_scientific_name_element_id int,
        t_kingdom character varying(255),
        t_phylum_scientific_name_element_id int,
        t_phylum character varying(255),
        t_class_scientific_name_element_id int,
        t_class character varying(255),
        t_order_scientific_name_element_id int,
        t_order character varying(255),
        t_family_scientific_name_element_id int,
        t_family character varying(255),
        t_genus_scientific_name_element_id int,
        t_genus character varying(255),
        t_species_scientific_name_element_id int,
        t_species character varying(255),
        t_infraspecies_scientific_name_element_id int,
        t_infraspecies character varying(255),
        t_infraspecies_rank character varying(255),
        t_species_author_id int,
        t_species_author_name character varying(255),
        t_species_full_name character varying(255),
        t_scientific_name_status_id int,
        t_scientific_name_status character varying(255),
        t_synonym_of_id int,
        t_synonym_of character varying(255),
        t_region text,
        t_source_database_id int,
        t_source_database_name character varying(255),
        t_source_database_organisation character varying(255),
        CONSTRAINT taxon_cache_id PRIMARY KEY (id)
    )
    WITH (
      OIDS=FALSE
    );

    DROP INDEX IF EXISTS icol2011ac5Dec.i_t_family_scientific_name_element_id;

    CREATE INDEX i_t_family_scientific_name_element_id
      ON icol2011ac5Dec.__taxon_cache
      USING btree
      (t_family_scientific_name_element_id);

    DROP INDEX IF EXISTS icol2011ac5Dec.i_t_taxon_id;

    CREATE INDEX i_t_taxon_id
      ON icol2011ac5Dec.__taxon_cache
      USING btree
      (t_taxon_id);

    DROP INDEX IF EXISTS icol2011ac5Dec.i_t_source_database_id;

    CREATE INDEX i_t_source_database_id
      ON icol2011ac5Dec.__taxon_cache
      USING btree
      (t_source_database_id);

    DROP INDEX IF EXISTS icol2011ac5Dec.i_t_synonym_of_id;

    CREATE INDEX i_t_synonym_of_id
      ON icol2011ac5Dec.__taxon_cache
      USING btree
      (t_synonym_of_id);


    FOR _taxon_name_element IN

        SELECT * FROM icol2011ac5Dec.taxon_name_element  order by taxon_id desc

    LOOP

        _kingdom_id             := null;
        _kingdom_name           := null;
        _phylum_id              := null;
        _phylum_name            := null;
        _class_id               := null;
        _class_name             := null;
        _order_id               := null;
        _order_name             := null;
        _family_id              := null;
        _family_name            := null;
        _genus_id               := null;
        _genus_name             := null;
        _species_id             := null;
        _species_name           := null;
        _infraspecies_id        := null;
        _infraspecies_name      := null;
        _infraspecies_rank      := null;
        _species_author_id      := null;
        _species_author_name    := null;
        _species_full_name      := null;
        _species_flag           := false;

        FOR _taxon_branch IN

            SELECT * from icol2011ac5Dec.taxon_get_branch(_taxon_name_element.taxon_id)

        LOOP

            IF(_taxon_branch.rank = 'kingdom') THEN

                _kingdom_id   = _taxon_branch.scientific_name_element_id;
                _kingdom_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'phylum') THEN

                _phylum_id   = _taxon_branch.scientific_name_element_id;
                _phylum_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'class') THEN

                _class_id   = _taxon_branch.scientific_name_element_id;
                _class_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'order') THEN

                _order_id   = _taxon_branch.scientific_name_element_id;
                _order_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'family') THEN

                _family_id   = _taxon_branch.scientific_name_element_id;
                _family_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'genus') THEN

                _genus_id     = _taxon_branch.scientific_name_element_id;
                _genus_name   = _taxon_branch.name_element;

            END IF;

            IF(_species_flag = true) THEN

                _species_full_name   = _species_full_name || ' ' || _taxon_branch.name_element;
                _infraspecies_id     = _taxon_branch.scientific_name_element_id;
                _infraspecies_name   = _taxon_branch.name_element;
                _infraspecies_rank   = _taxon_branch.rank;

            END IF;

            IF(_taxon_branch.rank = 'species') THEN

                _species_id   = _taxon_branch.scientific_name_element_id;
                _species_name = _taxon_branch.name_element;

                -- get taxon author info
                SELECT INTO _author_rec a.* FROM icol2011ac5Dec.taxon_detail td
                    INNER JOIN icol2011ac5Dec.author_string a
                        ON a.id=td.author_string_id
                    WHERE td.taxon_id=_taxon_branch.taxon_id;

                _species_author_id   = _author_rec.id;
                _species_author_name = _author_rec.string;
                _species_flag        = true;
                _species_full_name   = initcap(_genus_name) || ' ' || _species_name;

                -- get taxon region info
                SELECT * INTO _species_region
                FROM array_to_string(array(SELECT region_name
                               FROM icol2011ac5Dec.v_taxon_distribution
                               WHERE taxon_detail_id = _taxon_branch.taxon_id
                               ),
                             ':');

                -- get taxon database info
                SELECT * INTO _database FROM icol2011ac5Dec.source_database WHERE id = _taxon_branch.source_database_id;

            END IF;

        END LOOP;

        _species_full_name   = _species_full_name || ' ' || _species_author_name;

        SELECT * INTO _status FROM icol2011ac5Dec.v_scientific_status WHERE taxon_id = _taxon_name_element.taxon_id;

        INSERT INTO icol2011ac5Dec.__taxon_cache (
            id,
            t_taxon_id,
            t_kingdom_scientific_name_element_id,t_kingdom,
            t_phylum_scientific_name_element_id,t_phylum,
            t_class_scientific_name_element_id,t_class,
            t_order_scientific_name_element_id,t_order,
            t_family_scientific_name_element_id,t_family,
            t_genus_scientific_name_element_id,t_genus,
            t_species_scientific_name_element_id,t_species,
            t_infraspecies_scientific_name_element_id,t_infraspecies,t_infraspecies_rank,
            t_species_author_id,t_species_author_name,
            t_species_full_name,
            t_scientific_name_status_id,
            t_scientific_name_status,
            t_synonym_of_id,
            t_synonym_of,
            t_region,
            t_source_database_id,
            t_source_database_name,
            t_source_database_organisation
            )

        VALUES (
            DEFAULT,
            _taxon_name_element.taxon_id,
            _kingdom_id,_kingdom_name,
            _phylum_id,_phylum_name,
            _class_id,_class_name,
            _order_id,_order_name,
            _family_id,_family_name,
            _genus_id,_genus_name,
            _species_id,_species_name,
            _infraspecies_id,_infraspecies_name,_infraspecies_rank,
            _species_author_id,_species_author_name,
            _species_full_name,
            _status.id,
            _status.name_status,
            null,
            null,
            _species_region,
            _database.id,
            _database.name,
            _database.organisation
            )RETURNING id INTO _taxon_cache_id;

            PERFORM icol2011ac5Dec.insert_synonyms(_taxon_cache_id, _taxon_name_element.taxon_id, _species_full_name, _species_region);

    END LOOP;

    PERFORM icol2011ac5Dec.build_normalized_table();

    RETURN true;

END;

$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;


-- get taxonomic branch of a synonym

-- currently not used, not reliable because not every synonym genus has higher taxonomy.
-- This is the case when the synonym genus is different from its accepted name

CREATE OR REPLACE FUNCTION icol2011ac5Dec.synonym_get_branch(IN scientific_name_element_id integer)
  RETURNS TABLE(taxon_id integer, scientific_name_element_id integer, parent_id integer, name_element text, rank text, source_database_id integer, level integer) AS
$BODY$

with recursive _taxon_get_branch(taxon_id, scientific_name_element_id, parent_id, name_element, rank, source_database_id, level) as (
  SELECT tne.taxon_id, tne.scientific_name_element_id, tne.parent_id, sne.name_element, tr.rank, t.source_database_id, 0  FROM icol2011ac5Dec.taxon_name_element tne
    INNER JOIN icol2011ac5Dec.scientific_name_element sne
    ON tne.scientific_name_element_id = sne.id
    INNER JOIN icol2011ac5Dec.taxon t
    ON tne.taxon_id = t.id
    INNER JOIN icol2011ac5Dec.taxonomic_rank tr
    ON t.taxonomic_rank_id = tr.id
     WHERE sne.id = $1
  union all
  SELECT tne.taxon_id, tne.scientific_name_element_id, tne.parent_id, sne.name_element, tr.rank, t.source_database_id, a.level+1 FROM _taxon_get_branch a
        INNER JOIN icol2011ac5Dec.taxon_name_element tne
        ON a.parent_id = tne.taxon_id
    INNER JOIN icol2011ac5Dec.scientific_name_element sne
    ON tne.scientific_name_element_id = sne.id
    INNER JOIN icol2011ac5Dec.taxon t
    ON tne.taxon_id = t.id
    INNER JOIN icol2011ac5Dec.taxonomic_rank tr
    ON t.taxonomic_rank_id = tr.id
)
SELECT taxon_id, scientific_name_element_id, parent_id, name_element, rank, source_database_id, level FROM _taxon_get_branch ORDER BY level desc;

$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;


-- insert synonyms of a given _taxon_cache_id
-- @param _taxon_cache_id integer accepted species id
-- @param _taxon_id       integer
-- @param _taxon_name     character varying accepted species name
-- @param _species_region text

CREATE OR REPLACE FUNCTION icol2011ac5Dec.insert_synonyms(_taxon_cache_id integer, _taxon_id integer, _taxon_name character varying, _species_region text)
  RETURNS void AS
$BODY$
DECLARE

    _taxon_branch   RECORD;
    _synonym        RECORD;
    _status         RECORD;
    _database       RECORD;

    _kingdom_id         int;
    _kingdom_name       varchar(255);
    _phylum_id          int;
    _phylum_name        varchar(255);
    _class_id           int;
    _class_name         varchar(255);
    _order_id           int;
    _order_name         varchar(255);
    _family_id          int;
    _family_name        varchar(255);

BEGIN

    FOR _synonym IN

        SELECT * FROM icol2011ac5Dec.v_taxon_synonym WHERE taxon_id = _taxon_id

    LOOP

    _kingdom_id             := null;
    _kingdom_name           := null;
    _phylum_id              := null;
    _phylum_name            := null;
    _class_id               := null;
    _class_name             := null;
    _order_id               := null;
    _order_name             := null;
    _family_id              := null;
    _family_name            := null;

        FOR _taxon_branch IN

        SELECT * FROM icol2011ac5Dec.taxon_get_branch(_taxon_id)

        LOOP

            IF(_taxon_branch.rank = 'kingdom') THEN

            _kingdom_id   = _taxon_branch.scientific_name_element_id;
            _kingdom_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'phylum') THEN

            _phylum_id   = _taxon_branch.scientific_name_element_id;
            _phylum_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'class') THEN

            _class_id   = _taxon_branch.scientific_name_element_id;
            _class_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'order') THEN

            _order_id   = _taxon_branch.scientific_name_element_id;
            _order_name = _taxon_branch.name_element;

            END IF;

            IF(_taxon_branch.rank = 'family') THEN

            _family_id   = _taxon_branch.scientific_name_element_id;
            _family_name = _taxon_branch.name_element;

            END IF;

        END LOOP;

        SELECT * INTO _status FROM icol2011ac5Dec.scientific_name_status WHERE id = _synonym.status;

        SELECT * INTO _database FROM icol2011ac5Dec.source_database WHERE id = _synonym.source_database_id;

        INSERT INTO icol2011ac5Dec.__taxon_cache (
            t_taxon_id,
            t_kingdom_scientific_name_element_id,t_kingdom,
            t_phylum_scientific_name_element_id,t_phylum,
            t_class_scientific_name_element_id,t_class,
            t_order_scientific_name_element_id,t_order,
            t_family_scientific_name_element_id,t_family,
            t_genus_scientific_name_element_id,t_genus,
            t_species_scientific_name_element_id,t_species,
            t_infraspecies_scientific_name_element_id,t_infraspecies,t_infraspecies_rank,
            t_species_author_id,t_species_author_name,
            t_species_full_name,
            t_scientific_name_status_id,
            t_scientific_name_status,
            t_synonym_of_id,
            t_synonym_of,
            t_region,
            t_source_database_id,
            t_source_database_name,
            t_source_database_organisation
            )

        VALUES (
            _taxon_id,
            _kingdom_id,_kingdom_name,
            _phylum_id,_phylum_name,
            _class_id,_class_name,
            _order_id,_order_name,
            _family_id,_family_name,
            _synonym.genus_id,_synonym.genus,
            _synonym.species_id,_synonym.species,
            _synonym.infraspecies_id,_synonym.infraspecies,_synonym.infraspecific_marker,
            null,_synonym.author,
            replace(initcap(_synonym.genus) || ' ' || _synonym.species || ' ' || COALESCE(_synonym.infraspecies,'') || ' ' || _synonym.author, '  ', ' '),
            _synonym.status,
            _status.name_status,
            _taxon_cache_id,
            _taxon_name,
            _species_region,
            _database.id,
            _database.name,
            _database.organisation
            );


    END LOOP;
END;

$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;

-- Function: icol2011ac5Dec.normalize(_str text, _debug integer)
-- Normalize a scientific taxon name (with no authority)
-- _debug = 1 will print notice messages on each normalize step
-- return normalized string

CREATE OR REPLACE FUNCTION col.normalize_taxon(_str text, _debug integer)
  RETURNS text AS
$BODY$
DECLARE


    _tmp_str                    text = '';
    _tmp_tmp_str                text = '';
    _tmp_infraspecies_authority text = '';

    _chars record;

BEGIN

    IF (_debug = 1) THEN
        RAISE NOTICE '1: "%"', _str;
    END IF;

    -- trim any leading, trailing spaces or line feeds
    SELECT * INTO _tmp_str FROM trim(both ' ' from _str);

    IF (_debug = 1) THEN
        RAISE NOTICE '2: "%" - trim( str )', _tmp_str;
    END IF;

    -- replace any HTML ampersands
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'%|&|amp;%|AMP;%', ' ', 'g');

    IF (_debug = 1) THEN
        RAISE NOTICE '3: "%" - remove ampersants', _tmp_str;
    END IF;

        -- remove any content in angle brackets (e.g. html tags - <i>, </i>, etc.)
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'<[^>]*>', ' ', 'g');

    IF (_debug = 1) THEN
        RAISE NOTICE '4: "%" - remove html tags', _tmp_str;
    END IF;

    -- if second term (only) is in round brackets, presume it is a subgenus or a comment and remove it
    -- examples: Barbatia (Mesocibota) bistrigata (Dunker, 1866) => Barbatia bistrigata (Dunker, 1866)
    -- Barbatia (?) bistrigata (Dunker, 1866) => Barbatia bistrigata (Dunker, 1866)
    -- (obviously this will not suit genus + author alone, where first part of authorname is in brackets,
    -- however this is very rare?? and in any case we are not supporting genus+authority in this version)
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'\\(\\w*\\W*\\)', ' ');

    IF (_debug = 1) THEN
        RAISE NOTICE '5: "%" - remove round brackets of subgenus or comments', _tmp_str;
    END IF;

    -- if second term (only) is in square brackets, presume it is a comment and remove it
    -- example: Aphis [?] ficus Theobald, [1918] => Aphis ficus Theobald, [1918]
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'\\[\\w*\\W*\\]', ' ');

    IF (_debug = 1) THEN
        RAISE NOTICE '6: "%" - remove square brackets of subgenus or comments', _tmp_str;
    END IF;

    -- drop indicators of questionable id's (case-insensitive)
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'( cf | cf\. | near | aff\. | sp\. | spp\. | spp )', '', 'i');

    IF (_debug = 1) THEN
        RAISE NOTICE '7: "%" - remove indicators of questionable ids', _tmp_str;
    END IF;

    -- replace double spaces by one
    SELECT * INTO _tmp_str FROM trim(regexp_replace(_tmp_str, ' {2,}', ' ', 'g'));

    IF (_debug = 1) THEN
        RAISE NOTICE '8: "%" - remove double spaces', _tmp_str;
    END IF;

    -- split string on space string
    SELECT * INTO _tmp_str FROM upper(_tmp_str);

    IF (_debug = 1) THEN
        RAISE NOTICE '9: "%" - upper(_tmp_str)', _tmp_str;
    END IF;

    -- drop accents's

    SELECT * INTO _tmp_str FROM unaccent(_tmp_str);
    SELECT * INTO _tmp_str FROM replace(_tmp_str, '?','K');

    IF (_debug = 1) THEN
        RAISE NOTICE '10: "%" - replace any accented characters', _tmp_str;
    END IF;

    FOR _chars IN
    SELECT * FROM regexp_split_to_table(_tmp_str, E'\\.*') AS _char
    LOOP

    IF ((ascii(_chars._char) >= 65 AND ascii(_chars._char) <= 90) OR
        (ascii(_chars._char) = 32) OR (ascii(_chars._char) = 46)) THEN

        _tmp_tmp_str = _tmp_tmp_str || _chars._char;

    END IF;

    END LOOP;

    _tmp_str = _tmp_tmp_str;

    IF (_debug = 1) THEN
        RAISE NOTICE '11: "%" - replace any unknown chars', _tmp_str;
    END IF;

RETURN _tmp_str;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION icol2011ac5Dec.normalize_author(_str text, _debug integer)
  RETURNS text AS
$BODY$
DECLARE


    _tmp_str                    text = '';
    _tmp_tmp_str                text = '';
    _tmp_infraspecies_authority text = '';

    _chars record;

BEGIN

    IF (_debug = 1) THEN
        RAISE NOTICE '1: "%"', _str;
    END IF;

    -- trim any leading, trailing spaces or line feeds
    SELECT * INTO _tmp_str FROM trim(both ' ' from _str);

    IF (_debug = 1) THEN
        RAISE NOTICE '2: "%" - trim( str )', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'^L\.$','Linnaeus');

    IF (_debug = 1) THEN
        RAISE NOTICE '3: "%" - replace "L."', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'^\\(L\\.\\)(.*)', E'Linnaeus\\1');

    IF (_debug = 1) THEN
        RAISE NOTICE '4: "%" - replace "(L.)(.*)"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'^L\\. *(,? *1.*)', E'Linnaeus\\1');

    IF (_debug = 1) THEN
        RAISE NOTICE E'5: "%" - replace "^L\. *(,? 1.*)"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'(.*\\()L\\. *(,? *1.*)', E'\\1Linnaeus\\2');

    IF (_debug = 1) THEN
        RAISE NOTICE E'6: "%" - replace "(.*\()L\. *(,? *1.*)"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'^(DC|D\.C\.|\\(DC\\)|\\(D\.C\.\\))$', 'deCandolle');

    IF (_debug = 1) THEN
        RAISE NOTICE E'7: "%" - replace "^(DC|D\.C\.|\\(DC\\)|\\(D\.C\.\\))$"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E' et al', 'zzzzz', 'g');
    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E' et | and ', ' & ', 'g');
    SELECT * INTO _tmp_str FROM replace(_tmp_str, 'zzzzz', ' et al');

    IF (_debug = 1) THEN
        RAISE NOTICE E'8: "%" - replace " et | and " by &', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E',( [12]{1}[0-9]{1})', E'\\1', 'g');

    IF (_debug = 1) THEN
        RAISE NOTICE E'9: "%" - remove commas before dates ",( [12]{1}[0-9]{1})"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, ' {2,}', ' ', 'g');

    IF (_debug = 1) THEN
        RAISE NOTICE E'10: "%" - remove double spaces " {2,}"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM regexp_replace(_tmp_str, E'[ ]+-', '-', 'g');

    IF (_debug = 1) THEN
        RAISE NOTICE E'11: "%" - remove spaces before -"[ ]+-"', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM unaccent(_tmp_str);

    IF (_debug = 1) THEN
        RAISE NOTICE E'12: "%" - remove accents', _tmp_str;
    END IF;

    SELECT * INTO _tmp_str FROM upper(_tmp_str);

    IF (_debug = 1) THEN
        RAISE NOTICE E'13: "%" - upper', _tmp_str;
    END IF;

RETURN _tmp_str;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION col.build_normalized_table()
  RETURNS boolean AS
$BODY$
DECLARE

    _taxon     RECORD;
    _species   text[];

    _scientific_name_normalized           varchar(255);
    _scientific_name_authority_normalized varchar(255);

BEGIN

    DROP TABLE IF EXISTS icol2011ac5Dec.__normalize_taxon;

    CREATE TABLE icol2011ac5Dec.__normalize_taxon
    (
        taxon_cache_id int,
        n_genus          character varying(255),
        n_species        character varying(255),
        n_species_author character varying(255),
        CONSTRAINT normalize_taxon_id PRIMARY KEY (taxon_cache_id)
    )
    WITH (
      OIDS=FALSE
    );

    CREATE INDEX i_n_genus
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_genus);

    CREATE INDEX i_n_species
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_species);

    CREATE INDEX i_n_species_author
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_species_author);

    CREATE INDEX trgm_n_species
      ON icol2011ac5Dec.__normalize_taxon
      USING gist
      (n_species gist_trgm_ops);

    CREATE INDEX trgm_n_species_author
      ON icol2011ac5Dec.__normalize_taxon
      USING gist
      (n_species_author gist_trgm_ops);

    FOR _taxon IN

        SELECT id, t_genus || ' ' || t_species || ' ' || COALESCE(t_infraspecies, '')AS scientific_name, t_species_author_name FROM icol2011ac5Dec.__taxon_cache

    LOOP

    SELECT * INTO _scientific_name_normalized FROM icol2011ac5Dec.normalize_taxon (_taxon.scientific_name, 0);
    SELECT * INTO _scientific_name_authority_normalized FROM icol2011ac5Dec.normalize_author(_taxon.t_species_author_name, 0);

    SELECT *  INTO _species FROM regexp_matches(_scientific_name_normalized, E'^([^ ]+) (.*)');

    IF (_species[2] IS NOT NULL) THEN

        INSERT INTO icol2011ac5Dec.__normalize_taxon (
            taxon_cache_id,
            n_genus,
            n_species,
            n_species_author
            )

        VALUES (
            _taxon.id,
            _species[1],
            _species[2],
            _species[2] || ' ' || _scientific_name_authority_normalized
            );

           END IF;

    END LOOP;


    RETURN true;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION col.build_normalized_table()
  RETURNS boolean AS
$BODY$
DECLARE

    _taxon     RECORD;
    _species   text[];

    _scientific_name_normalized           varchar(255);
    _scientific_name_authority_normalized varchar(255);

BEGIN

    DROP TABLE IF EXISTS icol2011ac5Dec.__normalize_taxon;

    CREATE TABLE icol2011ac5Dec.__normalize_taxon
    (
        taxon_cache_id int,
        n_genus          character varying(255),
        n_species        character varying(255),
        n_species_author character varying(255),
        CONSTRAINT normalize_taxon_id PRIMARY KEY (taxon_cache_id)
    )
    WITH (
      OIDS=FALSE
    );

    CREATE INDEX i_n_genus
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_genus);

    CREATE INDEX i_n_species
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_species);

    CREATE INDEX i_n_species_author
      ON icol2011ac5Dec.__normalize_taxon
      USING btree
      (n_species_author);

    CREATE INDEX trgm_n_species
      ON icol2011ac5Dec.__normalize_taxon
      USING gist
      (n_species gist_trgm_ops);

    CREATE INDEX trgm_n_species_author
      ON icol2011ac5Dec.__normalize_taxon
      USING gist
      (n_species_author gist_trgm_ops);

    FOR _taxon IN

        SELECT id, t_genus || ' ' || t_species || ' ' || COALESCE(t_infraspecies, '')AS scientific_name, t_species_author_name FROM icol2011ac5Dec.__taxon_cache

    LOOP

    SELECT * INTO _scientific_name_normalized FROM icol2011ac5Dec.normalize_taxon (_taxon.scientific_name, 0);
    SELECT * INTO _scientific_name_authority_normalized FROM icol2011ac5Dec.normalize_author(_taxon.t_species_author_name, 0);

    SELECT *  INTO _species FROM regexp_matches(_scientific_name_normalized, E'^([^ ]+) (.*)');

    IF (_species[2] IS NOT NULL) THEN

        INSERT INTO icol2011ac5Dec.__normalize_taxon (
            taxon_cache_id,
            n_genus,
            n_species,
            n_species_author
            )

        VALUES (
            _taxon.id,
            _species[1],
            _species[2],
            _species[2] || ' ' || _scientific_name_authority_normalized
            );

           END IF;

    END LOOP;


    RETURN true;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- Function: icol2011ac5Dec.validate_from_file(_input_file text, _output_file text, _compare_type integer)
-- Validate taxons in an import csv file against the col data
-- and write the result in an output file
-- @params _input_file  Full path to the import file
-- @params _output_file Full path to the output file
-- @params _option ARRAY(   ARRAY('compare_type', '1'),
--                          ARRAY('levenshtein', '3'),
--                          ARRAY('similarity', '0.6') )
-- The import file must have the following structure:
--
-- scientific_name<tab>author
--
-- Example (replace the <tab> with real tabulators):
--
-- Trogonostomus sericans<tab>Thomson, 1858
-- Peritrichia peringueyi<tab>Von Dalle Torre, 1912

CREATE OR REPLACE FUNCTION col.validate_from_file(_input_file text, _output_file text, _option varchar[])
  RETURNS void AS
$BODY$

DECLARE

    _row_genus_step_1              RECORD;
    _row_genus_step_2              RECORD;
    _found_genus                   integer = 0;
    _row                           RECORD;
    _row_step                      RECORD;
    _scientific_name_normalize     varchar(255);
    _author_normalize              varchar(255);
    _found_step_1                  integer = 0;
    _id                            bigint = 0;
    _genus                         text[];
    _query_suffix                  varchar(255) = '';

    _var                           varchar[];
    _o_compare_type                integer =1;
    _o_levenshtein                 integer = 2;
    _o_similarity                  real = 0.7;

BEGIN

    -- get option variables
    --
    FOREACH _var SLICE 1 IN ARRAY _option
    LOOP
        IF _var[1] = 'compare_type' THEN

            _o_compare_type = _var[2]::integer;

        ELSEIF  _var[1] = 'levenshtein' THEN

            _o_levenshtein = _var[2]::integer;

        ELSEIF  _var[1] = 'similarity' THEN

            _o_similarity = _var[2]::real;

        END IF;
    END LOOP;

   CREATE SEQUENCE icol2011ac5Dec.seq___tmp_export
     INCREMENT 1000
     START 1000
     CACHE 1;

   CREATE TABLE icol2011ac5Dec.__tmp_export
    (
        id                            bigint NOT NULL DEFAULT nextval('icol2011ac5Dec.seq___tmp_export'),
        not_unique                    character varying(1),
        input_scientific_name         character varying(255),
        input_author                  character varying(255),
        output_scientific_name        character varying(255),
        output_author                 character varying(255)
    )
    WITH (
      OIDS=FALSE
    );

   CREATE TABLE icol2011ac5Dec.__tmp_genus
    (
        taxon_cache_id bigint
    )
    WITH (
      OIDS=FALSE
    );

    EXECUTE 'COPY icol2011ac5Dec.__tmp_export (input_scientific_name, input_author) FROM ' || quote_literal(_input_file) || '
             WITH (DELIMITER ' || quote_literal(E'\t') || ',
                   FORMAT ' || quote_literal('csv') || ')';

    FOR _row IN

        SELECT * FROM icol2011ac5Dec.__tmp_export

    LOOP

        TRUNCATE TABLE  icol2011ac5Dec.__tmp_genus;

        SELECT * INTO _scientific_name_normalize    FROM icol2011ac5Dec.normalize_taxon(_row.input_scientific_name, 0);

        SELECT *  INTO _genus FROM regexp_matches(_scientific_name_normalize , E'^([^ ]+) (.+)');

        -- if no species defined proceed with the next row
        --
        IF (_genus[2] IS NULL) THEN
            CONTINUE;
        END IF;

        IF (_o_compare_type = 2) THEN

            SELECT * INTO _author_normalize FROM icol2011ac5Dec.normalize_author(_row.input_author, 0);

            _query_suffix = ' AND levenshtein_less_equal(n_species_author, ' ||
                              quote_literal(_genus[2] || ' ' || _author_normalize) || ', ' || _o_levenshtein || ') < ' || _o_levenshtein + 1 || '
                              OR similarity(n_species_author, ' ||
                              quote_literal(_genus[2] || ' ' || _author_normalize) || ') >= ' || _o_similarity;
        ELSE

            _query_suffix = ' OR levenshtein_less_equal(nt.n_species, ' ||
                              quote_literal(_genus[2]) || ', ' || _o_levenshtein || ') < ' || _o_levenshtein + 1 || '
                              OR similarity(nt.n_species, ' ||
                              quote_literal(_genus[2]) || ') >= ' || _o_similarity;

        END IF;

        _id           = _row.id;
        _found_genus  = 0;
        _found_step_1 = 0;

        -- START --search for the genus part of the scientific name --
        --
        FOR _row_genus_step_1 IN

            SELECT taxon_cache_id FROM icol2011ac5Dec.__normalize_taxon WHERE n_genus = _genus[1]

        LOOP

            _found_genus = _found_genus + 1;

            INSERT INTO icol2011ac5Dec.__tmp_genus VALUES ( _row_genus_step_1.taxon_cache_id );

        END LOOP;

        -- if the previous search dosent returns any result
        -- proceed with the levenshtein and trigram algorithm
        --
        IF (_found_genus = 0) THEN

            FOR _row_genus_step_2 IN

                SELECT taxon_cache_id FROM icol2011ac5Dec.__normalize_taxon

                WHERE levenshtein_less_equal(n_genus, _genus[1], _o_levenshtein) < (_o_levenshtein + 1)

                   OR similarity(n_genus, _genus[1]) >= _o_similarity

            LOOP

                _found_genus = _found_genus + 1;

                INSERT INTO icol2011ac5Dec.__tmp_genus VALUES ( _row_genus_step_2.taxon_cache_id );

            END LOOP;

        END IF;
        --
        -- END --search for the genus part of the scientific name --

        -- if no genus found proceed with the next row
        --
        IF (_found_genus = 0) THEN
            CONTINUE;
        END IF;

        -- START --search for speces (infraspecies) in scientific name --
        --
        FOR _row_step IN

            EXECUTE 'SELECT replace(initcap(t_genus) || ' || quote_literal(' ') || ' || COALESCE(t_species, ' || quote_literal('') || ') || ' || quote_literal(' ') || ' || COALESCE(tc.t_infraspecies,'  || quote_literal('') || ') ,' || quote_literal('  ') ||', ' || quote_literal(' ') || ') AS scientific_name,
                   t_species_author_name AS author

            FROM icol2011ac5Dec.__normalize_taxon AS nt

            INNER JOIN icol2011ac5Dec.__tmp_genus AS tg
                ON tg.taxon_cache_id = nt.taxon_cache_id

            INNER JOIN icol2011ac5Dec.__taxon_cache AS tc
                ON tg.taxon_cache_id = tc.id

            WHERE  nt.n_species = ' || quote_literal(_genus[2]) || _query_suffix


        LOOP

            _found_step_1 = _found_step_1 + 1;

            IF (_found_step_1 = 1) THEN

                UPDATE icol2011ac5Dec.__tmp_export

                    SET not_unique             = DEFAULT,
                        output_scientific_name = _row_step.scientific_name,
                        output_author          = _row_step.author

                WHERE id = _row.id;

            ELSE

                _id = _id + 1;

                INSERT INTO icol2011ac5Dec.__tmp_export (
                    id,
                    not_unique,
                    input_scientific_name,
                    input_author,
                    output_scientific_name,
                    output_author
                )
                VALUES
                (
                    _id,
                    'x',
                    _row.input_scientific_name,
                    _row.input_author,
                    _row_step.scientific_name,
                    _row_step.author
                );

            END IF;

        END LOOP;
        --
        -- END --search for speces (infraspecies) in scientific name --

    END LOOP;

    EXECUTE 'COPY (SELECT * FROM icol2011ac5Dec.__tmp_export ORDER BY id ASC) TO ' || quote_literal(_output_file) || '
             WITH (DELIMITER ' || quote_literal(E'\t') || ',
                   FORMAT ' || quote_literal('csv') || ',
                   HEADER 1)';

    DROP TABLE    icol2011ac5Dec.__tmp_export;
    DROP TABLE    icol2011ac5Dec.__tmp_genus;
    DROP SEQUENCE icol2011ac5Dec.seq___tmp_export;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- return the synonyms of a given taxon_id
-- SELECT * from icol2011ac5Dec.v_taxon_synonym WHERE taxon_id = ?
-- notice: i think there could be a more elegant solution:
--         Replace this view by a function. But first in the taxonomic_rank table
--         the field 'rank' needs to be ordered. Therefore we need a further field
--         in which the order of the rank field should be defined.

CREATE OR REPLACE VIEW icol2011ac5Dec.v_taxon_synonym AS
 SELECT DISTINCT sn.taxon_id, sn.id, sn.id AS name_code, sn.scientific_name_status_id AS status, snen_g.id AS genus_id, snen_g.name_element AS genus, snen_s.id AS species_id, snen_s.name_element AS species, snen_i.id AS infraspecies_id, snen_i.name_element AS infraspecies, tr.marker_displayed AS infraspecific_marker, a_s.string AS author, t.source_database_id
   FROM icol2011ac5Dec.synonym sn
   LEFT JOIN icol2011ac5Dec.synonym_name_element sne_g ON sn.id = sne_g.synonym_id AND sne_g.taxonomic_rank_id = 20
   LEFT JOIN icol2011ac5Dec.scientific_name_element snen_g ON sne_g.scientific_name_element_id = snen_g.id
   LEFT JOIN icol2011ac5Dec.synonym_name_element sne_sg ON sn.id = sne_sg.synonym_id AND sne_sg.taxonomic_rank_id = 96
   LEFT JOIN icol2011ac5Dec.scientific_name_element snen_sg ON sne_sg.scientific_name_element_id = snen_sg.id
   LEFT JOIN icol2011ac5Dec.synonym_name_element sne_s ON sn.id = sne_s.synonym_id AND sne_s.taxonomic_rank_id = 83
   LEFT JOIN icol2011ac5Dec.scientific_name_element snen_s ON sne_s.scientific_name_element_id = snen_s.id
   LEFT JOIN icol2011ac5Dec.synonym s ON sne_s.synonym_id = s.id
   LEFT JOIN icol2011ac5Dec.taxon t ON t.id = s.taxon_id
   LEFT JOIN icol2011ac5Dec.synonym_name_element sne_i ON sn.id = sne_i.synonym_id AND sne_i.taxonomic_rank_id <> 20 AND sne_i.taxonomic_rank_id <> 96 AND sne_i.taxonomic_rank_id <> 83
   LEFT JOIN icol2011ac5Dec.scientific_name_element snen_i ON sne_i.scientific_name_element_id = snen_i.id
   LEFT JOIN icol2011ac5Dec.author_string a_s ON sn.author_string_id = a_s.id
   LEFT JOIN icol2011ac5Dec.taxonomic_rank tr ON sne_i.taxonomic_rank_id = tr.id
  GROUP BY sn.taxon_id, sn.id, sn.scientific_name_status_id, snen_g.id, snen_g.name_element, snen_s.id, snen_s.name_element, snen_i.id, snen_i.name_element, tr.marker_displayed, a_s.string, t.source_database_id
  ORDER BY snen_g.name_element, snen_s.name_element, snen_i.name_element, a_s.string;

CREATE OR REPLACE VIEW icol2011ac5Dec.v_taxon_distribution AS
 SELECT d.taxon_detail_id, ds.id AS distribution_status_id, ds.status AS distribution_status, r.id AS region_id, r.name AS region_name, rs.id AS region_standard_id, rs.standard AS region_standard_name, rs.version AS region_standard_version
   FROM icol2011ac5Dec.distribution d
   LEFT JOIN icol2011ac5Dec.distribution_status ds ON d.distribution_status_id = ds.id
   JOIN icol2011ac5Dec.region r ON d.region_id = r.id
   JOIN icol2011ac5Dec.region_standard rs ON r.region_standard_id = rs.id;

-- return the habitats of a given taxon_id
-- SELECT * from icol2011ac5Dec.v_taxon_habitat WHERE taxon_detail_id = ?

CREATE OR REPLACE VIEW icol2011ac5Dec.v_taxon_habitat AS
 SELECT htd.taxon_detail_id, h.original_code AS habitat_original_code, h.name AS habitat_name, hs.standard AS habitat_list, hs.version AS habitat_list_version
   FROM icol2011ac5Dec.habitat_to_taxon_detail htd
   JOIN icol2011ac5Dec.habitat h ON h.id = htd.habitat_id
   JOIN icol2011ac5Dec.habitat_standard hs ON h.habitat_standard_id = hs.id;

-- return the status of a given taxon_id
-- SELECT * from icol2011ac5Dec.v_scientific_status WHERE taxon_id = ?

CREATE OR REPLACE VIEW icol2011ac5Dec.v_scientific_status AS
 SELECT td.taxon_id, sns.id, sns.name_status
   FROM icol2011ac5Dec.taxon_detail td
   JOIN icol2011ac5Dec.scientific_name_status sns ON td.scientific_name_status_id = sns.id;

CREATE OR REPLACE FUNCTION icol2011ac5Dec.insert_content_from_flat_files( _path_to_flat_files text )
  RETURNS void AS
$BODY$

BEGIN

    EXECUTE 'COPY icol2011ac5Dec.author_string FROM ' || quote_literal(_path_to_flat_files || 'author_string.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.common_name FROM ' || quote_literal(_path_to_flat_files || 'common_name.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.common_name_element FROM ' || quote_literal(_path_to_flat_files || 'common_name_element.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.country FROM ' || quote_literal(_path_to_flat_files || 'country.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.distribution FROM ' || quote_literal(_path_to_flat_files || 'distribution.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.distribution_free_text FROM ' || quote_literal(_path_to_flat_files || 'distribution_free_text.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.distribution_status FROM ' || quote_literal(_path_to_flat_files || 'distribution_status.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.habitat FROM ' || quote_literal(_path_to_flat_files || 'habitat.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.habitat_standard FROM ' || quote_literal(_path_to_flat_files || 'habitat_standard.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.habitat_to_taxon_detail FROM ' || quote_literal(_path_to_flat_files || 'habitat_to_taxon_detail.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.hybrid FROM ' || quote_literal(_path_to_flat_files || 'hybrid.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.language FROM ' || quote_literal(_path_to_flat_files || 'language.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.reference FROM ' || quote_literal(_path_to_flat_files || 'reference.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.reference_to_common_name FROM ' || quote_literal(_path_to_flat_files || 'reference_to_common_name.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.reference_to_synonym FROM ' || quote_literal(_path_to_flat_files || 'reference_to_synonym.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.reference_to_taxon FROM ' || quote_literal(_path_to_flat_files || 'reference_to_taxon.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.region FROM ' || quote_literal(_path_to_flat_files || 'region.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.region_free_text FROM ' || quote_literal(_path_to_flat_files || 'region_free_text.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.region_standard FROM ' || quote_literal(_path_to_flat_files || 'region_standard.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.scientific_name_element FROM ' || quote_literal(_path_to_flat_files || 'scientific_name_element.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.scientific_name_status FROM ' || quote_literal(_path_to_flat_files || 'scientific_name_status.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.scrutiny FROM ' || quote_literal(_path_to_flat_files || 'scrutiny.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.source_database FROM ' || quote_literal(_path_to_flat_files || 'source_database.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.specialist FROM ' || quote_literal(_path_to_flat_files || 'specialist.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.synonym FROM ' || quote_literal(_path_to_flat_files || 'synonym.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.synonym_name_element FROM ' || quote_literal(_path_to_flat_files || 'synonym_name_element.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.taxon FROM ' || quote_literal(_path_to_flat_files || 'taxon.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.taxon_detail FROM ' || quote_literal(_path_to_flat_files || 'taxon_detail.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.taxon_name_element FROM ' || quote_literal(_path_to_flat_files || 'taxon_name_element.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.taxonomic_rank FROM ' || quote_literal(_path_to_flat_files || 'taxonomic_rank.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.uri FROM ' || quote_literal(_path_to_flat_files || 'uri.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.uri_scheme FROM ' || quote_literal(_path_to_flat_files || 'uri_scheme.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.uri_to_source_database FROM ' || quote_literal(_path_to_flat_files || 'uri_to_source_database.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';
    EXECUTE 'COPY icol2011ac5Dec.uri_to_taxon FROM ' || quote_literal(_path_to_flat_files || 'uri_to_taxon.txt') || ' WITH (NULL ' || quote_literal(E'\\N') ||',ESCAPE ' || quote_literal(E'\\') ||',FORMAT ' || quote_literal('csv') ||',ENCODING ' || quote_literal('utf8') ||', QUOTE ' || quote_literal('"') ||', DELIMITER ' || quote_literal(E'\t') || ')';

    PERFORM icol2011ac5Dec.reset_sequences();

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


