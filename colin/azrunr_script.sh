#!/bin/bash

cd /

mkdir rstudiostartup

cd rstudiostartup

sudo apt-get update

sudo apt-get -y upgrade

sudo add-apt-repository ppa:marutter/rrutter

sudo apt update
sudo apt-get -y install r-base

sudo apt-get -y install apache2

sudo apt-get -y install gdebi-core

wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb

yes | sudo gdebi rstudio-server-1.3.1093-amd64.deb