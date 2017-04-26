#!/bin/bash

apt-get update
apt-get install -y php7.0-fpm php7.0-pgsql php7.0-curl php7.0-gd php7.0-xmlrpc php7.0-intl

service nginx restart
service php7.0-fpm restart

git clone --depth=1 -b MOODLE_32_STABLE git://git.moodle.org/moodle.git /var/www/moodle
chown -R root /var/www/moodle
chmod -R 0755 /var/www/moodle
find /var/www/moodle -type f -exec chmod 0644 {} \;

sudo -u postgres psql -c "CREATE USER moodleuser WITH PASSWORD 'dhis'"
sudo -u postgres psql -c "CREATE DATABASE moodle WITH OWNER moodleuser"


mkdir -p /var/moodledata
chmod 0777 /var/moodledata

cp ./config.php /var/www/moodle/
