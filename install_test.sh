#!/bin/bash
passed_var=$1


echo "script argument is $passed_var"

 apt-get update
 apt-get -y --no-install-recommends install dirmngr gnupg software-properties-common
 apt-get -y dist-upgrade
 
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
 # apt-add-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"
 
 apt-get update
 apt-get -y --no-install-recommends install apache2
 rm -rf /var/lib/apt/lists/*

 echo "echo VM created via azure template" >> /etc/bash.bashrc


