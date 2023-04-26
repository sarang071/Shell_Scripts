#!/bin/bash
# A shell script that generates a report of system resource usage, including CPU, memory, and disk usage.
#########################################################################################
#       Script Name : Question - 5                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that compresses and archives                             #
#                      log files older than a certain number of days.                   #
#                                                                                       #
#########################################################################################
DAYS=$1

if [[ $# == 1 ]]
then
        echo -e "Checking system resources for $DAYS"
else
        echo -e "Usage: $0  <NUMBER_OF_DAYS> <REPORT_FILE>"
        exit 1
fi

NAME="sa_`date +%d --date="$DAYS days ago"`_logs"

sar -f /var/log/sa/sa$(date +%d --date="$DAYS days ago") -d -r -u >/dev/null 2>&1

if [[ $? == 0 ]]
then
        echo -e "The system has generated logs for the `date '+%d %b' --date="$DAYS days ago"`\n The logs will be printed below"
        sar -f /var/log/sa/sa$(date +%d --date="$DAYS days ago") -d -r -u
        echo -e "Storing the report in a file"
        sar -f /var/log/sa/sa$(date +%d --date="$DAYS days ago") -d -r -u > "$NAME".txt
else
        echo -e "Currently there are no logs for the date: `date '+%d %b' --date="$DAYS days ago"`"
        exit 1
fi
