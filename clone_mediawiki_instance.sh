#!/bin/bash

generalMariaDBIPfromHost=127.0.0.1

originalMariaDBIPOnDockerNetwork=172.20.0.5
originalMariaDBPortOnHost=3306
originalDatabaseName=smwckdatabase
originalDatabaseDumpfileName=smwckdatabase.sql

originalApacheContainerName=smwckApache
originalmediawikiRootDirectoryOnHost=/home/smwckmain/Restored_SMWCK
originalmediawikiApacheVirtualHostFileOnHost=/home/smwckmain/000-default.conf

#############################################################################

newID=3

newMariaDBContainerImage=mariadb:10.3.6
newMariaDBContainerName=smwckDB$newID
newMariaDBContainerIP=172.20.0.4$newID
newMariaDBPortOnHost=3306$newID
newMariaDBDataDirectoryOnHost=/opt/mysql_data$newID
newMariaDBDatabaseName=smwckdatabase$newID

newApacheContainerImage=dataspects/apache5.6:180529
newApacheContainerName=smwckApache$newID
newApacheContainerIP=172.20.0.7$newID
newmediawikiRootDirectoryOnHost=/home/smwckmain/Restored_SMWCK$newID
newmediawikiApacheVirtualHostFileOnHost=/home/smwckmain/000-default$newID.conf
newApacheContainerPortOnHost=8$newID

#############################################################################

sudo docker stop $originalApacheContainerName
sudo cp -rp $originalmediawikiRootDirectoryOnHost $newmediawikiRootDirectoryOnHost
sudo cp -rp $originalmediawikiApacheVirtualHostFileOnHost $newmediawikiApacheVirtualHostFileOnHost
sudo docker start $originalApacheContainerName

sudo mysqldump \
  --password=password \
  --user=root \
  --host=$generalMariaDBIPfromHost \
  --port=$originalMariaDBPort \
  --complete-insert \
  --add-drop-database \
  --add-drop-table \
  --compact \
  --create-options \
  --no-create-db \
  --result-file=$newmediawikiRootDirectoryOnHost/$originalDatabaseDumpfileName \
$originalDatabaseName

sudo docker run \
  --network myNetwork0 \
  --ip=$newMariaDBContainerIP \
  --name=$newMariaDBContainerName \
  --publish $newMariaDBPortOnHost:3306 \
  --volume $newMariaDBDataDirectoryOnHost:/var/lib/mysql \
  --env MYSQL_ROOT_PASSWORD=password \
  --detach \
$newMariaDBContainerImage

while
  ! mysqladmin ping --user=root --password=password --host=$generalMariaDBIPfromHost --port=$newMariaDBPortOnHost --silent
do
  sleep 3
done

sudo mysql \
  --host=$generalMariaDBIPfromHost \
  --user=root \
  --password=password \
  --port=$newMariaDBPortOnHost \
  --execute="CREATE DATABASE $newMariaDBDatabaseName;"

sudo mysql \
  --host=$generalMariaDBIPfromHost \
  --user=root \
  --password=password \
  --port=$newMariaDBPortOnHost \
$newMariaDBDatabaseName < $newmediawikiRootDirectoryOnHost/$originalDatabaseDumpfileName

sudo sed -i "s/^\$wgDBserver = '$originalMariaDBIPOnDockerNetwork';$/\$wgDBserver = '$newMariaDBContainerIP';/" $newmediawikiRootDirectoryOnHost/LocalSettings.php
sudo sed -i "s/^\$wgDBname = '$originalDatabaseName';$/\$wgDBname = '$newMariaDBDatabaseName';/" $newmediawikiRootDirectoryOnHost/LocalSettings.php

sudo docker run \
  --network myNetwork0 \
  --ip $newApacheContainerIP \
  --publish $newApacheContainerPortOnHost:80 \
  --volume $newmediawikiRootDirectoryOnHost:/var/www/html/m \
  --volume $newmediawikiApacheVirtualHostFileOnHost:/etc/apache2/sites-available/000-default.conf \
  --name $newApacheContainerName \
  --detach \
$newApacheContainerImage
