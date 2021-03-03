VERSION=2103030905f

cp -r ../../../mediawiki-manager/mediawiki_root/w w

sudo docker build -t dataspects/php-apache:7.4.7_$VERSION .

# sudo docker login
# sudo docker push dataspects/php-apache:7.4.7_$VERSION