#!/bin/bash
# 6.Write a script that compresses and archives log files older than a certain number of days.
#########################################################################################
#       Script Name : Question - 5                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     :  Write a script that compresses and archives                      #
#                      log files older than a certain number of days.                   #
#                                                                                       #
#########################################################################################
BACKUP_DIR=$1
NUMBER_OF_DAYS=$2

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <BACKUP_DIR> <NUMBER_OF_DAYS>"
        exit 1
fi

echo -e "Listing the log files that are older than $NUMBER_OF_DAYS of Days"
find /var/log  -type f -mtime -$NUMBER_OF_DAYS -exec ls -lhrt {} \; | awk '{print $9}'


read -p "Please confirm if the files must be copied and taken backup in $BACKUP_DIR ( Y | N ) : " CONFIRMATION

shopt -s nocasematch

NEW_NAME="log_`date '+%d_%b'`_$NUMBER_OF_DAYS_days"

if [[ $CONFIRMATION == y ]]
then
        if [[ -d $BACKUP_DIR ]]
        then
                echo -e "The Backup Dir $BACKUP_DIR is present. Now copying it and compressing the files."
                find /var/log  -type f -mtime -$NUMBER_OF_DAYS -exec cp -pr {} $BACKUP_DIR \;
                tar -cvf "$NEW_NAME".tar $BACKUP_DIR
        else
                echo -e "Directory Not Found!! Please add the $BACKUP_DIR"
                exit 1
        fi
else
        echo -e "Compression Aborted"
        exit 1
fi