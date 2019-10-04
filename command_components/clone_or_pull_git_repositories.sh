#!/bin/bash

for url in "${REPOSITORIES[@]}"
do
  x=$(basename "$url"); name=${x//.git/}
  location=$RESOURCES_PATH/$name
  if cd $location; then
    echo "Pulling $url in $location..."
    git pull
    cd -
  else
    echo "Cloning $url into $location..."
    git clone $url $location
  fi
done
