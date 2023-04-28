#!/bin/bash
# A script that checks for and reports any failed SSH login attempts on a Linux server.
#########################################################################################
#       Script Name : Question -17                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that checks for and reports any failed SSH login         # 
#                     attempts on a Linux server.                                       #
#                                                                                       #
#########################################################################################
MAIL_ID=sarang.pardeshi@cloudethix.com
# Defining Mail function here
MAIL () {
echo -e  "Hello Admin,

                 Below is the Report of the failed SSH login attempts IN $COUNT days!!

                 This is system generated email. Do not reply to this email.

                 Please find the attached document which lists the attempts.

                  `cat $RPT_FILE`" | mail -s "Failed SSH Login Attempts!!!" $MAIL_ID
}

COUNT=$1
RPT_FILE=REPORT.txt

if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <Count of Days>"
        exit 1
fi
CHECK=`find /var/log/secure -mtime -$COUNT -exec grep -i "failed password" /var/log/secure {} \; | wc -l`
if [[ $CHECK == 0 ]]
then
        echo -e "There were no failed SSH login attempts for $COUNT number of days"
else
        echo -e "Below is the data of failed SSH login attempts in past $COUNT days"
        find /var/log/secure -mtime -$COUNT -exec grep -i "failed password" /var/log/secure {} \; | tee $RPT_FILE
        echo -e "Sending Email to Admin"
        MAIL
fi

rm -rf $RPT_FILE