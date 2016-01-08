USE Assembly_Global;
SET NAMES utf8;
SELECT CONCAT("<p><strong>", database_name,"</strong><br/>",
CONVERT(authors_editors USING utf8),
" ",
"(2015). ",
database_name_displayed,
" (version ", version, "). ",
"In: Species 2000 & ITIS Catalogue of Life, 23rd December 2015 (Roskov Y., Abucay L., Orrell T., Nicolson D., Kunze T., Flann C., Bailly N., Kirk P., Bourgoin T., DeWalt R.E., Decock W., De Wever A., eds). Digital resource at www.catalogueoflife.org/col. Species 2000: Naturalis, Leiden, the Netherlands. ISSN 2405-8858.</p>"
) FROM `databases` d group by database_name;
