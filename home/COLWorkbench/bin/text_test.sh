#!/bin/sh

NOW=$(date +"%H:%M:%S:%d%b%Y")





FILE=./settings/lock.txt;

if [ -s $FILE ]; 
then
echo "Locking directory on $NOW"
echo cat $FILE;
else
echo "Locked on $NOW" > ./settings/lock.txt;
fi;

exit