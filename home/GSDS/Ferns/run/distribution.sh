gawk -F "\t" '{
OFS="\t";

if (NR == 1) {print "name_code", "distribution", "StandardInUse", "database_id";}
#only print distribution for species (S) and infraspecies (SS, V, FM)
else if ($1~"S|^V$|^FM$")
{
#split($12,distribution_arr,", ");
#for (i=1; i<=length(distribution_arr); i++) {
#if (length(distribution_arr[i])>1) {print $2, distribution_arr[i], "text", 140;}}
gsub(/\(I\)/,"(introduced)",$12);
print $2, $12, "text", 140;
}

}' ../ferns_out.txt

