FROM debian:bullseye
# bullseye is the codename for Debian 11

RUN echo "Dockerfile running for wordpress"

RUN apt-get update && apt-get -y install \
    wget \
    curl \
    bash \
    php \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd \
    php-cli \
    php-mbstring \
    redis \
    php-redis \
    netcat \
    mariadb-client \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php

COPY ./tools/wp_start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wp_start.sh

ENTRYPOINT ["/usr/local/bin/wp_start.sh"]

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]