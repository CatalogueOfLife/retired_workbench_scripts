awk -F "\t" '{
OFS="\t";

if (NR == 1) {print "record_id", "name_code", "genus", "species", "infraspecies_parent_name_code", \
"infraspecies", "infraspecies_marker", "author", "accepted_name_code", "comment", "database_id", "family_code","is_accepted_name","name_status";}
else if (match($1, "^S$")) {print NR, $2, $4, $5, "\\N", "\\N", "\\N", $8, $2, $15, 140, family_code, 1, 1;}
else if (match($1, "^SS$|^V$|^FM$")) {print NR, $2, $4, $5, $9, $7, $6, $8, $2, $15, 140, family_code, 1, 1;}
else if($1~"^F$") {family_code = $2;}


}' ../out.txt

