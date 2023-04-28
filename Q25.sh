#!/bin/bash
# Write a script that generates and emails a report of newly created user accounts on a Linux system within the last 24 hours
#########################################################################################
#       Script Name : Question -25                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that generates and emails a report of newly        # 
#                    created user accounts on a Linux system within the last 24 hours.  #
#                                                                                       #
#########################################################################################
MAIL_FILE=EMAIL.txt
MAIL_ID=sarang.pardeshi@cloudethix.com
DB_FILE=/root/.USER.db
PASSWD_FILE=/etc/passwd
DVNL=/dev/null

# Defining Mail function here
MAIL () {
echo -e  "Hello Admin,

                 Below is the Report of the newly added users in last 24 hours

                 This is system generated email. Do not reply to this email.

                 Please find the attached document which lists down the user details.

                  `cat $MAIL_FILE`" | mail -s "New User Report" $MAIL_ID
}


if [[ ! -d $DB_FILE ]]
then
        echo -e "Generating DB file"
        cp -p $PASSWD_FILE $DB_FILE
        exit 1
else 
        echo -e "Checking the added users and their count"
        sdiff $DB_FILE $PASSWD_FILE >$DVNL 2>&1
        if [[ $? == 0 ]]
        then
                COUNT=`sdiff $DB_FILE $PASSWD_FILE | grep \< | awk -F ':' '{print $1}' | wc -l`
                echo -e "The $COUNT users were added in last 24 hrs and below are the details"
                echo "USERNAME      UID   GID   HOME_DIR" && sdiff $DB_FILE $PASSWD_FILE | grep \< | awk -F ':' '{print $1,$3,$4,$6}' | column -t >$MAIL_FILE
                MAIL
        else
                echo -e "No new users were added in last 24 hours"
        fi
fi

