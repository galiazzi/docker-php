FROM php:7.4

RUN apt-get update -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev \
  libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev \
  libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev \
  libpcre3-dev libtidy-dev libzip-dev
RUN apt-get install -y rsync

RUN docker-php-ext-install pgsql pdo_pgsql curl json intl gd xml soap
RUN docker-php-ext-install zip
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg

RUN pecl install imagick \
  && docker-php-ext-enable imagick

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# for the liquibase
RUN mkdir /usr/share/man/man1/
RUN apt-get install -y default-jre

RUN apt-get install -y postgresql-client

# node and npm
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

