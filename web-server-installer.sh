#! /bin/bash

printf "You are about to install the program: Git, Nginx, PHP. \n
Press ENTER to continue: \n"
read enter

## Git
sudo apt-get update
sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext \ libz-dev libssl-dev
sudo apt-get install git
git config --global credential.helper "cache --timeout=86400"


## All install tools
git --version
