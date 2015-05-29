#!/bin/sh
#Create and copy data from Assembly_Global_Deploy to Assembly_Global_Deploy_Previous
#Create and copy data from Assembly_Global to Assembly_Global_Deploy

echo "<pre>";

USER="root"
PASSWORD="fourdforl123"
ASSEMBLYDB="Assembly_Global_Deploy_Previous"

echo "\nCopying data from Assembly_Global_Deploy to Assembly_Global_Deploy_Previous."
mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < /home/GSDS/Master/SQL_templates/copy_into_Assembly_Global_Deploy_Previous.sql 2>logs/mysql.err

echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # this prints all mysql errors if any
done < logs/mysql.err

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";


echo "\nDone"





USER="root"
PASSWORD="fourdforl123"

ASSEMBLYDB="Assembly_Global_Deploy"
echo "\nCopying data from the current assembly database into Assembly_Global_Deploy for further processing."
mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < /home/GSDS/Master/SQL_templates/copy_into_Assembly_Global_Deploy.sql 2>logs/mysql.err

echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # this prints all mysql errors if any
done < logs/mysql.err

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";


echo "\nDone"
echo "</pre>";
exit