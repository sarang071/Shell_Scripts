#!/bin/bash
# A shell script that automatically organizes files in a directory based on their file types (e.g., images, documents, audio files)..
#########################################################################################
#       Script Name : Question -16                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that automatically organizes files in a directory  # 
#                     based on their file types (e.g., images, documents, audio files)  #
#                                                                                       #
#########################################################################################
#!/bin/bash
DIR=$1
TYPE=$2
OP_FILE=SORT.txt

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <DIR>"
        exit 1
fi
if [[ -d $DIR ]]
then
        if [[ $TYPE == "Image" || "Compress" || "Docs" ]]
        then
                if [[ $TYPE == "Image" ]]
                then
                        find $DIR -type f \( -name "*.png" -o -name "*.jpeg" -o -name "*.jpg" -o -name "*.mp4" \) >$OP_FILE
                        sort $OP_FILE
                elif [[ $TYPE == "Compress" ]]
                then
                        find $DIR -type f \( -name "*.tar" -o -name "*.zip" -o -name "*.tar.bz2" -o -name "*.tar.gz" \) >$OP_FILE
                        sort $OP_FILE
                elif [[ $TYPE == "Docs" ]]
                then
                        find $DIR -type f \( -name "*.txt" -o -name "*.doc" -o -name "*.docs" -o -name "*.pdf" \) >$OP_FILE
                        sort $OP_FILE
                else
                        exit 1
                fi
        else
                echo -e "Please provide valid file type from <Image> | <Compress> | <Docs>"
        fi
else
        echo -e "Dir $DIR not found. Please check."
fi
