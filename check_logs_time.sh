#!/bin/bash 
# Written by Haider Altimimi 2013
# nagios plugin to check if the file modification time has 
# exceeded the time set in variable MINS_SINCE_UPDATE (in minutes) 


# Needed variables
MINS_SINCE_UPDATE=-360
export FULL_PATH=$1
FILENAME=`echo ${FULL_PATH##*/}`
export LOGDIR=$(dirname $FULL_PATH)


if [ -z $1 ] 
  then 
    usage 
fi 

OUTPUT=`find $LOGDIR -name $FILENAME -mmin $MINS_SINCE_UPDATE | wc -l`
if [ $OUTPUT -eq 0 ] 
 then
   echo "CRITICAL: Log file ($1) has not been updated in 6 hours!"
   exit 1
 else 
   echo "OK: log file ($1) has been updated in the past 6 hours"
   exit 0
fi  


usage() {
echo "Usage: $0 /path/to/log/file.log"  
}
