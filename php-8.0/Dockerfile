FROM php:8.0

LABEL maintainer="ferfabricio@gmail.com"

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    file \
    git \
    graphviz \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libexif-dev \
    libgd-dev \
    libgmp-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libmagic-dev \
    libmcrypt-dev \
    libonig-dev \
    libpng-dev \
    libpng++-dev \
    libpq-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libssl-dev \
    libtidy-dev \
    libvpx-dev \
    libxml2-dev \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    protobuf-compiler \
    re2c \
    sqlite3	\
    wget \
    wkhtmltopdf \
    zlib1g-dev

RUN docker-php-ext-install bcmath \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install calendar \
    && docker-php-ext-install dom \
    && docker-php-ext-install exif \
    && docker-php-ext-install gd \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install soap \
    && docker-php-ext-install sockets \
    && docker-php-ext-install tidy \
    && docker-php-ext-install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install grpc
RUN pecl install grpc && docker-php-ext-enable grpc

#Install xdebug
RUN pecl install xdebug-3.1.5 && docker-php-ext-enable xdebug

RUN echo "memory_limit = -1;" > $PHP_INI_DIR/conf.d/memory_limit.ini

ENV COMPOSER_ALLOW_SUPERUSER=1
