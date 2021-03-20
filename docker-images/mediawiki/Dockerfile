FROM php:7.4.15-apache
ARG CURRENTW
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
  tree \
  inetutils-ping \
  mariadb-client \
  git \
  lynx \
  vim \
  jq \
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
COPY $CURRENTW /var/www/html/w
RUN chgrp -R www-data /var/www/html
RUN chmod -R 770 /var/www/html
COPY conf/httpd.conf /etc/apache2/sites-available/000-default.conf
COPY conf/php.ini /usr/local/etc/php