#!/bin/bash

BASE_MEDIAWIKI_ROOT_FOLDER=/home/dserver/mediawiki_root
MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER=/home/dserver

APACHE_CONTAINER_NAME=mediawiki

MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass
MYSQL_ROOT_PASSWORD=mysqlpassword

# scp -P 2222 docker-compose.yml dserver@localhost:/home/dserver/

# ssh -p 2222 dserver@localhost "sudo -S docker-compose up -d"

# ssh -p 2222 dserver@localhost "sudo -S chown -R dserver:www-data mediawiki_root"

# scp -P 2222 mediawiki-root-w-folder.tar.gz dserver@localhost:/home/dserver/

# ssh -p 2222 dserver@localhost "tar \
#   -xzvf $MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER/mediawiki-root-w-folder.tar.gz"

# ssh -p 2222 dserver@localhost "mv /home/dserver/home/dserver/mediawiki_root/w \
#   $BASE_MEDIAWIKI_ROOT_FOLDER"

# ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
#   'mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
#   -e \"CREATE DATABASE mediawiki;\"'"

# ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
#   'mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
#   -e \"CREATE USER 'mediawiki'@'localhost' IDENTIFIED BY 'mediawikipass';\"'"

# ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
# 'mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
# -e \"GRANT ALL PRIVILEGES ON mediawiki.* TO 'mediawiki'@'localhost';\"'"

# ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
#   'mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD \
#   mediawiki < /var/www/html/w/db.sql'"

ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME /bin/bash -c \
  'cd w; php maintenance/update.php'"