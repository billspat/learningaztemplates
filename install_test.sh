#!/bin/bash
apt-get -y update

# set up a silent install of MySQL
passed_var=$1

export DEBIAN_FRONTEND=noninteractive
# echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
# echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install the LAMP stack
apt-get -y install apache2 php5 

mkdir -p /var/www/html/

# write some PHP
echo \<center\>\<h1\>My Demo App\</h1\>\<br/\>\</center\> > /var/www/html/index.php
echo "<p>Passed Variable = $passed_var" >> /var/www/html/index.php
echo \<\?php phpinfo\(\)\; \?\> >> /var/www/html/index.php

# restart Apache
apachectl restart
