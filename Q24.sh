#!/bin/bash
# Write a shell script that renames a large number of files based on a specified pattern or naming convention.
#########################################################################################
#       Script Name : Question -24                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that renames a large number of files based on a    # 
#                    specified pattern or naming convention.                            #
#                                                                                       #
#########################################################################################
function LIST()
{
    
    if [[ -d $DIR ]]
    then
            echo -e "Listing the files with $PATTERN\n==========================="
            find $DIR -type f -name "$PATTERN*.*" -exec ls {} \; | tee $IP_FILE
    else
            echo -e "$DIR not Found"
            exit 1
    fi
}

DIR=$1
PATTERN=$2
COUNT=`find $DIR -type f -name "$PATTERN*.*" -exec ls {} \; | wc -l`
IP_FILE=NAMES.txt

if [[ $# != 3 ]]
then
        echo -e "Usage: $0 <WORD> <REPLACE_WORD> <DIR>"
        exit 1
fi

if [[ $COUNT != 0 ]]
then
        LIST
else
        echo -e "There are no files with $PATTERN"
        exit 1
fi

while read line;
do
NAME=`basename $line | awk -F '/' '{print $1}' | awk -F '.' '{print $1}'`
EXT=`basename $line | awk -F '/' '{print $1}' | awk -F '.' '{print $2}'`
NEW=`echo ""$NAME"_"$PATTERN"."$EXT""`
mv $line $NEW
done < file_name.txt