#!/bin/bash

# RUN THIS MANUALLY ON dserver@dserver:~$

MEDIAWIKI_ROOT_FOLDER=/home/dserver/system_root/w
MEDIAWIKI_DISTRIBUTION_FOLDER=/home/dserver
MEDIAWIKI_ARCHIVE=dataspects-mediawiki-root-w-folder-1.36.2-3.2.3.tar.gz
MEDIAWIKI_DATABASE_DUMP=db.sql

APACHE_CONTAINER_NAME=mediawiki

MYSQL_HOST=mariadb
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass

# Dump database
docker exec $APACHE_CONTAINER_NAME bash -c \
  "mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_USER_PASSWORD \
  $DATABASE_NAME > /var/www/html/w/$MEDIAWIKI_DATABASE_DUMP"

# Exclude .git
cd $MEDIAWIKI_ROOT_FOLDER && tar --exclude '.*' \
  -czvf $MEDIAWIKI_DISTRIBUTION_FOLDER/$MEDIAWIKI_ARCHIVE *

# Download
# scp -P 2222 dserver@localhost:/home/dserver/$MEDIAWIKI_ARCHIVE .

# Upload
# scp -P 2222 docker-compose.yml \
#   MEDIAWIKI_ARCHIVE \
#   install-distribution-package.sh \
#   dserver@localhost:/home/dserver/