#!/bin/bash

#######################################################
# This script is for updating of CoL production servers
# writen by Kwok Yin Cheung, edited by Viktoras Didziulis Jan 2013
#######################################################

# Define all the constant variables
# Change the variables' definitions here to configure this script
# Note: Filename 'CoL_production.tar' is hard wired in this script
WORKSPACE_DIR="/home/COL_Production/"
DOWNLOAD_URL="http://salx9-vm9.rdg.ac.uk/download/CoL_production.tar"
DOWNLOAD_USERNAME="col"
DOWNLOAD_PASSWORD="col"
DB_USERNAME="root"
DB_PASSWORD="fourdforl123"
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
sysctl -p /etc/sysctl.conf.nopanic

##########################################################
##########################################################
##########################################################

# Stop apache
# Note: Here is apache2ctl, PLEASE CHECK is this the for the local server
echo "Stopping Apache"
/usr/sbin/apache2ctl -k stop

# Extract CoL_production.tar
echo "Extracting CoL_production.tar"
tar -xvf CoL_production.tar

# Change directory inside CoL_production
cd CoL_production

# Update mysql database
echo "Updating mysql database"
mysql -u$DB_USERNAME -p$DB_PASSWORD -e \
'DROP DATABASE IF EXISTS COL_Production;
CREATE DATABASE COL_Production CHARACTER SET utf8 COLLATE utf8_general_ci;
USE COL_Production;
\. Assembly_Base_Schema.sql'

# Change owner for all the files and directories
chown -R www-data:www-data application public

# Remove cache
echo "Removing cache"
rm -R /var/www/col/application/cache/*

# Update application.xml and databases directory
# modified by Viktor: mv on Debian works only if target directory is not empty
# therefore replacing it with cp -(r)f and rm -(r)f
# and we are lucky if cp is not aliased to cp -i (like on Redhat), 
# otherwise we would use \cp, \mv, \rm instead

echo "Updating application.xml and databases directory"
cp -f /var/www/col/application/configs/application.xml \
	/var/www/col/application/configs/application.xml.bak
rm -f /var/www/col/application/configs/application.xml
mv application/configs/application.xml \
	/var/www/col/application/configs/application.xml

cp -rf /var/www/col/public/images/databases \
	/var/www/col/public/images/databases_bak
rm -rf /var/www/col/public/images/databases
mv public/images/databases \
	/var/www/col/public/images/databases

# Update info directory
echo "Updating info directory"
cp -rf /var/www/col/application/views/scripts/info \
	/var/www/col/application/views/scripts/info_bak
rm -rf /var/www/col/application/views/scripts/info
mv application/views/scripts/info \
	/var/www/col/application/views/scripts/info

# Start apache
# Note: Here is apache2ctl, PLEASE CHECK is this the for the local server
# echo "Starting Apache"
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
sysctl -p /etc/sysctl.conf
##########################################################
##########################################################
##########################################################

# Give time at the end of this script
echo "update_col_server.sh ended: " `date`
exit 0
