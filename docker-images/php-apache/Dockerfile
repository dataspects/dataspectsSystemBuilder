FROM php:7.4.14-apache

RUN apt-get update && apt-get install -y \
  restic \
  imagemagick \
  ghostscript \
  xpdf-utils \
  curl \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  ldap-utils \
  libldap2-dev \
  libtidy-dev \
  libpng-dev \
  libzip-dev \
  zip \
  unzip \
  wget \
  inetutils-ping \
  mariadb-client \
  git \
  lynx \
  vim \
  certbot \
  libicu-dev \
  python3 && \
  rm -rf /var/lib/apt/lists/* && \
  a2enmod rewrite && \
  docker-php-ext-install intl && \
  docker-php-ext-install zip && \
  docker-php-ext-install opcache && \
  docker-php-ext-install mysqli && \
  docker-php-ext-install gd && \
  docker-php-ext-install tidy && \
  docker-php-ext-install ldap && \
  pecl install apcu && \
  docker-php-ext-enable apcu

# MWMSafeMode
COPY w /var/www/html/w
RUN sed -i "s/# This file was automatically generated/echo '<div style=\"background-color:red;clear:both;\"><a href=\"https:\/\/mwstake.org\/mwstake\/wiki\/MWStake_MediaWiki_Manager\">MWM Safe Mode<\/a><\/div>'; # This file was automatically generated/g" /var/www/html/w/LocalSettings.php
RUN chgrp www-data /var/www/html/w/index.php
RUN chmod -R 777 /var/www/html
COPY conf/httpd.conf /etc/apache2/sites-available/000-default.conf
COPY conf/php.ini /usr/local/etc/php