#!/bin/bash
# A script that compares two directories and reports any differences in their content.
#########################################################################################
#       Script Name : Question -12                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that compares two directories and reports any            # 
#                      differences in their content.                                    #
#                                                                                       #
#########################################################################################
#!/bin/bash
DIR_1=$1
DIR_2=$2
OP_FILE=DIFFERNCE.txt

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <DIR_1> <DIR_2>"
        exit 1
fi
if [[ -d $DIR_1 && -d $DIR_2 ]]
then
        echo -e "Checking the difference DIRS $DIR_1 $DIR_2"
        diff -qr $DIR_1 $DIR_2
        echo -e "Storing a detailed output in $OP_FILE"
        sdiff $DIR_1 $DIR_2 >$OP_FILE
else
        echo -e "The DIRs $DIR_1 and/or $DIR2 not found. Please check"
fi
 
