#!/bin/bash

MEDIAWIKI_ROOT_FOLDER={{ system_root }}/w
MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER=/home/dserver
MEDIAWIKI_CANASTA_ARCHIVE=mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz
MEDIAWIKI_DATABASE_DUMP=db.sql

APACHE_CONTAINER_NAME=mediawiki_canasta

MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# TODO: ADD $wgSiteNotice = '================ MWM Safe Mode ================';

# Dump database
# TODO: Add mariadb-client-10.1 to Apache container
ssh -p 2222 dserver@localhost "sudo -S docker exec $APACHE_CONTAINER_NAME bash -c \
  'mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_USER_PASSWORD \
  $DATABASE_NAME > $SYSTEM_ROOT_FOLDER_IN_CONTAINER/w/$MEDIAWIKI_DATABASE_DUMP'"

# Exclude .git
ssh -p 2222 dserver@localhost "cd $MEDIAWIKI_ROOT_FOLDER && tar --exclude '.*' \
  -czvf $MEDIAWIKI_CANASTA_DISTRIBUTION_FOLDER/$MEDIAWIKI_CANASTA_ARCHIVE *"

# Download
scp -P 2222 dserver@localhost:/home/dserver/$MEDIAWIKI_CANASTA_ARCHIVE .

# Upload
# scp -P 2222 docker-compose.yml \
#   MEDIAWIKI_CANASTA_ARCHIVE \
#   install-distribution-package.sh \
#   dserver@localhost:/home/dserver/