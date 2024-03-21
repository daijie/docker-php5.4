FROM php:5.4-fpm
WORKDIR /php
ADD sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install libssl-dev libmcrypt-dev libpng-dev libjpeg-dev libfreetype6-dev libbz2-dev -y --force-yes
RUN docker-php-ext-configure gd --with-jpeg-dir --with-png-dir --with-freetype-dir
RUN docker-php-ext-install gd pdo pdo_mysql bcmath bz2 gettext ftp calendar hash exif dba mbstring mcrypt mysql mysqli zip
RUN docker-php-ext-enable gd pdo pdo_mysql bcmath bz2 gettext ftp calendar hash exif dba mbstring mcrypt mysql mysqli zip
ADD https://pecl.php.net/get/redis-2.2.7.tgz ./
RUN tar zxvf redis-2.2.7.tgz
RUN cd redis-2.2.7 && phpize && ./configure && make && make install
ADD php.ini /usr/local/etc/php
