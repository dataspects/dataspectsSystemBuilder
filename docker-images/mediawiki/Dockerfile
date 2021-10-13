ARG CURRENTW
ARG ARCH

FROM dataspects/php-apache:7.4.16_211011-$ARCH

COPY $CURRENTW /var/www/html/w

RUN chgrp -R www-data /var/www/html
RUN chmod -R 770 /var/www/html