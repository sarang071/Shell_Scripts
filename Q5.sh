#!/bin/bash
# Write a shell script that checks for software updates and installs them automatically.
#########################################################################################
#       Script Name : Question - 5                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 20$PORT                                                    #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     :  Write a shell script that checks for                             #
#                       software updates and installs them automatically.               #
#                                                                                       #                                        
#########################################################################################
OUT_FILE=OP.txt
UPD_FILE=UP.txt
SRV_FILE=SRV.txt
OLD_FILE=OLD.txt
RPT_FILE=REPORT.txt

yum check-updates | tee $OUT_FILE
awk 'NR>6{print $1}' $OUT_FILE >$UPD_FILE
awk -F '.' 'NR>6{print $1}' $OUT_FILE >$SRV_FILE

read -p "Do you want to update all the below packages( Y | N ) :" CONFIRM
echo -e "Please wait. Building Report. It might take a while"

while read line
do
        rpm -qa $line >>$OLD_FILE >/dev/null 2>&1
done <$SRV_FILE

shopt -s nocasematch
if [[ $CONFIRM == "y" ]] || [[ $CONFIRM == "yes" ]]
then
        echo -e "Updating Packages."
        yum update -y
        paste $UPD_FILE $OLD_FILE | column -t > $RPT_FILE
else
        echo -e "Update Aborted"
        exit 1
fi

rm -rf $UPD_FILE $OLD_FILE $SRV_FILE