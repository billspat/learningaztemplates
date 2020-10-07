#!/bin/bash

cd /

sudo apt install build-essential
sudo apt install libcurl4-openssl-dev
sudo apt install libsqlite3-dev
sudo apt install pkg-config
sudo apt install git
sudo apt install curl
curl -fsS https://dlang.org/install.sh | bash -s dmd

sudo apt -y install libnotify-dev

source ~/dlang/dmd-2.094.0/activate

git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure
make clean; make;
sudo make install
