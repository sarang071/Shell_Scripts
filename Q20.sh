#!/bin/bash
# A shell script that retrieves the current weather for a specified location using a weather API.
#########################################################################################
#       Script Name : Question -20                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that retrieves the current weather for               # 
#                     a specified location using a weather API.                         #
#                                                                                       #
#########################################################################################
LOCATION=$1

if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <LOCATION>"
        exit 1
fi

which curl
if [[ $? == 0 ]]
then
        echo -e "Checking weather report for $LOCATION"
        curl wttr.in/~$LOCATION
else
        echo -e "curl command not found. Please check."
fi