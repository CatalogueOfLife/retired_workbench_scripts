echo "-7) extracting parent-children relationships"
sh filter1.sh > ../out.txt
echo "-6) extracting families"
sh families.sh > ../families.txt
echo "-5) extracting scientific names"
sh scientific_names.sh > ../scientific_names.txt
echo "-4) extracting synonyms"
sh synonyms.sh > ../synonyms.txt
echo "-3) extracting common names"
sh common_names.sh > ../common_names.txt
echo "-2) extracting distribution"
sh distribution.sh > ../distribution.txt
echo "-1) extracting references"
sh references.sh > ../references.txt
echo "0) transformation completed"

