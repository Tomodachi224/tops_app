ARG  version
# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM php:$version

# Preparing
RUN apk upgrade --update --no-cache && apk add build-base patch autoconf \
  && apk add --update linux-headers

# install the PHP extensions we need
# postgresql-dev is needed for https://bugs.alpinelinux.org/issues/3642
RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
  coreutils \
  freetype-dev \
  icu-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  libzip-dev zip \
  postgresql-dev $PHPIZE_DEPS \
  \
  # PHP mysqli
  && docker-php-ext-install -j "$(nproc)" \
  mysqli pdo pdo_pgsql pdo_mysql  \
  && runDeps="$( \
  scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
  | tr ',' '\n' \
  | sort -u \
  | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )" \
  && apk add --virtual .drupal-phpexts-rundeps $runDeps \
  # Debugger
  # Version 3.1 is for PHP 7.4
  && pecl install xdebug-3.1.0 \
  && docker-php-ext-enable xdebug \
  # Cleaning
  && apk del -f .build-deps

# Include external applications
RUN apk add git unzip php-intl

# Install PHP Extensions
# Ref: https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions

RUN curl -sSLf \
  -o /usr/local/bin/install-php-extensions \
  https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
  chmod +x /usr/local/bin/install-php-extensions && \
  install-php-extensions gd uploadprogress imagick opcache zip intl bcmath

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/ \
  && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
COPY drupal-*.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html
ENV COMPOSER_ALLOW_SUPERUSER=1

# Cleanup
RUN docker-php-source delete && \
  apk del --purge \
  *-dev \
  autoconf \
  .docker-* \
  build-base \
  cmake \
  libtool && \
  rm -rf /usr/src/php.tar.xz \
  /usr/src/php/ext/memcached \
  /usr/src/php/ext/uploadprogress \
  /usr/include/php \
  /usr/lib/php/build \
  /var/cache/apk/* \
  /tmp/* \
  /root/.composer

# Export command line tools
RUN ln -s /var/www/html/vendor/bin/drush /usr/sbin/drush \
  && ln -s /var/www/html/vendor/bin/drupal /usr/sbin/drupal
