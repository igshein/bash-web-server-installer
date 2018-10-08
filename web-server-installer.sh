#! /bin/bash

printf "You are about to install the program: Git, Nginx, PHP. \n
Press ENTER to continue: \n"
read enter


## Set variable
userName=igor

## Preparing to install
sudo apt update
sudo apt upgrade



## Git
printf "============ Install Git ============ \n"
sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext \ libz-dev libssl-dev
sudo apt-get install git
git config --global credential.helper "cache --timeout=86400"


## Nginx
printf "============ Install Nginx ============ \n"
sudo apt install nginx
sudo chown -R $userName:$userName /var/www


## PHP
printf "============ Install PHP ============ \n"

sudo apt install ca-certificates apt-transport-https 
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update

sudo apt-get install php7.2
sudo apt-get install php7.2-cli php7.2-common php7.2-curl php7.2-mbstring php7.2-dom php7.2-xml
sudo apt-get install php7.2-fpm php-pear php7.2-dev php7.2-gd php7.2-zip
sudo service php7.2-fpm restart


## Composer
## 


## Xdebug
## 


## MySQL
printf "============ Install MySQL ============ \n"
sudo apt install mysql-server
sudo apt-get install php7.2-mysql
sudo service php7.2-fpm restart


## PostgreSQL
printf "============ Install PostgreSQL ============ \n"
sudo apt-get install postgresql postgresql-contrib
sudo apt-get install php7.2-pgsql
sudo service php7.2-fpm restart


## All install tools
printf "============ Version ============ \n"
git --version
printf "_______ \n"
nginx -v
printf "_______ \n"
php -v
printf "_______ \n"
mysql -V
printf "_______ \n"
psql --version
printf "_______ \n"
