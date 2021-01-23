#!/bin/bash

BASE_MEDIAWIKI_ROOT_FOLDER=/home/dserver/mediawiki_root/w
MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER=/home/dserver

APACHE_CONTAINER_NAME=mediawiki

MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass

# Dump database
# TODO: Add mariadb-client-10.1 to Apache container
ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
  'mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_USER_PASSWORD \
  $DATABASE_NAME > /var/www/html/w/db.sql'"

# Exclude .git
ssh -p 2222 dserver@localhost "tar --exclude '.*' \
  -czvf $MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER/mediawiki-root-w-folder.tar.gz \
  $BASE_MEDIAWIKI_ROOT_FOLDER"

# Download
scp -P 2222 dserver@localhost:/home/dserver/mediawiki-root-w-folder.tar.gz .

# Upload
# scp -P 2222 docker-compose.yml \
#   mediawiki-root-w-folder.tar.gz \
#   install-distribution-package.sh \
#   dserver@localhost:/home/dserver/