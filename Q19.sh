#!/bin/bash
# A script that automates the process of creating a new MySQL database, user, and granting privileges.
#########################################################################################
#       Script Name : Question -19                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A script that automates the process of creating a new             # 
#                     MySQL database, user, and granting privileges.                    #
#                                                                                       #
#########################################################################################
function CHECK_USER()
{
  mysql -u root -p "root" -e "SELECT * FROM mysql.user WHERE user = '$USERNAME'" >/dev/null 2>&1 
  if [[ $? == 0 ]] 
                then
                        echo -e "$USERNAME is already present."
                else
                        echo -e "Creating USER $USERNAME"
                        $PASS=root
                        mysql -u root -p root -e "CREATE USER '$USERNAME'@'localhost' IDENTIFIED BY '$PASS';"
                        echo -e "Granting previleges for $DB_NAME to $USERNAME"
                        mysql -u root -p root -e "GRANT ALL ON $DB_NAME.* TO "$USERNAME"@'localhost' IDENTIFIED BY "$PASS" WITH GRANT OPTION;"
                fi  
}

IP=`ifconfig | awk 'NR<3{print $2}' | awk 'NR>1{print $1}'`
PORT=3306
DB_NAME=$1
USERNAME=$2

if [[ $# != 2 ]]
then
        echo -e "Usage: $0 <DB_NAME> <USERNAME>"
        exit 1
fi
which mysql
if [[ $? == 0 ]]
then
        echo -e "Mysql/MariaDb is installed.Checking if service is working"
        nc -zvw5 $IP $PORT > /dev/null 2>&1
        if [[ $? == 0 ]]
        then
                echo -e "Port $PORT is reachable.Checking Login"
                mysql -u "root" -p "root" -e "SHOW DATABASES" >/dev/null 2>&1
                if [[ $? == 0 ]]
                then
                        echo -e "Login is Successful!!"
                        RESULT=`mysqlshow --user=root --password=root $DB_NAME| grep -v Wildcard | grep -o $DB_NAME`
                        if [[ $RESULT == $DB_NAME ]] 
                        then
                                echo -e "$DB_NAME is already present."
                                CHECK_USER
                        else
                                echo -e "Creating Database $DB_NAME"
                                mysql -u $USER -p $PASSWORD -e "create database $DB_NAME;"
                                CHECK_USER
                        fi
                else
                        echo -e "We are unable to login. Please check"
                        exit 1
                fi
        else
                echo -e "The Service/Port is not Active"
                exit 1
        fi
else
        echo -e "Mysql/MariaDb is not installed. Please install."
        exit 1
fi