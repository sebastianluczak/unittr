FROM php:8.1-cli

WORKDIR /app
#RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN apt update
RUN apt install -y wget netcat zip supervisor

# Install Postgre PDO
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && docker-php-ext-enable pdo_pgsql

#install ZIP for composer
RUN apt-get update && apt-get install -y libzip-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis
CMD ['/app/bin/entrypoint.sh']