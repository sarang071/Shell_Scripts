#!/bin/bash
#  A shell script that scans a directory for files matching a certain pattern and deletes them.
#########################################################################################
#       Script Name : Question - 9                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that scans a directory for files                   #
#                     matching a certain pattern and deletes them.                      #
#                                                                                       #
#########################################################################################
DIR_PATH=$1
PATTERN=$2
function REMOVE_FILE()
{
    read -p "Do you want to continue and remove the files ( Y | N ) : " CONFIRM
    shopt -s nocasematch
    if [[ $CONFIRM == "y" || $CONFIRM == "yes" ]]
    then
            echo "Deleting the files"
            find $DIR_PATH -iname "$NEW_PATTERN" -exec rm -rf {} \;
    else
            echo -e "Aborted!!!"
            exit 1
    fi
}

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <DIR_PATH> <PATTERN>"
        exit 1
fi


if [[ -d $DIR_PATH ]]
then
        echo -e "The Dir exists"
        if [[ $PATTERN == "txt" || $PATTERN == "png" || $PATTERN == "zip" || $PATTERN == "tar" || $PATTERN == "pdf" ]]
        then
                find $DIR_PATH -iname "*.$PATTERN" >/dev/null 2>&1
                if [[ $? == 0 ]]
                then
                        echo -e "Below are the list of files as per $PATTERN"
                        find $DIR_PATH -iname "*.$PATTERN" -exec ls -lhrt {} \;
                        NEW_PATTERN="*.$PATTERN"
                        REMOVE_FILE $NEW_PATTERN
                else
                        echo -e "Could not find files with Pattern : $PATTERN"
                        exit 1
                fi
        else
                 find $DIR_PATH -iname "$PATTERN.*" >/dev/null 2>&1
                 if [[ $? == 0 ]]
                 then
                        echo -e "Below are the list of files as per $PATTERN"
                        find $DIR_PATH -iname "$PATTERN*.*" -exec ls -lhrt {} \;
                        NEW_PATTERN="$PATTERN*.*"
                        REMOVE_FILE $NEW_PATTERN
                else
                        echo -e "Could not find files with Pattern : $PATTERN"
                        exit 1
                fi
        fi
else
        echo -e "DIR : $DIR_PATH not found. Please check"
        exit 1
fi
