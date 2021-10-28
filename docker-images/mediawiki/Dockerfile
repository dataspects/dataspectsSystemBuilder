ARG ARCH
FROM dataspects/php-apache:7.4.16_211011-$ARCH
ARG CURRENTW
COPY $CURRENTW /var/www/html/w

RUN git clone https://github.com/dataspects/mediawiki-cli.git /var/www/manage

RUN chgrp -R www-data /var/www/html
RUN chmod -R 770 /var/www/html
