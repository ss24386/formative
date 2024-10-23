#!/bin/bash


## This script creates a list of pt identifiers from the filenames accel data;

ls ../data/derived/accel | awk -F. '{print $1}' | awk -F- '{print $2}' > ../data/derived/accel_PIDs.csv

##add column name
sed -i '1i PID' ../data/derived/accel_PIDs.csv
