#!/bin/bash
# A shell script that finds and lists all files in a directory tree that have not been accessed in a specified number of days.
#########################################################################################
#       Script Name : Question -15                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that finds and lists all files in a directory      # 
#                     tree that have not been accessed in a specified number of days.   #
#                                                                                       #
#########################################################################################
#!/bin/bash
DIR=$1
DAYS=$2

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <DIR> <DAYS>"
        exit 1
fi

if [[ -d $DIR ]]
then
        echo -e "Checking $DIR for files that have not be accessed in $DAYS days"
        CHECK=`find /var/log/ -type f -atime +$DAYS -exec ls -lhrt {} \; | wc -l`
        if [[ $CHECK == 0 ]]
        then
                echo -e "There are no files in $DIR that were not accessed in $DAYS days"
        else
                echo -e "Below is the list of files from $DIR that were not accessed in $DAYS days"
                find /var/log/ -type f -atime +$DAYS -exec ls -lhrt {} \;
        fi
else
        echo -e "$DIR not found. Please check"
        exit 1
fi