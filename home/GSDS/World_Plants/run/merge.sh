rm -f ../in.csv
cat ../in/* >> ../in.csv
sed -i '2,${/^Taxon/d}' ../in.csv

