gawk -F "\t" '{
OFS="\t";

if (NR == 1) {print "name_code", "common_name", "database_id";}
#only print distribution for species (S) and infraspecies (SS, V, FM)
else if ($1~"S|^V$|^FM$" && length($11)>1)
{
split($11,common_name_arr,", ");
for (i=1; i<=length(common_name_arr); i++) {
if (length(common_name_arr[i])>1) {print $2, common_name_arr[i], 140;}}
}

}' ../out.txt

