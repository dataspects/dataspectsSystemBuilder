#!/bin/bash

MEDIAWIKI_ROOT_FOLDER=/home/dserver/mediawiki_root/w
MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER=/home/dserver
MEDIAWIKI_DISTRIBUTION_ARCHIVE=mediawiki-root-w-folder.tar.gz
MEDIAWIKI_DATABASE_DUMP=db.sql

APACHE_CONTAINER_NAME=mediawiki

MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass

# Dump database
# TODO: Add mariadb-client-10.1 to Apache container
ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
  'mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_USER_PASSWORD \
  $DATABASE_NAME > /var/www/html/w/$MEDIAWIKI_DATABASE_DUMP'"

# Exclude .git
ssh -p 2222 dserver@localhost "cd $MEDIAWIKI_ROOT_FOLDER && tar --exclude '.*' \
  -czvf $MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER/$MEDIAWIKI_DISTRIBUTION_ARCHIVE *"

# Download
# scp -P 2222 dserver@localhost:/home/dserver/$MEDIAWIKI_DISTRIBUTION_ARCHIVE .

# Upload
# scp -P 2222 docker-compose.yml \
#   MEDIAWIKI_DISTRIBUTION_ARCHIVE \
#   install-distribution-package.sh \
#   dserver@localhost:/home/dserver/