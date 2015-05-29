#!/bin/sh
##Initial file transformations

#INFILE=$1 #either of: zip, gzip, tar, tar.gz
#FFORMAT=$2 #either of: xls, mdb

echo 2 > "./logs/progress.txt"
INFILE=$(ls)

#rm -r extracted
#mkdir extracted
##1) Extract Archive (unzip, untar, ungzip)
case "$INFILE" in
*zip*)
    echo "Unzipping";
    unzip -o *.zip #(extracts everything into dir extracted, -o overwrites without asking, -v verbose)    

    ;;
*tar.gz*)
    echo "Untarrgzipping"
    #tar xvfz *.tar.gz -C .
    tar --strip-components=1 -zxvf *.tar.gz -C .

    ;;
*TAR.gz*)
    echo "Untarrgzipping"
    #tar xvfz *.TAR.gz -C .
    tar --strip-components=1 -zxvf *.TAR.gz -C .

    ;;
*tgz*)
    echo "Untarrgzipping"
    #tar xvfz *.tgz
    tar --strip-components=1 -zxvf *.tgz .

    ;;
*tar*)
    echo "Untarring"
    tar xvf *.tar

    ;;
*gz*)
    echo "Ungzipping"
    #gunzip -c * > filename.txt #(creates new file, does not replace archive)
    gunzip -v *.gz #(replaces archive with extracted file)
    
    ;;
*)
    echo "Skipping extraction"
 
    ;;
esac

FFORMAT=$(ls)
case "$FFORMAT" in
*mdb*)

rm -r extracted
mkdir extracted

    echo "Exporting tables from MS Access file:"
## for MS Access use mdbtools (apt-get install mdbtools) and
## mdbexplode shell script in the bin of this library
#example: /home/COLWorkbench/bin/mdbexplode YourDatabaseFile.mdb
FILENAME=$(ls |grep mdb)

/home/COLWorkbench/bin/lib/mdbexplode.sh $FILENAME
    
    ;;
*xls*)

#rm -r extracted
#mkdir extracted

##2) Transform into delimited text (csv) files into current folder
## for MS Excel use catdoc (apt-get install catdoc)
FILENAME=$(ls |grep .xls)

    echo "Exporting tables from MS Excel file:"
   # xls2csv -x $FILENAME > download.csv 
   # mv -v download.csv ./extracted
xls2csv -x $FILENAME -w AcceptedNames -c AcceptedNames.csv
xls2csv -x $FILENAME -w Synonyms -c Synonyms.csv
xls2csv -x $FILENAME -w CommonNames -c CommonNames.csv
xls2csv -x $FILENAME -w SourceDatabase -c SourceDatabase.csv
xls2csv -x $FILENAME -w Reference -c Reference.csv
xls2csv -x $FILENAME -w ScientificNameReference -c ScientificNameReference.csv

    ;;
*)
    echo "Skipping format conversion"
    
    ;;
esac

rm "./logs/progress.txt"
exit

