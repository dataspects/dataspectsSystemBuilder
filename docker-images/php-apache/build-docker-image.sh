VERSION=2103031212incsamo

echo "Remove existing w..."
sudo rm -rf w

echo "Copy MWMSafeMode wiki..."
sudo cp -r ../../../mediawiki-manager/mediawiki_root/w w

echo "Building Docker image..."
sudo docker build -t dataspects/php-apache:7.4.7_${VERSION} .

# sudo docker login
# sudo docker push dataspects/php-apache:7.4.7_${VERSION}