#! /bin/bash


for i in $(mdb-tables $1); do
echo $i
mdb-export $1 $i > extracted/$i.csv
done