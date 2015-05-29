#!/bin/sh
#Create new baseschema database using sql from converters directory and start converter
# Output from converter redirected to disk at /home/COLWorkbench/logs
echo "Initiating base schema using ETI scripts, make sure these use the correct database...\n"

#echo 0 > "./logs/progress.txt"
USER="root"
PASSWORD="fourdforl123"

#echo "\nCreating database and tables:\n"
#mysql --verbose -u$USER -p$PASSWORD < /var/www/ConversionTool/docs_and_dumps/dumps/base_scheme/baseschema-schema.sql

#echo 1 > "./logs/progress.txt"
#echo "\nPopulating tables with initial data:\n"
#mysql --silent -u$USER -p$PASSWORD < /var/www/ConversionTool/docs_and_dumps/dumps/base_scheme/baseschema-data.sql

#echo 3 > "./logs/progress.txt"

echo "\nStarting step 1 out of 4: Optimize the Assembly Database. Output redirected to logfile at /var/www/ConversionTool/logs/AdOptimizer_log.html\n"
php /var/www/ConversionTool/AdOptimizer.php > /var/www/ConversionTool/logs/AdOptimizer_log.html

#echo 4 > "./logs/progress.txt"
#echo "\nStarting step 2 out of 4: Convert the database. Output redirected to logfile at /var/www/ConversionTool/logs/AcToBs_log.html\n"
#php /var/www/ConversionTool/AcToBs.php > /var/www/ConversionTool/logs/AcToBs_log.html

#echo "\nStarting step 3 out of 4: Add denormalized tables. Output redirected to logfile at /home/COLWorkbench/logs/BsOptimizer_log.html\n"
#php /var/www/ConversionTool/BsOptimizer.php > /var/www/ConversionTool/logs/BsOptimizer_log.html

#echo "\nStarting step 3 out of 4: Create sitemap files. Output redirected to logfile at /home/COLWorkbench/logs/Sitemaps_log.html\n"
#php /var/www/ConversionTool/sitemaps.php > /var/www/ConversionTool/logs/Sitemaps_log.html

#echo "\nAC to BS Conversion for ACI v1.9 complete\n. Please check log files for errors before deploying."
#echo 5 > "./logs/progress.txt"

exit