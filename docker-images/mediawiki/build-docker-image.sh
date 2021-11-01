#!/bin/bash

IMAGENAME=mediawiki
VERSION=2111011533

# Rename ./versions folders first!!!
smwversion="1.36.2-3.2.3"

ARCH=`arch`

# rm -rf versions/*
# mkdir --parents versions/$smwversion
# tar -xzf ${packages[$p]} -C versions/$smwversion

cat require_customizations.sh >> ./versions/$smwversion/LocalSettings.php
echo "Appended require_customizations.sh to ./versions/$smwversion/LocalSettings.php"
echo "{}" > ./versions/$smwversion/composer.local.json
echo "{}" > ./versions/$smwversion/composer.local.lock
echo "Building Docker image $IMAGENAME:${smwversion}_$VERSION-$ARCH"
docker build \
    -t dataspects/$IMAGENAME:${smwversion}_$VERSION-$ARCH \
    --build-arg CURRENTW=./versions/$smwversion \
    --build-arg ARCH=$ARCH \
    .
echo "Pushing Docker image $IMAGENAME:${smwversion}_$VERSION-$ARCH"
docker login
docker push dataspects/$IMAGENAME:${smwversion}_$VERSION-$ARCH