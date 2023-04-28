#!/bin/bash
# Write a shell script that sends a daily summary of system logs via email.
#########################################################################################
#       Script Name : Question -20                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that calculates the total disk space used by       # 
#                     a specified user and outputs the result.                          #
#                                                                                       #
#########################################################################################
MAIL_FILE=/logs/daily_log_$DATE
MAIL_ID=sarang.pardeshi@cloudethix.com

# Defining Mail function here
MAIL () {
echo -e  "Hello Admin,

                 Below is the Report of the staus of the Running and Non-Running Websites!!!!

                 This is system generated email. Do not reply to this email.

                 Please find the attached document which lists down the website names.

                  " | mail -s "Webiste Status Report" $MAIL_ID < $MAIL_FILE
}
if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <Number Of Days>"
        exit 1
fi

DAYS=$1
DATE=`date '+%b %d' --date="$DAYS days ago"`
grep -w "$Date" /var/log/messages >/dev/null 2>&1
if [[ $? == 0 ]]
then
        echo -e "Extracting data at `date '+%d of %B %T' --date="$DAYS days ago"`"
        echo -e "===================================================="
        grep -w "$DATE" /var/log/messages > $MAIL_FILE
        ls -lhrt /logs/
else
        echo -e "Usage: $0 "
        exit 1
fi
