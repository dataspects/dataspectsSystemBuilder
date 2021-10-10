IMAGENAME=php-apache:7.4.16_211011

echo "Building Docker image $IMAGENAME"
sudo docker build -t dataspects/$IMAGENAME .

echo "Pushing Docker image $IMAGENAME"
sudo docker login
sudo docker push dataspects/$IMAGENAME