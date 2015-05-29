#!/bin/sh
#dump tables from baseschema database (current) for downloads from Services pages
cd /home/COLWorkbench/tmp/tables
echo "Deleting old tables...\n"
rm *.txt

echo "Cleaning up the source database (removing linefeeds) and saving tables into delimited text files...\n"

USER="root"
PASSWORD="fourdforl123"

mysql --verbose -u$USER -p$PASSWORD --enable-local-infile < /home/COLWorkbench/bin/col_download/DUMP_baseschema_tables_for_download.sql
echo "\nData export completed.\n"

echo "Creating zip archive in /var/www/services/res\n"
cd ..
rm /var/www/services/res/tables.zip
zip -r -v /var/www/services/res/tables.zip tables
chown www-data:mysql /var/www/services/res/tables.zip tables
echo "Completed. Now you should modify name of tables.zip and update pages of the services accordingly. Then Synchronize Production site to send updates to the production server."


exit