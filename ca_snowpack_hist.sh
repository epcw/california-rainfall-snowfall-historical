#!/bin/bash

#this script is a wrapper for ca_snowpack_hist.py, which takes the line-by-line station ID codes from an input file and uses the python / selenium script to download csv files for the last 1000 months (1 file per station)
#station id codes - http://cdec.water.ca.gov/dynamicapp/snowQuery

#usage - ./ca_snowfall_hist.sh

mkdir -p snow_data #define a download destination (Linux hates spaces in destinations, so this keeps it simple and will work no matter the user or the system)
today=$(date +%Y-%m-%d)

#read line-over-line from input file
while read line;
do

url="http://cdec.water.ca.gov/dynamicapp/req/CSVDataServlet?Stations=$line&SensorNums=82&dur_code=M&Start=1930-02&End=2008-05-01" #define the url endpoint, with the stationID code as a variable
url2="http://cdec.water.ca.gov/dynamicapp/req/CSVDataServlet?Stations=$line&SensorNums=82&dur_code=D&Start=2008-06-01&End=$today" #define the

filename="snow_data/snowpack_$line.csv"
query=$(python3 ca_snowpack_hist.py $url > $filename) #set the query command
query2=$(python3 ca_snowpack_hist.py $url2 | tail -n +2 >> $filename) #set the query command
echo $query #query the CA Dept of Water Resources
echo $query2 #query the CA Dept of Water Resources
echo "$line" #report to stdout

done <stations_snow.txt #input file is 1st command-line argument

files="snow_data/*.csv" #define data files

cat snowpack_hist_master.csv > snowpack_hist_master_old.csv
echo "STATION_ID,DURATION,SENSOR_NUMBER,SENSOR_TYPE,DATE TIME,OBS DATE,VALUE,DATA_FLAG,UNITS" > snowpack_hist_master.csv #print header for master csv

#loop over all datafiles
for f in $files;
do
  cat $f | tail -n +2 >> snowpack_hist_master.csv #append to master csv, ignoring the header row (tail starting with row #2)
done
