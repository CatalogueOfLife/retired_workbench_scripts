/*The below fixes comma/colon issues in authors_editors lists*/
UPDATE `databases` SET authors_editors = REPLACE(authors_editors, ',', '');
UPDATE `databases` SET authors_editors = REPLACE(authors_editors, ';', ',');