#!/bin/bash
# A shell script to monitor disk usage and send an email alert if usage exceeds a specified threshold.
#########################################################################################
#       Script Name : Question - 2                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2022                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script to monitor disk usage and send an email            #
#                     alert if usage exceeds a specified threshold.                     #
#########################################################################################

# Defining your function here
MAIL () {
echo -e  "Hello Admin,

                 Disk Space Alert!!!!

                 This is system generated email. Do not reply to this email

                 Your root partition remaining free space is critically low.

                  `cat EMAIL.txt`" | mail -s "Disk Space Alert!!!!" sarang.pardeshi@cloudethix.com
}

df -h | grep ^/dev/ | awk '{print $1" "$5}' | awk -F '%' '{print $1}' | while read line1 line2
do
        echo -e "Checking Disk Space"
        if [[ $line2 -gt "75" ]]
        then
                echo -e " Used: $line1 --> $line2%" >> EMAIL.txt
        else
                echo -e "There is space available in the $line1 and it is $line2"
        fi
done
if [[ ! -f EMAIL.txt ]]
then
        echo -e "All Disks are Healthy!!!"
else
        echo -e "Sending Disk Space Alert!!!! to Admin"
        MAIL
fi
rm -rf EMAIL.txt
