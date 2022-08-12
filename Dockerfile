FROM php:7.4

LABEL maintainer="ferfabricio@gmail.com"


RUN apt-get update \
    && apt-get install -y \
        autoconf \
        build-essential \
        curl \
        g++ \
        gcc \
        git \
        gnupg \
        graphviz \
        libc-dev \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libgd-dev \
        libgmp-dev \
        libicu-dev \
        libmcrypt-dev \
        libonig-dev \
        libpcre3-dev \
        libpq-dev \
        libsqlite3-dev \
        libxslt-dev \
        libzip-dev \
        make \
        pkg-config \
        sqlite3 \
        sudo \
        unzip \
        zip \
        zlib1g-dev \
    && apt-get clean \
    && docker-php-ext-install calendar \
    && docker-php-ext-install curl \
    && docker-php-ext-install gettext \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl \
    && docker-php-ext-install json \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-enable calendar \
    && docker-php-ext-enable gmp

# install gd
RUN docker-php-ext-configure gd \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd

# install mcrypt
RUN pecl install --nodeps mcrypt-snapshot \
    && docker-php-ext-enable mcrypt

# install libsodium
RUN mkdir -p /tmp-libsodium/libsodium \
    && cd /tmp-libsodium/libsodium \
    && curl -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz -o libsodium-1.0.18.tar.gz \
    && tar xfvz libsodium-1.0.18.tar.gz \
    && cd /tmp-libsodium/libsodium/libsodium-1.0.18/ \
    && ./configure \
    && make \
    && make check \
    && make install \
    && mv src/libsodium /usr/local/ \
    && rm -Rf /tmp-libsodium/ \
    && docker-php-ext-install sodium \
    && docker-php-ext-enable sodium

# install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN echo "memory_limit = -1;" > $PHP_INI_DIR/conf.d/memory_limit.ini

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer