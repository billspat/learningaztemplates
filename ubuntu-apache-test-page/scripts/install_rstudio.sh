#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

# sudo apt-get install -y apache2
# if [ "$1" = "True" ]; then
# 	if [ "$4" = "16.04.0-LTS" ]; then
# 		sudo apt-get install -y libapache2-mod-php
# 	else
# 		sudo apt-get install -y php5
# 	fi
# 	if [ "$3" = "index.php" ]; then
# 		sudo rm /var/www/html/index.html
# 	fi
# 	sudo service apache2 restart
# fi
# echo $2 | sudo tee /var/www/html/$3


cd /

mkdir rstudiostartup

cd rstudiostartup

sudo add-apt-repository ppa:marutter/rrutter
sudo apt update

sudo apt-get -y install r-base
sudo apt-get -y install apache2

sudo apt-get -y install gdebi-core

wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb

yes | sudo gdebi rstudio-server-1.3.1093-amd64.deb