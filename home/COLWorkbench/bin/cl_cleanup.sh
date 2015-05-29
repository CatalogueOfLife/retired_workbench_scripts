#!/bin/sh
#Cleans up after downloading and putting data into mysql buffer database
echo 4 > "./logs/progress.txt"
#As all downloading and conversions are done into root of gsd directory (e.g. /home/GSDS/ITIS/), 
#upon completion of importing procedure we need to:
#cd /home/GSDS/ITIS/Bees and
#1) create new directory using date e.g. 26july2011
NOW=$(date +"%H_%M_%S_%d%b%Y")
echo "Creating directory " $NOW

mkdir $NOW

echo "Backing up files"
#2) copy all files from current dir to new place
cp *.* ./$NOW
#mv r [^settings]* ./$NOW 

rm "./logs/progress.txt"
exit