#!/bin/bash

BASE_MEDIAWIKI_ROOT_FOLDER=/home/dserver/mediawiki_root
MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER=/home/dserver

APACHE_CONTAINER_NAME=mediawiki

MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass
MYSQL_ROOT_PASSWORD=mysqlpassword

# THIS REQUIRES:
#
#   - docker-compose.yml
#   - mediawiki-root-w-folder.tar.gz

echo "Run docker-compose..."
sudo -S docker-compose down \
  && sudo -S docker-compose up -d \
  && sudo -S chown -R dserver:www-data mediawiki_root
sleep 5
echo "Extract..."
tar -xzvf $MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER/mediawiki-root-w-folder.tar.gz
sleep 5
echo "Move..."
mv home/dserver/mediawiki_root/w $BASE_MEDIAWIKI_ROOT_FOLDER && rm -r home
sleep 5
echo "Create database and user..."
sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
  "mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
  -e \" CREATE DATABASE $DATABASE_NAME;
        CREATE USER '$MYSQL_USER'@'$MYSQL_HOST' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
        GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$MYSQL_USER'@'$MYSQL_HOST'; \""
echo "Import database..."
sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
  "mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
  mediawiki < /var/www/html/w/db.sql"
echo "Update..."
sudo -S docker exec $APACHE_CONTAINER_NAME /bin/bash -c \
  'cd w; php maintenance/update.php'