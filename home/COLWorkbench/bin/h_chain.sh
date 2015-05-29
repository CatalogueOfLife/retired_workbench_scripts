#!/bin/sh
#Chaining up the operations

echo "<html><body>"

#storing timestamp string of existing files
TIMESTMP1=$(stat -c %Y  *.*)
###echo "/home/GSDS/"$(basename `pwd`)"/logs/progress.txt"

echo 0 > "./logs/progress.txt"
echo "<br><b>Harvesting...</b>\n<pre>"
/home/COLWorkbench/bin/a_download.sh
echo 1 > "./logs/progress.txt"


#storing timestamp string of files after harvesting
TIMESTMP2=$(stat -c %Y  *.*)

#removing old error log...
FILE=./logs/mysql.err;
if [ -s $FILE ] ;
then
rm "./logs/mysql.err"
exit 0;
fi ;

#if url is not empty then will check the time stamps, 
#otherwise will assume manual upload and execute without checking
FILE=./settings/a_download.url;
if [ -s $FILE ] ;
then
#if time strings differ, which means there was an update available, Assembly Chain is executed
#otherwise if there were no updates and timesatmp strings match - Assembly Chain is stopped
if [ "$TIMESTMP1" = "$TIMESTMP2" ]
then echo "</pre><hr><b>No updates available. Stopping execution of the Assembly Chain...</b>";
rm "./logs/progress.txt"
exit 0;
fi ;
fi ;




echo "</pre><hr><b>File format conversions...</b>\n<pre>"
/home/COLWorkbench/bin/b_convert.sh
echo 2 > "./logs/progress.txt"
sleep 1
echo "</pre><hr><b>Creating buffer database, performing structural transformations...</b>\n<pre>"
/home/COLWorkbench/bin/c_create.sh
echo 3 > "./logs/progress.txt"
sleep 1
echo "</pre><hr><b>Backing up...</b>\n<pre>"
/home/COLWorkbench/bin/cl_cleanup.sh
echo 4 > "./logs/progress.txt"

echo "</pre><hr><b>Executing local editorial checks</b>\n<pre>"
/home/COLWorkbench/bin/d_local_editorial.sh
echo 5 > "./logs/progress.txt"

echo "</pre><hr><b>Replacing sectors in Assembly Global database</b>\n<pre>"
/home/COLWorkbench/bin/f_insert_sectors.sh
echo 6 > "./logs/progress.txt"

echo "</pre><hr><b>Chain completed</b>"

echo "</body></html>"
sleep 1

FILE=./logs/progress.txt;

if [ -s $FILE ] ;
then
rm "./logs/progress.txt"
fi ;
exit