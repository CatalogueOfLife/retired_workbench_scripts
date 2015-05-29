#!/bin/sh
#Build SQL queries for databases


USER="root"
PASSWORD="fourdforl123"

#echo $SourceDatabase;
TABLES=$(mysql -u$USER -p$PASSWORD -D$SourceDatabase -e "SHOW TABLES;" | grep -v "^Tables.*"); 

#example: BufferTables = ["AcceptedSpecies", "AcceptedInfraspecificTaxa", "References", "SourceDatabase"];
BUFFERTABLES=$(echo "[\""$TABLES"\"]"|sed 's/\s/", "/g');
TABARRAY=$(echo "BufferTables = "$BUFFERTABLES";");
#echo $TABARRAY;


for TABLE in $TABLES; do
#echo "$TABLE";

#example: BufferFields["Synonyms"] = ["field1", "field2", "field3"];

FLD=$(mysql -u$USER -p$PASSWORD -D$SourceDatabase -e "SHOW COLUMNS FROM \`"$TABLE"\`;" | sed 's/\s.*$//' | grep -v "^Field.*");         
FIELDS=$(echo "[\""$FLD"\"]"|sed 's/\s/", "/g');
FIELDSINTABLE=$(echo $FIELDSINTABLE"BufferFields[\""$TABLE"\"] = "$FIELDS"; ");
#echo $FIELDSINTABLE;
done

#look for placeholders in HTMLTEMPLATE: <!--BufferTablesPlaceholder-->
#<!--BufferFieldsPlaceholder-->

HTMLTEMPLATE=$(cat "/home/COLWorkbench/bin/lib/templateBuider.html"|sed "s/<!--BufferTablesPlaceholder-->/$TABARRAY/;s/<!--BufferFieldsPlaceholder-->/$FIELDSINTABLE/");

echo "<br />"$HTMLTEMPLATE
exit