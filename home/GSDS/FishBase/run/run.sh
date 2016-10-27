echo "-7) extracting parent-children relationships"
sh filter1.sh > ../fishbase_out.csv
echo "-6) extracting families"
sh families.sh > ../families.csv
echo "-5) extracting scientific names"
sh scientific_names.sh > ../scientific_names.csv
echo "-4) extracting synonyms"
sh synonyms.sh > ../synonyms.csv
echo "-3) extracting common names"
sh common_names.sh > ../common_names.csv
echo "-2) extracting distribution"
sh distribution.sh > ../distribution.csv
echo "-1) extracting references"
sh references.sh > ../references.csv
echo "-1) extracting lifezone"
sh references.sh > ../lifezone.csv
echo "0) transformation completed"

