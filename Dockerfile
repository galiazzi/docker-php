FROM php:8.2

RUN apt-get update -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev \
  libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev \
  libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev \
  libpcre3-dev libtidy-dev libzip-dev \
  rsync postgresql-client

RUN docker-php-ext-install bcmath zip sockets
RUN docker-php-ext-install pgsql pdo_pgsql curl intl gd xml soap
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg

RUN apt-get install -y libmagickwand-dev libmagickcore-dev imagemagick
RUN pecl install imagick
RUN docker-php-ext-enable imagick

RUN pecl install mongodb
RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongo.ini

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# for the liquibase
RUN mkdir -p /usr/share/man/man1/
RUN apt-get install -y default-jre

# node and npm
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

