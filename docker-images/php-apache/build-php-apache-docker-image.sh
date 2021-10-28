#!/bin/bash

IMAGENAME=php-apache:7.4.16_211011

ARCH=`arch`

echo "Building Docker image $IMAGENAME-$ARCH"
docker build -t dataspects/$IMAGENAME-$ARCH .

echo "Pushing Docker image $IMAGENAME-$ARCH"
docker login
docker push dataspects/$IMAGENAME-$ARCH