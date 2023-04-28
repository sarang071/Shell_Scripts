#!/bin/bash
# A shell script that automates the process of setting up a new virtual host on a web server.
#########################################################################################
#       Script Name : Question -12                                                      #
#       Version     : 2.0                                                               #
#       Date        : 25 Apr 2023                                                       #
#       Credit      : Team Cloudethix                                                   #
#       Purpose     : A shell script that automates the process of setting up           # 
#                      up a new virtual host on a web server.                           #
#                                                                                       #
#########################################################################################
#!/bin/bash
DOMAIN=$1

if [[ $# != 1 ]]
then
        echo -e "Usage: $0 <DOMAIN_NAME>"
        exit 1
fi

systemctl start httpd > /dev/null 2>&1
if [[ $? != 0 ]]
then
        echo -e "httpd.service is not installed"     
        echo -e "Installing Apache Web Service"
        yum -y install httpd
else
        echo -e "httpd.service is installed. Starting and enabling it and adding rule in firewall"
fi
        systemctl enable httpd.service
        systemctl start httpd.service
        firewall-cmd --permanent --add-service=http
        firewall-cmd --reload
        echo -e "======================================================="
        echo -e "Making Domain DIR and giving permissions"
        mkdir -p /var/www/$DOMAIN/public_html
        chown -R apache:apache /var/www/$DOMAIN
        chmod -R 755 /var/www
        echo -e "======================================================="
        echo -e "Writing index.html and conf file for the $DOMAIN"
        echo -e "<html>
        <head>
        <title>This is a test page for $DOMAIN</title>
        </head>
        <body>
            <h1>It works!</h1>
        </body>
        </html>" > /var/www/$DOMAIN/public_html/index.html
        
        echo -e "<VirtualHost *:80>
        ServerName www.$DOMAIN
        ServerAlias $DOMAIN
        DocumentRoot /var/www/$DOMAIN/public_html
        ErrorLog /var/www/$DOMAIN/error.log
        CustomLog /var/www/$DOMAIN/requests.log combined
        </VirtualHost>" > /etc/httpd/conf.d/"$DOMAIN".conf
        echo -e "======================================================="
        echo -e "Restarting Service"
        systemctl restart httpd.service