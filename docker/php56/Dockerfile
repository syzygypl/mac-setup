FROM php:5.6-apache

RUN curl --silent --location https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y openssh-client git nodejs libicu-dev imagemagick libmagickwand-dev libmagickcore-dev libmcrypt-dev less nano --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install intl pdo_mysql mbstring zip mcrypt pcntl exif iconv
RUN yes '' | pecl install -f imagick-beta \
    && echo 'extension=imagick.so' > /usr/local/etc/php/conf.d/imagick.ini \
    && echo 'date.timezone=Europe/Warsaw' > /usr/local/etc/php/conf.d/datetime.ini

RUN pecl install redis-3.1.0 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable redis

RUN pecl install apcu-4.0.11 \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

RUN curl -Ls https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz | tar Jxf - -C /tmp \
    && mv /tmp/wkhtmltox/bin/wkhtmltopdf /bin

RUN curl --silent http://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
    && chmod a+x /usr/bin/composer

RUN npm install -g n \
    && n 5 \
    && npm install --quiet npm \
    && n 0.12 \
    && n 7 \
    && n latest \
    && rm /usr/bin/node /usr/bin/npm

RUN npm install -g gulp yarn

RUN echo 'zend_extension=xdebug.so' > /usr/local/etc/php/php-cli-server.ini

ADD install-node.sh /bin/install-node
ADD 50-extension-xdebug.ini /usr/local/etc/php/conf.d/
ADD 90-syzygy.ini /usr/local/etc/php/conf.d/

ENV PORT 80
