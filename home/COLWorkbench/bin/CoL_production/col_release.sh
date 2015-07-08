#!/bin/bash

##################################################
# This script is for automation of CoL new release
# writen by Kwok Yin Cheung Jan 2013
##################################################

# Define all the constant variables
WORKSPACE="/home/COLWorkbench/tmp/CoL_production/"
TESTCOL="/var/www/testcol/"
TOPDIR="/home/COLWorkbench/tmp/"
SITEMAPS="/var/www/ConversionTool/sitemaps/"
DCA="/var/www/DCA_Export/"
DOWNLOAD_DIR="/var/www/download/"
DB_USERNAME="root"
DB_PASSWORD="fourdforl123"

# Clean up WORKSPACE directory if it is not empty
echo $WORKSPACE
#if [ ! -z `/bin/ls -A $WORKSPACE` ]
if [ "$(/bin/ls -A $WORKSPACE)" ]
then
	/bin/rm -R "$WORKSPACE"*
fi

# Create directories in WORKSPACE
/bin/mkdir "$WORKSPACE"public
/bin/mkdir "$WORKSPACE"public/images
/bin/mkdir "$WORKSPACE"public/images/databases
/bin/mkdir "$WORKSPACE"public/images/tree_icons

/bin/mkdir "$WORKSPACE"application
/bin/mkdir "$WORKSPACE"application/views
/bin/mkdir "$WORKSPACE"application/views/scripts
/bin/mkdir "$WORKSPACE"application/views/scripts/info

/bin/mkdir "$WORKSPACE"sitemaps

/bin/mkdir "$WORKSPACE"dca

/bin/mkdir "$WORKSPACE"languages

/bin/mkdir "$WORKSPACE"application/configs

# Copy files from testcol directory into WORKSPACE directory
/bin/cp -p -R "$TESTCOL"public/images/* \
	"$WORKSPACE"public/images

/bin/cp -p "$TESTCOL"application/views/scripts/info/* \
	"$WORKSPACE"application/views/scripts/info

/bin/cp -p "$TESTCOL"application/configs/application.xml \
	"$WORKSPACE"application/configs

/bin/cp -p "$SITEMAPS"* \
	"$WORKSPACE"sitemaps

/bin/cp -p "$DCA"templates/eml.tpl \
	"$WORKSPACE"dca

/bin/cp -p "$DCA"templates/meta_eml.tpl \
	"$WORKSPACE"dca

/bin/cp -p -R "$TESTCOL"application/data/languages/* \
	"$WORKSPACE"languages


# Edit application.xml file
/bin/sed -i "s/testcol/col/g" "$WORKSPACE"application/configs/application.xml

# Dump Assembly_Base_Schema to Assembly_Base_Schema.sql
/usr/bin/mysqldump -u$DB_USERNAME -p$DB_PASSWORD \
--result-file="$WORKSPACE"Assembly_Base_Schema.sql ac_latest

# Tar production directory, might have to factor out "CoL_production"
# from this line
cd $TOPDIR
if [ -e CoL_production.tar ]
then
	/bin/rm -f CoL_production.tar
fi

/bin/tar -cvf CoL_production.tar CoL_production

if [ -e "$DOWNLOAD_DIR"CoL_production.tar ]
then
	/bin/rm -f "$DOWNLOAD_DIR"CoL_production.tar
fi

# Move the tar file to download area of the server
/bin/mv CoL_production.tar $DOWNLOAD_DIR
