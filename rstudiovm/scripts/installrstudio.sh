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

## install
sudo wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get -y install blobfuse fuse

# main mount point 
export FUSEMOUNT=/mnt/$AZURE_CONTAINER

export FUSETMP=/mnt/blobfusetmp

##  optional use RAM disk for blobfuse buffer performance if needed
# see https://docs.microsoft.com/en-us/azure/storage/blobs/storage-how-to-mount-container-linux
# sudo mkdir -p /mnt/ramdisk
# sudo mount -t tmpfs -o size=16g tmpfs /mnt/ramdisk
# sudo mkdir -p /mnt/ramdisk/blobfusetmp
# sudo chown $USERID /mnt/ramdisk/blobfusetmp
# export FUSETMP=/mnt/ramdisk/blobfusetmp

sudo mkdir -p $FUSEMOUNT
sudo mkdir -p $FUSETMP


# create the config file that we'll use for blob fuse
echo -e "accountName $AZURE_STORAGE_ACCOUNT \naccountKey $AZURE_STORAGE_ACCESS_KEY \ncontainerName $AZURE_CONTAINER" > /tmp/bfconfig

# create the mounting script

export BFCONFIGFILE=/etc/blobfuse/${USERID}config  

sudo mkdir -p /etc/blobfuse  # use basedir here 
sudo chmod a+r /etc/blobfuse

sudo mv /tmp/bfconfig $BFCONFIGFILE
sudo chown $USERID $BFCONFIGFILE
sudo chmod 600 $BFCONFIGFILE  # only for this user

sudo chown $USERID $FUSEMOUNT 
sudo chown $USERID $FUSETMP 

echo "#!/bin/bash" | sudo tee -a /usr/bin//blobmount.sh
echo "blobfuse \$1 --tmp-path=$FUSETMP --use-attr-cache=true -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 --config-file=$BFCONFIGFILE" \
  | sudo tee -a /usr/bin//blobmount.sh

sudo chmod a+rx /usr/bin/blobmount.sh
echo  "blobmount.sh $FUSEMOUNT fuse defaults,_netdev 0 0" > sudo tee -a /etc/fstab
sudo mount -a
# run as current user.  that measn this mount only works with the current user

# blobfuse $FUSEMOUNT --tmp-path=$FUSETMP \
#    -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 \
#    --config-file=$BFCONFIGFILE

# blobfuse /mnt/$MOUNTDIR --container-name=$AZURE_CONTAINER --tmp-path=$FUSETMP
# add the /mnt dir as a short cut in the user home dir for easy access via rstudio
sudo ln -s $FUSEMOUNT $USERHOME/$AZURE_CONTAINER
sudo chown $USERID $USERHOME/$AZURE_CONTAINER

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