FROM php:7.0.28-fpm

MAINTAINER Zachary Wang <291768903@qq.com>

RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list 
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list 


RUN echo 'Asia/Shanghai' > /etc/timezone

RUN apt-get update \
    && apt-get install -y \
        curl \
        wget \
        git \
        zip \
        libz-dev \
        libssl-dev \
        libnghttp2-dev \
    && apt-get clean \
    && apt-get autoremove

ADD composer /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer
ADD swoole.tar.gz /home/
ADD hiredis.tar.gz /home/
RUN composer self-update --clean-backups
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN pecl install redis && docker-php-ext-enable redis && pecl clear-cache

RUN docker-php-ext-install pdo_mysql

RUN ( \
        cd /home/hiredis-0.13.3 \
        && make -j$(nproc) \
        && make install \
        && ldconfig \
    ) \
    && rm -r /home/hiredis-0.13.3

RUN ( \
        cd /home/swoole-src-2.1.1 \
        && phpize \
        && ./configure --enable-async-redis --enable-mysqlnd --enable-coroutine --enable-openssl --enable-http2 \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r /home/swoole-src-2.1.1 \
    && docker-php-ext-enable swoole
ADD php.ini /usr/local/etc/php/