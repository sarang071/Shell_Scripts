#!/bin/bash
# A script that periodically syncs a local directory with a remote server using 'rsync' and 'cron'
#########################################################################################
#       Script Name : Question -12                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that periodically syncs a local directory                # 
#                      with a remote server using 'rsync' and 'cron'                    #
#                                                                                       #
#########################################################################################
LOCAL_DIR=$1
REMOTE_USER=$2
REMOTE_IP=$3
REMOTE_DIR=$4
DVNL=/dev/null
PORT=22
CRON_FILE=/var/spool/cron/root
SCHEDULE=$5

if [[ $# != 4 ]]
then
        echo -e "Usage: $0 <LOCAL_DIR> <REMOTE_USER> <REMOTE_IP> <REMOTE_DIR>"
        exit 1
fi

if [[ -d $LOCAL_DIR ]]
then
        echo -e "Found the $LOCAL_DIR."
        echo -e "Checking if the port $PORT is open"
        nc -zvw5 $REMOTE_IP $PORT > $DVNL 2>&1
        if [[ $? == 0 ]]
        then
            echo -e "Port $PORT is reachable. Checking Password-less Authenication"
            ssh -o 'PreferredAuthentications=publickey' -o StrictHostKeyChecking=no $REMOTE_IP@$REMOTE_IP "echo" > $DVNL 2>&1
            if [[ $? == 0 ]]
            then
               echo -e "Backing up the data."
               rsync -avzh $LOCAL_DIR $REMOTE_USER@$REMOTE_IP:$REMOTE_DIR
               echo -e "Backup of $LOCAL_DIR is Completed!!"
               echo -e "$SCHEDULE /root/scripts/Q12.sh $LOCAL_DIR $REMOTE_USER $REMOTE_IP $REMOTE_DIR" >>$CRON_FILE
            else
                echo -e "Please enable Password-less Authenication"
            fi
        else
            echo -e "Port $PORT is not reachable. Please Check."
        fi
else
        echo -e "Directory $LOCAL_DIR not found in the local system. Please recheck."
fi