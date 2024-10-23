#!/bin/bash

##set data directory
data=~/Documents/formative/data/

##Check BMX-D data file
echo -e '\n Number of rows in BMX data:'
wc -l ${data}original/BMX_D.csv
echo -e '\n Number of unique participants in BMX data'
cut -d, -f2 ${data}original/BMX_D.csv | sort -u | wc -l
echo -e '\n Top of BMX file:'
head ${data}original/BMX_D.csv
echo -e '\n Number of fields in  BMX data:'
awk -F, '{print NF}' ${data}original/BMX_D.csv | head -n1
echo -e '\n Number of unique fields in each row of BMX data:'
awk -F, '{print NF}' ${data}original/BMX_D.csv | sort -u

##Check accel data file
echo -e '\n\n  Check one accel file - top of file:'
head ${data}original/accel/accel-31128.txt

echo -e '\n Number of files/participants in zip file:'
ls -l ${data}original/accel | wc -l

echo -e '\n\n Check all files have same first row'
head -n1 -q  ${data}original/accel/accel-*.txt | cut -c1-14 | sort -u
echo -e '\n Check all files have same columns'
sed -n '2p' ${data}original/accel/accel-*.txt | sort -u

echo -e '\n Check all rows have right number of columns'
tail -n +2 -q ${data}original/accel/accel-*.txt | awk -F'\t' '{print NF}' | sort -u

echo -e '\n Find rows with 3 columns rather than 8'
tail -q -n+2 ${data}original/accel/accel*.txt | awk -F'\t' '(NF!=8){print $0}' | sort -u
