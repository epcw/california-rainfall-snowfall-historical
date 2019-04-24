#!/bin/bash

#this script is a wrapper for ca_rainfall_hist.py, which takes the line-by-line station ID codes from an input file and uses the python / selenium script to download csv files for the last 1000 months (1 file per station)
#station id codes - http://cdec.water.ca.gov/dynamicapp/staSearch?sta=&sensor_chk=on&sensor=2&collect=NONE+SPECIFIED&dur_chk=on&dur=M&active=&lon1=&lon2=&lat1=&lat2=&elev1=-5&elev2=99000&nearby=&basin=NONE+SPECIFIED&hydro=NONE+SPECIFIED&county=NONE+SPECIFIED&agency_num=160&display=sta
#usage - ./ca_rainfall_hist.sh stations.txt

mkdir ~/Downloads/water #define a download destination (Linux hates spaces in destinations, so this keeps it simple and will work no matter the user or the system)

#read line-over-line from input file
while read line;
do

url="http://cdec.water.ca.gov/dynamicapp/QueryMonthly?s=$line&span=1000months" #define the url endpoint, with the stationID code as a variable

query=$(python3 ca_rainfall_hist.py $url) #set the query command
echo $query #query the CA Dept of Water Resources
echo "$line" #report to stdout

done <$1 #input file is 1st command-line argument
