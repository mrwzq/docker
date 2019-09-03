FROM centos:7.6.1810

MAINTAINER wangzq <291768903@qq.com>
# 安装nginx
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum-config-manager --enable nginx-mainline
# 安装remi库
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm yum-utils

RUN yum install -y \
        nginx\
        php73-php-fpm \
        php73-php-cli \
        php73-php-bcmath \
        php73-php-gd \
        php73-php-json \
        php73-php-mbstring \
        php73-php-mcrypt \
        php73-php-mysqlnd \
        php73-php-opcache \
        php73-php-pdo \
        php73-php-pecl-crypto \
        php73-php-pecl-mcrypt \
        php73-php-pecl-swoole4 \
        php73-php-xml \
        php73-php-pecl-zip \
        supervisor





