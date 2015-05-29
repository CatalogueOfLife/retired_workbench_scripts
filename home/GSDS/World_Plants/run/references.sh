gawk -F "\t" '{
OFS="\t";

if (NR == 1) {
print "name_code", "reference_type", "reference_code", "year", "author", "source", "database_id";
}
else if ($1~"S|^V$|^FM$" && length($10)>1)
{
 #year = gensub("(^.*)\\((.*)\\)$","\\2", "g", $10);
year = gensub("(.*)([1-2][0-9][0-9][0-9])(.*)","\\2", "g", $10);
 author = gensub("\\((.*)\\)(.*)$","\\2", "g", $8);
 source = gensub("(^.*)\\((.*)\\)$","\\1", "g", $10);

if (match(year,"[1-2][0-9][0-9][0-9]")) {year=year;}
else {year="\\N";}

if (length(author) > 0 && length(source) > 0 && author != "\\N" && source != "\\N") {print $2, "NomRef", $2"-ref", year, author, "In: "source, 141;} 

}

}' ../out.txt

gawk -F "\t" '{
OFS="\t";

if (NR == 1) {
#print "name_code", "reference_type", "reference_code", "year", "author", "source", "database_id";
}
else
{
 year = gensub("(.*)([1-2][0-9][0-9][0-9])(.*)","\\2", "g", $12);
 author = gensub("\\((.*)\\)(.*)$","\\2", "g", $6);
 source = gensub("(.*)(.+)([1-2][0-9][0-9][0-9])(.*)","\\1", "g", $12);

if (match(year,"[1-2][0-9][0-9][0-9]")) {year=year;}
else {year="\\N";}
if (length(author) > 0 && length(source) > 0 && author != "\\N" && source != "\\N") {print $1, "NomRef", $1"-ref", year, author, "In: "source, 141;}
}

}' ../synonyms.txt
