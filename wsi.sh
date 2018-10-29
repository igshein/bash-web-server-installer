#! /bin/bash

printf "You are about to install the program: Git, Nginx, PHP 7.2, Composer, Xdebug, MySQL 8, PostgreSQL, Redis server, Memcached, Node.Js & NPM \n
Press ENTER to continue: \n"
read enter


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
sudo chown -R $USER:$USER /var/www


## PHP
printf "============ Install PHP ============ \n"

# For Debian
sudo apt install ca-certificates apt-transport-https 
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list

# For Ubuntu
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php

sudo apt-get update
sudo apt-get install php7.2
sudo apt-get install php7.2-cli php7.2-common php7.2-curl php7.2-mbstring php7.2-dom php7.2-xml
sudo apt-get install php7.2-fpm php7.2-mysql php-pear php7.2-dev php7.2-gd php7.2-zip
sudo service php7.2-fpm restart


## Composer
printf "============ Install Composer ============ \n"
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
HASH=93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
cd /


## Xdebug for php7.2-fpm
printf "============ Install Xdebug ============ \n"
sudo apt install php-xdebug
sudo sh -c "echo '
zend_extension=xdebug.so
xdebug.show_error_trace = 1

xdebug.default_enable=1
xdebug.remote_port=9000
xdebug.remote_host=127.0.0.1
xdebug.remote_enable=1
xdebug.idekey=IDEA
' >> /etc/php/7.2/mods-available/xdebug.ini"
sudo service php7.2-fpm restart


## MySQL
printf "============ Install MySQL ============ \n"
sudo apt-get install wget -y
sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb && rm -f mysql-apt-config_0.8.10-1_all.deb
sudo apt-get update
sudo apt-get install mysql-community-server -y
## Setting MySQL
## mysql -u root mysql -e "update user set plugin='mysql_native_password' where user='root' and host='localhost'; flush privileges;"
## mysql_secure_installation


## PostgreSQL
printf "============ Install PostgreSQL ============ \n"
sudo apt-get install postgresql postgresql-contrib
sudo apt-get install php7.2-pgsql
sudo service php7.2-fpm restart


## Redis server
printf "============ Install Redis server ============ \n"
sudo apt install redis-server


## Memcached
printf "============ Install Memcached ============ \n"
sudo apt-get install memcached netcat
sudo apt-get install php-memcached
sudo service php7.2-fpm restart


## Node.Js & NPM
printf "============ Install Node.Js & NPM ============ \n"
sudo apt-get update
sudo apt-get install build-essential libssl-dev
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.profile
nvm ls-remote
nvm install 10.0.0
nvm use 10.0.0
cd /


## All install tools
printf "============ Version ============ \n"
git --version
printf "________________________ \n"

nginx -v
printf "________________________ \n"

php -v
printf "________________________ \n"

echo "php7.2-fpm -" && service php7.2-fpm status | grep running
printf "________________________ \n"

composer -V
printf "________________________ \n"

mysql -V
printf "________________________ \n"

psql --version
printf "________________________ \n"

redis-server -v
printf "________________________ \n"

memcached -V
printf "________________________ \n"

node -v
nvm ls
printf "________________________ \n"
