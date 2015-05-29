#!/bin/sh
#Create new buffer database for GSD or GSD sector
echo "<pre>";
echo "Initiating buffer creation - this may take a while depending on size of the dataset...\n"

echo 3 > "./logs/progress.txt"

USER="root"
PASSWORD="fourdforl123"
GSD=$(basename `pwd`)
BUFFERDB="Buffer_$GSD"
ASSEMBLYDB="Assembly_$GSD"


echo "Creating buffer database $BUFFERDB in schema as provided by $GSD"

mysql --verbose -u$USER -p$PASSWORD -e "DROP DATABASE IF EXISTS $BUFFERDB;"
mysql --verbose -u$USER -p$PASSWORD -e "CREATE DATABASE IF NOT EXISTS $BUFFERDB;"
mysql --verbose -u$USER -p$PASSWORD -D$BUFFERDB --enable-local-infile < ./settings/c_create.sql 2>logs/mysql.err


echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # or whaterver you want to do with the $line variable
done < logs/mysql.err

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";


echo "Initial database created. Creating database $ASSEMBLYDB in assembly schema"
mysql --verbose -u$USER -p$PASSWORD -e "DROP DATABASE IF EXISTS $ASSEMBLYDB;"
mysql --verbose -u$USER -p$PASSWORD -e "CREATE DATABASE IF NOT EXISTS $ASSEMBLYDB;"
mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < ./settings/c_create_local_assemblydb.sql 2>logs/mysql.err


echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";


while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # or whaterver you want to do with the $line variable
done < logs/mysql.err


echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";

echo "\nCreation of the assembly database completed.\n"

echo "Starting structural transformations (ACEF3 to ACI)"

mysql --verbose -u$USER -p$PASSWORD -D$ASSEMBLYDB --enable-local-infile < ./settings/c_structural_transformations.sql 2>logs/mysql.err

echo "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";

while read line; do 
    echo "<b style='color:red'>"$line"---</b><br/>\n" # or whaterver you want to do with the $line variable
done < logs/mysql.err

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n";


echo "\nData Loaded."

rm "./logs/progress.txt"
echo "</pre>";

exit