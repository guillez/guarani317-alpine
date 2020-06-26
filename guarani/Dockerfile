FROM alpine:3.7 as guarani317-alpine

MAINTAINER Redes Uner <redes@uner.edu.ar>

# Add repos
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main/" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main/" >> /etc/apk/repositories
# Add basics first
RUN apk update && apk upgrade && apk add \
	bash apache2 php7-apache2 curl ca-certificates openssl openssh git php7 php7-phar php7-json php7-iconv php7-openssl tzdata openntpd subversion

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Setup apache and php
RUN apk add \
	php7-ftp \
	php7-xdebug \
	php7-mcrypt \
	php7-mbstring \
	php7-soap \
	php7-gmp \
	php7-pdo_odbc \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-sqlite3 \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-gettext \
	php7-xml \
	php7-xmlreader \
	php7-xmlwriter \
	php7-tokenizer \
	php7-xmlrpc \
	php7-bz2 \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \
	php7-session \
	php7-redis \
	php7-exif \
	php7-intl \
	php7-fileinfo \
	php7-ldap \
	php7-apcu \
	php7-memcached \
	php7-dev \
	php7-pear \
	php7-simplexml \
	php7-cli \
	php7-pcntl
	
RUN apk add \
	openjdk8 \
	graphviz \
	nodejs \ 
	npm \ 
	zip \
	unzip \
	nodejs-npm

RUN npm install -g bower

RUN cp /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*

# Add apache to run and configure
RUN sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf \
    && sed -i "s#^DocumentRoot \".*#DocumentRoot \"/data\"#g" /etc/apache2/httpd.conf \
    && sed -i "s#/var/www/localhost/htdocs#/data#" /etc/apache2/httpd.conf \
    && printf "\n<Directory \"/data\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

RUN mkdir entrypoint-dir

RUN mkdir -p /data && chown -R apache:apache /data && chmod -R 755 /data

ADD guarani/instalar.sh /root
ADD guarani/restaurar.sh /root
ADD guarani/jasper.sh /root
ADD guarani/variables /root
ADD guarani/start.sh /entrypoint-dir/

RUN chmod +x /entrypoint-dir/start.sh

RUN mkdir -p /run/apache2 \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

RUN curl -s https://getcomposer.org/composer.phar > /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer

RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf

RUN ln -s /data/local/g3gestion/instalacion/toba.conf /etc/apache2/conf.d/toba.conf

EXPOSE 80

ENTRYPOINT ["/entrypoint-dir/start.sh"]

