#!/bin/bash

# azure vm setup script.  adds blobfuse connection for current user, which must be in sudoers

#===  expected params
export USERID=$1
export USERPASSWORD=$2  # password for the admin user sent by template, which uses ssh key
export AZURE_STORAGE_ACCOUNT=$3
export AZURE_CONTAINER=$4
export AZURE_STORAGE_ACCESS_KEY=$5


#======USER======
export USERHOME=/home/$USERID

# if the user id does not exist yet, create it
#if id "$USERID" &>/dev/null; then
#    echo "$USERID exists"
#else
sudo useradd $USERID -m
#fi

yes $USERPASSWORD | sudo passwd $USERID

#====system update=====
# TODO combine these operations with the apt-get updates below
sudo apt-get update
sudo apt-get -y upgrade

# Linux packages needed for tidyverse and Jags R packages
sudo apt-get -y install libxml2-dev  libssl-dev libcurl4-openssl-dev jags

cd /usr/local/src

#===== BLOBFUSE ======
# check if this is true:
#  Just a note - blobfuse needs to store the entire file contents on the disk while the file is open. If you don't have space, things will stop working.
# this is terrible if the container is large, then this is not a good solution for a remote disk

sudo wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get -y install blobfuse fuse

export MOUNTDIR=/mnt/$AZURE_CONTAINER
export FUSETMP=/mnt/blobfusetmp

# create the config file that we'll use for blob fuse
echo -e "accountName $AZURE_STORAGE_ACCOUNT \naccountKey $AZURE_STORAGE_ACCESS_KEY \ncontainerName $AZURE_CONTAINER" > $HOME/bfconfig

export BFCONFIGFILE=/etc/blobfuse/${USER}config

sudo mkdir /etc/blobfuse  # use basedir here
sudo chmod a+r /etc/blobfuse

sudo mv ~/bfconfig $BFCONFIGFILE
sudo chown $USER $BFCONFIGFILE
sudo chmod 600 $BFCONFIGFILE  # only for this user

sudo mkdir -p $MOUNTDIR
sudo chown $USERID $MOUNTDIR
sudo chown $USERID $FUSETMP

# run as current user.  that measn this mount only works with the current user

blobfuse $MOUNTDIR --tmp-path=/mnt/blobfusetmp \
   -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 \
   --config-file=$BFCONFIGFILE

# blobfuse /mnt/$MOUNTDIR --container-name=$AZURE_CONTAINER --tmp-path=$FUSETMP
# add the /mnt dir as a short cut in the user home dir for easy access via rstudio
sudo ln -s $MOUNTDIR $HOME/$AZURE_CONTAINER
sudo chown $USERID $HOME/$AZURE_CONTAINER



#===== R & Rstudio ======


# taken from https://rstudio.com/products/rstudio/download-server/debian-ubuntu/

mkdir ~/rstudiostartup
cd rstudiostartup

sudo add-apt-repository ppa:marutter/rrutter
sudo apt update

sudo apt-get -y install r-base

sudo apt-get -y install gdebi-core

sudo wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb

yes | sudo gdebi rstudio-server-1.3.1093-amd64.deb

# additional dependencies for packages needed for some R packages
Rscript -e "install.packages(c('renv','tidyverse','jagsui'))"  # a package manager

#===== OneDrive ======

cd /
export HOME=/
sudo apt install build-essential
sudo apt install libcurl4-openssl-dev
sudo apt install libsqlite3-dev
sudo apt install pkg-config
sudo apt install git
sudo apt install curl
#curl -fsS https://dlang.org/install.sh | bash -s dmd
curl -fsS https://dlang.org/install.sh | bash -s ldc

sudo apt -y install libnotify-dev

#sudo chmod +rwx dlang/dmd-2.094.1
#sudo chmod +x dlang/dmd-2.094.1/activate

#./dlang/dmd-2.094.1/activate

#git clone https://github.com/abraunegg/onedrive.git
#cd onedrive
#./configure
#make clean; make;
#sudo make install
sudo chmod +rwx dlang/ldc-1.24.0
git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure DC=~/dlang/ldc2-1.24.0/bin/ldmd2
make clean; make
sudo make install

