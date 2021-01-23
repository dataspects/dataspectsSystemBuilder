#!/bin/bash

SYSTEM_ROOT_FOLDER=/home/lex/Canasta # No trailing / !
SYSTEM_ROOT_FOLDER_OWNER=lex

####################################

APACHE_CONTAINER_NAME=mediawiki_canasta
MYSQL_HOST=127.0.0.1
DATABASE_NAME=mediawiki
MYSQL_USER=mediawiki
MYSQL_USER_PASSWORD=mediawikipass
MYSQL_ROOT_PASSWORD=mysqlpassword

# THIS REQUIRES:
#
#   - docker-compose.yml
#   - mediawiki-root-w-folder.tar.gz

requiredFiles=( "docker-compose.yml" "mediawiki-root-w-folder.tar.gz" )

for file in "${requiredFiles[@]}"
do
  if [ ! -e "$file" ]; then
    echo "$file is missing!"
    exit 1
  fi
done

echo "Run docker-compose..."
sudo -S docker-compose down \
  && sudo -S docker-compose up -d \
  && sudo -S chown -R $SYSTEM_ROOT_FOLDER_OWNER:www-data mediawiki_root
sleep 5
echo "Extract..."
tar -xzvf $SYSTEM_ROOT_FOLDER/mediawiki-root-w-folder.tar.gz
sleep 5
echo "Move..."
mv home/dserver/mediawiki_root/w $SYSTEM_ROOT_FOLDER/mediawiki_root && rm -r home
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

echo "http://localhost:80"