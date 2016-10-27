The followings are instruction of how to release a new copy of CoL from
test server.

Prepare files
=============
In test server: salx9-vm9
Copy the following files / directories to ~/production/.
	/var/www/testcol/public/images/databases/*

	/var/www/testcol/application/views/scripts/info/*

	/var/www/testcol/application/configs/application.xml

Edit the application.xml file:
	change "testcol" to "col"
	change line 93 to:
		<location>
			http://www.catalogueoflife.org/col
		</location>

Dump Assembly_Base_Schema db to Assembly_Base_Schema.sql
	$ ./dump_abs

Tar and gzip production directory
	then move the .tar.gz file to /var/www/download


Update Production Servers
=========================
Production servers are grouped in two groups:

Group1:
salx9-vm5
salx13-vm1

Group2: (download services)
salx12-vm1
salx9-vm1 (might not be needed to do anything on this server!)

Working in one server to the next within a group.
Before start working on any serive, need to:
	disable cron job (this can be done in webmin, url: https://salx..vm*:10000
	stop apache, # apachectl -k stop

Download the tar.gz file using wget:
	# wget -O fileFullPath http://salx9-vm9.rdg.ac.uk/download/production.tar.gz

Unzip and extract the tar file.

update mysql db:
mysql> drop database COL_Production;
mysql> create database COL_Producton CHARACTER SET utf8 COLLATE utf8_general_ci;
mysql> use COL_Production;
mysql> source Assembly_Base_Schema.sql;

Remove cache in
	# rm -R /var/www/col/application/cache/*

Update:
	/var/www/col/application/configs/application.xml
	/var/www/col/public/images/databases/*

In /var/www/col/application/views/scripts/.
	# mv info to info_bak

then copy info to
	/var/www/col/application/views/scripts/info

Change owner of all the above files and directories to:
	www-data:www-data

Start apache
	# apachectl -k restart

Start cron job from Webmin.

Check it is work on this server url:
	e.g. http://salx9-vm5/

Move to the next server within the same group
=============================================
This have to be done asap when the first server is finished.

Stop apache and cron job
then check www.catalogueoflife.org/col is indeed is pointed to the updated
version.

Repeat the same step as the top of instruction for the next server.

For Group2 Servers
==================
Group2: (download services)
salx12-vm1
salx9-vm1 (might not be needed to do anything on this server!)

On salx12-vm1 server

Proceed as the previous two servers. After restarted apache:
Note the date inside file /var/www/DCA_Export/config/setting.ini

Edit the same file and
change to the new date as well.

Use this date to prefix the file
	/var/www/DCA_Export/zip-fixed/archive-complete.zip to
	yyyy-mm-dd-archive=complete.zip

then remove
	/var/www/DCA_Export/zip/archive-complete.zip

Use Firefox go to URL:
	salx12-vm1/DCA_Export/

	user: i4life
	passwd: project2011

On this download page:
	Top level group: [All]
then click the 'Download' button and wait for several hours to
create the new archive-complete.zip

Progress can be check under:
	/var/www/DCA_Export/export/....../files being updated

Copy from
	/var/www/DCA_Export/zip/archive-complete.zip to
	/var/www/DAC_Export/zip-fixed/.
