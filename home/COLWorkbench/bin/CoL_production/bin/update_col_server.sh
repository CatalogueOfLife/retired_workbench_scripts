#!/bin/bash

#######################################################
# This script is for updating of CoL production servers
# writen by Kwok Yin Cheung, edited by Viktoras Didziulis Jan 2013
#######################################################

# Define all the constant variables
# Change the variables' definitions here to configure this script
# Note: Filename 'CoL_production.tar' is hard wired in this script
WORKSPACE_DIR="/home/CoL_production/"
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
# Need to re-configurate the server to stop some process
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
/bin/rm -R /var/www/col/application/cache/*

# Update application.xml and databases directory
echo "Updating application.xml and databases directory"
mv /var/www/col/application/configs/application.xml \
	/var/www/col/application/configs/application.xml.bak
mv application/configs/application.xml \
	/var/www/col/application/configs/application.xml
mv /var/www/col/public/images/databases \
	/var/www/col/public/images/databases_bak
mv public/images/databases \
	/var/www/col/public/images/databases

# Update info directory
echo "Updating info directory"
mv /var/www/col/application/views/scripts/info \
	/var/www/col/application/views/scripts/info_bak
mv application/views/scripts/info \
	/var/www/col/application/views/scripts/info

# Start apache
# Note: Here is apache2ctl, PLEASE CHECK is this the for the local server
echo "Starting Apache"
/usr/sbin/apache2ctl -k restart

##########################################################
##########################################################
##########################################################
#
# Need to restore original server configurate
# Need to ask Viktor how to do this.

# line below inserted by Viktor re-loads default system variables
sysctl -p /etc/sysctl.conf
##########################################################
##########################################################
##########################################################

# Give time at the end of this script
echo "update_col_server.sh ended: " `date`
exit 0
