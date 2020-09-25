#!/bin/bash


# set up a silent install of MySQL
passed_var=$1

# echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/" >> /etc/apt/sources.list 
# apt-get -y update
# apt-get install r-base r-base-dev
# export DEBIAN_FRONTEND=noninteractive
# echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
# echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install the LAMP stack
apt-get -y install apache2  

# mkdir -p /var/www/html/ 

# # write some PHP
# echo \<center\>\<h1\>My Demo App\</h1\>\<br/\>\</center\> > /var/www/html/index.php
# echo "<p>Passed Variable = $passed_var" >> /var/www/html/index.php
# echo \<\?php phpinfo\(\)\; \?\> >> /var/www/html/index.php

apachectl restart
