#!/bin/sh
#Create new buffer database for GSD or GSD sector
echo "<pre>";
echo "Integrity and editorial checks - this may take a while depending on size of the dataset...\n"

echo 5 > "./logs/progress.txt"

USER="root"
PASSWORD="fourdforl123"
GSD=$(basename `pwd`)
ASSEMBLYDB="Assembly_$GSD"

echo "Starting local editorial transformations"
mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < ./settings/d_local_editorial_transformations.sql 2>logs/mysql.err

echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
echo "</pre>";
while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # or whaterver you want to do with the $line variable
done < logs/mysql.err
echo "<pre>";
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";

echo "\nEditorial and Integrity checks Completed."

rm "./logs/progress.txt"
echo "</pre>";
exit