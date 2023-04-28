#!/bin/bash
# A shell script that checks whether a specified service is running and restarts it if it's not running.
#########################################################################################
#       Script Name : Question - 3                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2022                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that checks whether a specified service            #
#                         is running and restarts it if it's not running.               #
#                                                                                       #
#########################################################################################
SERVICE=$1

if [[ $# == 1 ]]
then
        echo -e "Checking status for $SERVICE"
else
        echo -e "Usage: $0 <SERVICE NAME>"
        exit 1
fi

systemctl status $SERVICE > /dev/null 2>&1

if [[ $? == 0 ]]
then
        echo -e "The service is installed in the system and below is the status:\n"
        systemctl status $SERVICE | grep -w "Active:"
else
        echo -e "Either the name of the service $SERVICE is incorrect or the service is not installed."
fi
