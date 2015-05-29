awk -F "\t" '{
OFS="\t";

if (NR == 1) {print "record_id", "hierarchy_code", "kingdom", "phylum", "class", "order", "family", "superfamily", "database_id", "family_code";}
if (match($1, "^F$")) {print NR, "Plantae-Tracheophyta-"class"-"order"-"$4, "Plantae", "Tracheophyta", class, order, $4, "", 140, $2;}
else {
if ($1~"^O$") {order = $4;}
else if($1~"^F$") {family = $4;}
else if($1~"^G$" && NR==2) {class = $4;}
}

}' ../out.txt

