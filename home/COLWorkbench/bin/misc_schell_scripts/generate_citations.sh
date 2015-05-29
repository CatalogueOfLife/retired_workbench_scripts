#!/bin/sh
#Create new buffer database for GSD or GSD sector

USER="root"
PASSWORD="fourdforl123"

echo "<br>\nGenerating citations"
mysql --skip-column-names -u$USER -p$PASSWORD < /home/GSDS/Master/unsorted_sql/generate_citations.sql > /tmp/citelist.html
mv /tmp/citelist.html /var/www/testcol/application/views/scripts/info/citelist.html
echo "<br>\nCompleted."

exit