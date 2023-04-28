#!/bin/bash
# A script that calculates the total disk space used by a specified user and outputs the result.
#########################################################################################
#       Script Name : Question -20                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that calculates the total disk space used by       # 
#                     a specified user and outputs the result.                          #
#                                                                                       #
#########################################################################################
USER=$1

if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <LOCATION>"
        exit 1
fi
cat /etc/passwd | grep $USER
if [[ $? == 0 ]]
then
        echo -e " Checking disk usage for $User"
        if [[ $USER == "root" ]]
        then
                find -user $User  -exec du -sh {} \;
        else
                find -user /home/$User  -exec du -sh {} \;
else  
        echo -e "User $USER is not found"
        exit 1
fi    





    