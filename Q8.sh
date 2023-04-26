#!/bin/bash
#  A script that monitors a list of websites and sends an email notification if any of them are down.
#########################################################################################
#       Script Name : Question - 8                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that monitors a list of websites and sends               #
#                     an email notification if any of them are down.                    #
#                                                                                       #
#########################################################################################

R_FILE=RUNNING.txt
NR_FILE=NOT_RUNNING.txt
IN_FILE=WEBSITES.txt
MAIL_FILE=EMAIL.txt
MAIL_ID=sarang.pardeshi@cloudethix.com

# Defining Mail function here
MAIL () {
echo -e  "Hello Admin,

                 Below is the Report of the staus of the Running and Non-Running Websites!!!!

                 This is system generated email. Do not reply to this email.

                 Please find the attached document which lists down the website names.

                  `cat $MAIL_FILE`" | mail -s "Webiste Status Report" $MAIL_ID
}

echo -e "RUNNING_WEBSITES\n-----------------" > $R_FILE
echo -e "NON-RUNNING_WEBISTES\n-----------------" > $NR_FILE

while read link
do
    CODE=`curl -o /dev/null -s -w "%{http_code}\n" $link`
    if [[ $CODE == 200 ]]
    then
            echo -e "$link" | tee -a $R_FILE
    else
            echo -e "$link" | tee -a $NR_FILE
    fi
done < $IN_FILE

if [[ -f $R_FILE ]] && [[ -f $NR_FILE ]]
then
     paste -d '\n' $R_FILE $NR_FILE | xargs -d '\n' printf '%-30s %-30s\n' >$MAIL_FILE
     echo -e "Sending an Email Report"
     MAIL
else
     echo -e "Did not receive any data about the websites. Please check!!"
     exit 1
fi
rm -rf $R_FILE $NR_FILE
