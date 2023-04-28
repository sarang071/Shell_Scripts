#!/bin/bash
# A shell script that monitors a specified file for changes and executes a specific action when the file is modified.
#########################################################################################
#       Script Name : Question -18                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : shell script that monitors a specified file for changes           # 
#                     and executes a specific action when the file is modified.         #
#                                                                                       #
#########################################################################################
TIME=$1
DIR=$2

if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <MINS>"
        exit 1
fi

if [[ -d $DIR ]]
then
        echo -e "Checking files that were changed in $TIME mins"
        
        CHECK=`find $DIR -type f -mmin -$TIME -exec ls -lhrt {} \; | wc -l`
        if [[ $CHECK == 0 ]]
        then
                echo -e "There are no files that we modified $TIME mins ago"
        else
                echo -e "The below files were modified $TIME mins ago"
                find $DIR -type f -mmin -$TIME -exec ls -lhrt {} \;
        fi
else
        echo -e "$DIR not found. Please check!!"
fi