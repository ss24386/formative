#!/bin/bash

data=../data/original/ 
der=../data/derived/

##The BMX data did not require cleaning, but I will use this script to clean 
## the accel data
##ACTION: RUN THIS THE FIRST TIME YOU RUN THE SCRIPT AND THEN YOU CAN COMMENT IT OUT TO SAVE TIME 
mkdir ${der}accel
cp -r ${data}accel ${der}

echo -e '\n Clean accel data files \n Remove the first row of each file'
#sed -i '1d' ${der}accel/accel*.txt
echo -e '\n Check removal of first row'
head -q -n1 ${der}accel/accel*.txt | sort -u

echo -e '\n Remove rows with only NA values'
sed -i '/NA\tNA\tNA/d' ${der}accel/accel*.txt

echo -e '\n Check deletion of null lines'
awk -F'\t' '(NF!=8){print $0}' ${der}accel/accel*.txt | sort -u
echo -e '\n\n'
