#!/bin/bash
# A shell script that lists all files in a specified directory and saves the output to a text file.
#########################################################################################
#       Script Name : Question - 1                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2022                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that lists all files in a specified directory      #
#                     and saves the output to a text file.                              #
#########################################################################################
DIR_PATH=$1
SAVE_FILE=$2

if [[ $# == 2 ]]
then
        echo -e "Checking if the $DIR_PATH exists"
else
        echo -e "Usage: $0 <DIR PATH> <SAVE_FILE>"
        exit 1
fi

if [[ ! -d $DIR_PATH ]]
then
        echo -e "Directory not Found. Please enter the correct path"
else
        echo -e "Directory is found, listing $DIR_PATH and saving ouput in $SAVE_FILE"
        ls -lhrt $DIR_PATH > $SAVE_FILE
fi
