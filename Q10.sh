#!/bin/bash
# A shell script that fetches data from an AWS EC2 API and processes the JSON response to print instance IDs and its public and private IP address.
#########################################################################################
#       Script Name : Question -10                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that fetches data from an AWS EC2 API              #
#                     and processes the JSON response to print instance                 #
#                     IDs and its public and private IP address.                        #
#                                                                                       #
#########################################################################################
IN_FILE=FILE.txt
which aws
if [[ $? == 0 ]]
then
        echo -e "AWS_CLI is Installed"
else
        echo "AWS_CLI is not installed"
        read -p "Do you want to install AWS_CLI ( Y | N ) : " INSTALL
        shopt -s nocasematch
        if [[ $INSTALL == "Y" || $INSTALL == "YES" ]]
        then
                echo -e "Installig AWS_CLI... "
                curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
                unzip awscli-bundle.zip
                ./awscli-bundle/install -b ~/bin/aws
        else
                echo -e "Aborted!! Did not install anything."
                exit 1
        fi
fi

aws sts get-caller-identity --output text >/dev/null 2>&1
if [[ $? == 0 ]]
then
        echo -e "AWS is configured!!"
        aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name]" --o text > $IN_FILE
        echo -e "Getting instance information"
        while read line1 line2
        do
            if [[ $line2 == "terminated" ]]
            then
                    echo ""
            else
                    aws ec2 describe-instances | jq -r '.Reservations[]|.Instances[]|[(.Tags[]?|select(.Key=="Name")|.Value), (.Tags[]?|select(.Key=="Group-Name")|.Value),.InstanceId,.PrivateIpAddress,.PublicIpAddress]|@csv'|sort | grep $line1 
            fi
        done < $IN_FILE
else
        echo -e "Unable to find config. Please use <aws configure>"
        exit 1
fi