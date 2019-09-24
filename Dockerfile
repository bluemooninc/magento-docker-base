FROM php:7.2-apache

# aptライブラリのインデックス更新
RUN apt-get update \
  && apt-get install -y \
    gcc \
    make \
    libicu-dev \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    libxslt-dev \
    git \
    unzip \
    vim \
    libmcrypt-dev \
    curl \
    cron \
    gnupg \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install bcmath pdo_mysql mysqli mbstring zip intl soap xsl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Apacheのmod_rewrite有効化
RUN a2enmod rewrite

# php.iniを読み込ませる
COPY ./php.ini /usr/local/etc/php

# install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
