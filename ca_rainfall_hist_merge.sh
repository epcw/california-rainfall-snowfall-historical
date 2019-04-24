#!/bin/bash

#this merges all the data in the *./data folder into one big csv.

files="data/*.csv"

cat ca_rainfall_hist.csv > ca_rainfall_hist_old.csv
echo "date,rainfall_inches,station" > ca_rainfall_hist.csv #header

for f in $files;
do

#find "data/." -type f -name "* *.csv" -exec bash -c 'mv "$0" "${0// /_}"' {} \; #replace all spaces in filenames with underscores - probably only need to run once

tempfile=$(echo $f | tail -n +1 )  #trim the leading line from the file.
station=$(echo $f | grep -ioP "...(?=\)\.csv)")
echo "merging $f... | $station"

while read line;
do

linetrimmed=$(echo $line | grep -ioP ".*?(?=\,\"\")")
echo "$linetrimmed,\"$station\"" >> ca_rainfall_hist.csv

done <$tempfile
#echo "$tempfile" #tester
done
