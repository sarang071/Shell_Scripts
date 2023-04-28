#!/bin/bash
# Write a shell script that performs a search and replace operation on multiple files in a directory.
#########################################################################################
#       Script Name : Question -22                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that performs a search and replace operation        # 
#                     on multiple files in a directory.                                 #
#                                                                                       #
#########################################################################################
WORD=$1
R_WORD=$2
DIR=$3

if [[ $# != 3 ]]
then
        echo -e "Usage: $0 <WORD> <REPLACE_WORD> <DIR>"
        exit 1
fi

grep -ir "$WORD" $DIR >/dev/null 2>&1
if [[ $? -gt 1 ]]
then
        grep -ir "$WORD" $DIR | sed -i "s/$WORD/$R_WORD/gi"
else
        echo -e "Could not find the word $WORD"
fi


