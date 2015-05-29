#!/bin/sh
echo "<pre>";
echo 6 > "./logs/progress.txt"

USER="root"
PASSWORD="fourdforl123"
GSD=$(basename `pwd`)
ASSEMBLYDB="Assembly_$GSD"

echo "Starting Sector Management"
mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < ./settings/f_sector_mapping.sql 2>logs/mysql.err

echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # or whaterver you want to do with the $line variable
done < logs/mysql.err

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";

echo "\nTransformations Completed."

rm "./logs/progress.txt"
echo "<pre>";
exit