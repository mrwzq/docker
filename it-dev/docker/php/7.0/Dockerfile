FROM php:7.0.28-fpm

MAINTAINER Zachary Wang <291768903@qq.com>

# 设置阿里云镜像加速
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list 
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list 

# 更改时区到中国
RUN echo 'Asia/Shanghai' > /etc/timezone

# 更新系统依赖
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

# 安装composer
ADD composer /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
RUN composer self-update --clean-backups


# 安装hiredis、redis
ADD hiredis.tar.gz /home/
RUN pecl install redis && docker-php-ext-enable redis && pecl clear-cache
RUN ( \
        cd /home/hiredis-0.13.3 \
        && make -j$(nproc) \
        && make install \
        && ldconfig \
    ) \
    && rm -r /home/hiredis-0.13.3

# 安装swoole
ADD swoole.tar.gz /home/
RUN ( \
        cd /home/swoole-src-2.1.1 \
        && phpize \
        && ./configure --enable-async-redis --enable-mysqlnd --enable-coroutine --enable-openssl --enable-http2 \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r /home/swoole-src-2.1.1 \
    && docker-php-ext-enable swoole

# 安装freetds
ADD freetds.tar.gz /home/
RUN cd /home/freetds-0.91.81 && ./configure --prefix=/usr/local/freetds --enable-msdblib --enable-sybase-compat   --disable-threadsafe && make && make install
RUN rm -r /home/freetds-0.91.81
# 设置freetds默认配置文件
ADD freetds.conf /usr/local/freetds/etc/freetds.conf

# 安装dblib扩展
ADD pdo_dblib /home/pdo_dblib
RUN cd /home/pdo_dblib && phpize && ./configure --with-pdo-dblib=/usr/local/freetds && make && make install && rm -r /home/pdo_dblib
RUN docker-php-ext-enable pdo_dblib

# 设置php默认配置
ADD php.ini /usr/local/etc/php/
