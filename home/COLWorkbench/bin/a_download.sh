#!/bin/sh
#Harvesting data from remote GSD

FILE=./settings/a_download.url;

echo 1 > "./logs/progress.txt"
if [ -s $FILE ]; 
then
wget -N -i ./settings/a_download.url
else
echo "<p>Skipping download as there is no URL specified.<br /> Assuming the datasets are uploaded by users via usermin accounts.</p>";
fi ;

rm "./logs/progress.txt"
exit
