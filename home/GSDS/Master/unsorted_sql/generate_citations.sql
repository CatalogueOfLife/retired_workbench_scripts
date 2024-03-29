USE Assembly_Global;
SET NAMES utf8;
SELECT CONCAT("<p><strong>", database_name,"</strong><br/>",
CONVERT(authors_editors USING utf8),
" ",
"(2016). ",
database_name_displayed,
" (version ", version, "). ",
"In: Species 2000 & ITIS Catalogue of Life, 28th September 2016 (Roskov Y., Abucay L., Orrell T., Nicolson D., Flann C., Bailly N., Kirk P., Bourgoin T., DeWalt R.E., Decock W., De Wever A., eds). Digital resource at www.catalogueoflife.org/col. Species 2000: Naturalis, Leiden, the Netherlands. ISSN 2405-8858.</p>"
) FROM `databases` d group by database_name;
