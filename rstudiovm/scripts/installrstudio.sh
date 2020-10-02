#!/bin/bash

export NEWUSER=rstudio
export NEWUSERPASSWORD=$1
export AZURE_STORAGE_ACCOUNT=$2
export AZURE_CONTAINER=$3
export AZURE_STORAGE_ACCESS_KEY=$4

sudo apt-get update
sudo apt-get -y upgrade

# add a regular linux user for Rstudio to work with 
yes `echo $NEWUSERPASSWORD` | sudo useradd $NEWUSER  -d /home/$NEWUSER
# this is not the same as the admin user set by the Azure template, and is not in the sudoers list.  



sudo su

wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get -y install blobfuse fuse

export MOUNTDIR=/mnt/$AZURE_CONTAINER
export FUSETMP=/mnt/blobfusetmp
mkdir $MOUNTDIR
chown $NEWUSER $MOUNTDIR 
chmod a+rw $FUSETMP

blobfuse /mnt/$MOUNTDIR --container-name=$AZURE_CONTAINER --tmp-path=$FUSETMP
ln -s $MOUNTDIR /home/$NEWUSER/$AZURE_CONTAINER
chown $NEWUSER /home/$NEWUSER/$AZURE_CONTAINER 

cd /

# taken from https://rstudio.com/products/rstudio/download-server/debian-ubuntu/
mkdir rstudiostartup
cd rstudiostartup
# do we need sudo for azure install scripts?
sudo add-apt-repository ppa:marutter/rrutter
sudo apt update

sudo apt-get -y install r-base
# I don't think we need apache2
# sudo apt-get -y install apache2
sudo apt-get -y install gdebi-core

wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb

yes | sudo gdebi rstudio-server-1.3.1093-amd64.deb

# additional packages needed for some R packages
sudo apt-get install jags