FROM php:8.3

RUN apt-get update -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev \
  libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev \
  libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev \
  libpcre3-dev libtidy-dev libzip-dev \
  rsync postgresql-client

RUN docker-php-ext-install bcmath zip sockets pgsql pdo_pgsql curl intl gd xml soap \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg

RUN apt-get install -y libmagickwand-dev libmagickcore-dev imagemagick \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongo.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer

# Node and npm
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# For the liquibase
RUN mkdir -p /usr/share/man/man1/ && apt install -y default-jre
