#!/bin/sh
#Create new buffer database for GSD or GSD sector

USER="root"
PASSWORD="fourdforl123"

rm /var/www/testcol/application/views/scripts/info/citelist.html
echo "Generating citations"
mysql --verbose -u$USER -p$PASSWORD --enable-local-infile < /home/GSDS/Master/unsorted_sql/generate_citations.sql
echo "\nCompleted."

exit