#!/bin/bash

BASE_MEDIAWIKI_ROOT_FOLDER=/var/lib/docker/volumes/dataspectssearch_mediawiki_root/_data/w
MEDIAWIKI_SUNFLOWER_DISTRIBUTION_FOLDER=/media/lex/LEXSAMSUNG-64GB/mediawiki-sunflower-distribution

APACHE_CONTAINER_NAME=dataspectssearch-mediawikiservice

MYSQL_HOST=127.0.0.1
DATABASE_NAME=wikidb
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass

# Get the current LocalSettings.php
cp $BASE_MEDIAWIKI_ROOT_FOLDER/LocalSettings.php \
  $MEDIAWIKI_SUNFLOWER_DISTRIBUTION_FOLDER/install/

# Dump database
#TODO: Add mariadb-client-10.1 to Apache container
docker exec $APACHE_CONTAINER_NAME bash -c \
  "mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_USER_PASSWORD \
  $DATABASE_NAME > /var/www/html/w/db.sql"

# Tar images folder
tar --exclude ".*" \
  --exclude $BASE_MEDIAWIKI_ROOT_FOLDER/LocalSettings.php \
  -czvf $MEDIAWIKI_SUNFLOWER_DISTRIBUTION_FOLDER/install/mediawiki-root-folder.tar.gz \
  $BASE_MEDIAWIKI_ROOT_FOLDER
