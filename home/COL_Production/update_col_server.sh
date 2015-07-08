#!/bin/bash

#######################################################
# This script is for updating of CoL production servers
# writen by Kwok Yin Cheung, edited by Viktoras Didziulis
#######################################################

# Define all the constant variables
# Change the variables' definitions here to configure this script
# Note: Filename 'CoL_production.tar' is hard wired in this script
WORKSPACE_DIR="/home/COL_Test/"
DOWNLOAD_URL="http://134.213.57.57/download/CoL_production.tar"
DOWNLOAD_USERNAME="col"
DOWNLOAD_PASSWORD="col"
DB_USERNAME="root"
DB_PASSWORD="Fzn8EVPIGSUCOPJcgM5l"
DCUPDATEPWD="^Guu&*^f___\\"  # DarwinCore Update password
DEBUG=0

# Give time at the beginning of this script
echo "update_col_server.sh started: " `date`

# Change directory to WORKSPACE_DIR
cd $WORKSPACE_DIR

# I don't know how to tell whether wget have actually download the file or not
# so have to use other mean to test whether download have happen

# get the timestamp of the old file
if [ -e CoL_production.tar ]
then
echo "get the old timestamp"
	OLD_TIMESTAMP=`stat -c %Y CoL_production.tar`
else
	# CoL_production.tar not here, just set the timestamp to 0
	OLD_TIMESTAMP='0'
fi

# These lines are for debugging use
if [ $DEBUG -ne '0' ]
then
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
	echo "Old timestamp is " $OLD_TIMESTAMP
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
fi

# use wget to get the tar file
/usr/bin/wget -N $DOWNLOAD_URL \
	--http-user=$DOWNLOAD_USERNAME \
	--http-password=$DOWNLOAD_PASSWORD

# After using wget to download the file, check the exit code is ok
#
# I thought I could use the exit code to check whether wget downloaded a
# new file, but I was disappointed ..., all you could do is to check the
# whether the url or command syntax is correct.
#
if [ $? -ne '0' ]
then
	echo "Can't get $DOWNLOAD_URL by wget."

	# Give time at the end of this script
	echo "update_col_server.sh ended: " `date`

	exit 1;
fi

# get the timestamp of the new file
NEW_TIMESTAMP=`stat -c %Y CoL_production.tar`

# These lines are for debugging use
if [ $DEBUG -ne '0' ]
then
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
	echo "Old timestamp is " $OLD_TIMESTAMP
	echo "New timestamp is " $NEW_TIMESTAMP
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
fi

if [ $OLD_TIMESTAMP -eq $NEW_TIMESTAMP ]
then
	echo "No new update, don't need to do anything."

	# Give time at the end of this script
	echo "update_col_server.sh ended: " `date`

	exit 0;
fi

##########################################################
# Here is where everything begin
##########################################################
echo "Update start here"

##########################################################
##########################################################
##########################################################
#
# Need to re-configure the server to stop some process
# Need to ask Viktor how to do this

# code below to modify system variables in sysctl added by Viktor
# may not be necessary for 
#sysctl -p /etc/sysctl.conf.nopanic

##########################################################
##########################################################
##########################################################

# Stop puppet
# Note: Stopping puppet agent is needed otherwise the stop httpd part will conflict with the "ensure running" functionality of the puppet script.
echo "Stopping Puppet"
service puppet stop

# Stop apache
# Note: Here is apache2ctl, PLEASE CHECK is this the for the local server (may need to use service httpd stop instead)
echo "Stopping Apache"
# service httpd stop

# Extract CoL_production.tar
echo "Extracting CoL_production.tar"
tar -xvf CoL_production.tar

# Change directory inside CoL_production
cd CoL_production


echo "Updating application.xml and databases directory"
cp -f /var/www/new_col/application/configs/application.xml \
	/var/www/new_col/application/configs/application.xml.bak
rm -f /var/www/new_col/application/configs/application.xml
mv application/configs/application.xml \
	/var/www/new_col/application/configs/application.xml

cp -rf /var/www/new_col/public/images \
	/var/www/new_col/public/images_bak
rm -rf /var/www/new_col/public/images
mv public/images \
	/var/www/new_col/public/images

#cp -rf /var/www/new_col/public/images/databases \
#	/var/www/new_col/public/images/databases_bak
#rm -rf /var/www/new_col/public/images/databases
#mv public/images/databases \
#	/var/www/new_col/public/images/databases

# Update info directory
echo "Updating info directory"
cp -rf /var/www/new_col/application/views/scripts/info \
	/var/www/new_col/application/views/scripts/info_bak
rm -rf /var/www/new_col/application/views/scripts/info
mv application/views/scripts/info \
	/var/www/new_col/application/views/scripts/info

# Update application/data/languages directory
echo "Updating languages directory"
cp -rf /var/www/new_col/application/data/languages \
	/var/www/new_col/application/data/languages_bak
rm -rf /var/www/new_col/application/data/languages
mv languages \
	/var/www/new_col/application/data/languages

# Update sitemaps
echo "Updating sitemaps directory"
rm -rf /var/www/new_col/public/sitemaps
mv sitemaps \
	/var/www/new_col/public/sitemaps

# Update DCA emls
echo "Updating DarwinCore Archive emls"
rm /var/www/new_dca/templates/eml.tpl
rm /var/www/new_dca/templates/meta_eml.tpl
mv dca/eml.tpl \
	/var/www/new_dca/templates/eml.tpl
mv dca/meta_eml.tpl \
	/var/www/new_dca/templates/meta_eml.tpl



# Update mysql database
echo "Updating mysql database"
mysql -u$DB_USERNAME -p$DB_PASSWORD -e \
'DROP DATABASE IF EXISTS ac_latest_new;
CREATE DATABASE ac_latest_new CHARACTER SET utf8 COLLATE utf8_general_ci;
USE ac_latest_new;
\. Assembly_Base_Schema.sql'

# Change owner for all the files and directories
chown -R apache:apache application public
chown -R root:root /var/www/new_col/public/sitemaps

# Remove cache
echo "Removing cache"
rm -rf /var/www/new_col/application/cache/

# Update application.xml and databases directory
# modified by Viktor: mv on Debian works only if target directory is not empty
# therefore replacing it with cp -(r)f and rm -(r)f
# and we are lucky if cp is not aliased to cp -i (like on Redhat), 
# otherwise we would use \cp, \mv, \rm instead



# Start apache
# Note: Here is apache2ctl, PLEASE CHECK is this the for the local server
echo "Starting Apache"
# service httpd start

# Start puppet
echo "Starting Puppet"
service puppet start



# /usr/sbin/apache2ctl -k restart
# commented out by Viktoras - we need to start apache not sooner then the update script is started
# on the other server(s). This is to prevent 2 different versions of the COL appearing simultaneously
# therefore apache may be set to be started by CRON 1 minute before CRON starts update on other server
# whereas on the other server this might be uncomented as it does not need to wait for yeat another server to be ready.
# In case of multiple nodes first run this script on 1 server and afterwards update all the rest servers all at the same time.
# In this case for a short while CoL will be run from 1 server for ~1 hour and the others will kick in all together at once.

##########################################################
##########################################################
##########################################################
#
# Need to restore original server configuration
# Need to ask Viktor how to do this.

# line below inserted by Viktor re-loads default system variables
#sysctl -p /etc/sysctl.conf
##########################################################
##########################################################
##########################################################

# creating DarwinCore Archives after new release
php /var/www/new_dca/monthly.php  -w $DCUPDATEPWD -d `date +%F`

# Give time at the end of this script
echo "update_col_server.sh ended: " `date`
exit 0
