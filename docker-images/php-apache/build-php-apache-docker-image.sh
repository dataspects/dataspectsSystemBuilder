IMAGENAME=php-apache:7.4.16_211011

ARCH=amd64

echo "Building Docker image $IMAGENAME-$ARCH"
sudo docker build -t dataspects/$IMAGENAME-$ARCH .

echo "Pushing Docker image $IMAGENAME-$ARCH"
sudo docker login
sudo docker push dataspects/$IMAGENAME-$ARCH