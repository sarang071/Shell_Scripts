#!/bin/bash
# A shell script that adds new users to the system based on a list of names in a CSV file.
#########################################################################################
#       Script Name : Question -11                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that adds new users to the system                  #
#                     based on a list of names in a CSV file.                           #
#                                                                                       #
#########################################################################################
IP_FILE=USERS.csv
OP_FILE=USER_INFO.txt

if [[ ! -f $IP_FILE ]]
then
        echo -e "Please provide the file $IP_FILE"
        exit 1
fi

while IFS=',' read -r line1
do 
        PASSWORD="`openssl rand -base64 12`"
        useradd $line1 >/dev/null 2>&1
        if [[ $? == 0 ]]
        then        
                useradd "$line1" 
                echo "$PASSWORD" | passwd $line1 --stdin
                echo -e "Added User: $line1 and Password: $PASSWORD" >> $OP_FILE
        else
                echo -e "User $line1 exists"
        fi
done <$IP_FILE

