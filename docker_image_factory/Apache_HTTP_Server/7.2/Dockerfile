# Develop
#
#   /vagrant/apache$ docker stop dsApache ; docker rm dsApache ; docker rmi dataspects/apache
#   /vagrant/apache$ docker build -t dataspects/apache .
#   Run by https://smw-cindykate.com/main/Component0272684347#Functional_Model

# https://store.docker.com/images/php
FROM php:7.2-apache
RUN apt-get update && apt-get install -y curl ldap-utils libldap2-dev libtidy-dev libpng-dev zip unzip wget inetutils-ping mariadb-client-core-10.1
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install gd
RUN docker-php-ext-install tidy
RUN docker-php-ext-install ldap
COPY install-composer.sh /
RUN /install-composer.sh
RUN mv composer.phar /usr/local/bin/composer
