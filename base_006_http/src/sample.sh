#!/bin/bash
. ../log.sh;

# download by curl
while read line; do
    touch current.raw.csv && rm current.raw.csv;
    curl ${line} > current.raw.csv;
done < input/sources.txt;

# download by python [requests] (reading from ENV VAR or INPUT DIR)
python3 01_export.py
