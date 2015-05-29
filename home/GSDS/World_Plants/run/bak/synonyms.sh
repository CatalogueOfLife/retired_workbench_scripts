gawk -F "\t" '{
OFS="\t";

if (NR == 1) {print "name_code", "genus", "species", "infraspecies",\
 "infraspecies_marker", "author", "accepted_name_code", "database_id", "family_code","is_accepted_name", "name_status", "reference";}
else if ($1~"^F$") {family_code = $2;}
else if ($1~"S|^V$|^FM$") {
gsub(" \\? ","",$13);
gsub("\\?","",$13);
split($13,synonyms_arr,"=");

for (i=2; i<=length(synonyms_arr); i++) {


sub(" x "," x_",synonyms_arr[i]);
sub("^x ","x_",synonyms_arr[i]);
sub(" \\[ssp\\.\\]"," ssp\.",synonyms_arr[i]);
sub(" \\[var\\.\\]"," var\.",synonyms_arr[i]);

split(synonyms_arr[i], name_arr, " ");
genus = name_arr[1];
species = name_arr[2];


#extracting literature from name
#literature = gensub("^(.*)\\[(.*)\\](.*)$","\\2", "g", synonyms_arr[i]);
#literature = gensub("^(.*)(\\[.*\\])(.*)$","\\2", "g", synonyms_arr[i]);
split(synonyms_arr[i], records, "[");
literature = records[2];
sub("\\]", "", literature);
#removing literature from name
sub("\\[.*\\]", "", synonyms_arr[i]);

author = "";
infraspecies_marker = "\\N";
infraspecies = "\\N";
subsp_index = "";
name_status = 5;

if (length(literature) < 1){literature = "\\N";}

flag = 0;
if (synonyms_arr[i]~"( ssp| var| f)\\.")
{

  for (j=1; j<=length(name_arr);j++) {
if (name_arr[j]~"(^ssp|^var|^f)\\.")  { flag = 1; subsp_index = j;}

if (flag == 1 ) {

     if (j == subsp_index) { infraspecies_marker = name_arr[j];}
     else if (j == subsp_index + 1) { infraspecies = name_arr[j];}
     else { if (name_arr[j]~"\\[") {break;}
author = author " " name_arr[j];}
     } 
  }
}
else
{
    for (j=3; j<=length(name_arr);j++) {
     if (name_arr[j]~"\\[") {break;}
     else 
    {author = author " " name_arr[j];}
     }
}

if (length(author) < 1){author = "\\N";}

#cleaning up literature

sub("\\]$", "", literature);
sub("x_","x ",genus);
sub("x_","x ",species);
sub("nom\. nov\.","",literature);

name_prefix = ""
#name_prefix = gensub("^(.*)(nom\. nud)","\\2", "g", literature);
if (literature~"^nom\. nud|^nomen nudum|^nomen nud\.") {name_prefix = "nom. nud.";}
if (literature~"^nom\. nov\. superfl\.|^nom\. superfl\.") {name_prefix = "nom. superfl.";}
if (literature~"^nomen tantum") {name_prefix = "nomen tantum";}
if (literature~"^nom\. inval") {name_prefix = "nom. inval.";}
if (literature~"^nom\. illeg|^nom\. altern\. illeg|based on nom\. illeg\.") {name_prefix = "nom. illeg";}
if (literature~"^nom\. confus\.") {name_prefix = "nom. confus.";}
if (literature~"^nom\. cons") {name_prefix = "nom. cons.";}
if (literature~"^nom\. prov") {name_prefix = "nom. prov.";}
if (literature~"^nom\. rej") {name_prefix = "nom. rej.";}
if (literature~"^nom\. seminud") {name_prefix = "nom. seminud.";}
if (literature~"^nom\. subnud") {name_prefix = "nom. subnud.";}
if (literature~"^pro hybr") {name_prefix = "pro hybr.";}
if (literature~"^pro max\. parte") {name_prefix = "pro max. parte";}
if (literature~"^pro syn") {name_prefix = "pro syn.";}
if (literature~"^sensu") {name_prefix = literature; name_status = 3; literature= "";}
if (literature~"^p\. p\.|^pro parte") {name_prefix = "pro parte"; name_status = 2}
if (literature~"^non ") {name_prefix = literature; name_status = 3; literature="";}

sub("nom\. [a-zA-Z]+\.","", literature);
sub("nomen [a-zA-Z]+","", literature);
sub("pro [a-zA-Z]+","", literature);
sub("p\. p\.","", literature);

if (length(name_prefix)>2) {author = author", "name_prefix};

print $2"-syn-"i, genus, species, infraspecies, infraspecies_marker, author, $2, 140, family_code, 0, name_status, literature;}

}


}' ../out.txt

