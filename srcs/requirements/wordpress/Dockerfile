# FROM debian:bullseye

# RUN apt update && apt upgrade -y

# RUN apt install -y \
# 		curl \
# 		wget \
# 		tar \
# 		php \
#         php-fpm \
# 		php-mysql \
# 		redis \
# 		php-redis

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#   && chmod +x wp-cli.phar \
#   && mv wp-cli.phar /usr/local/bin/wp

# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# RUN mkdir -p /run/php

# COPY ./tools/wp_start.sh /usr/local/bin/

# RUN chmod +x /usr/local/bin/wp_start.sh

# ENTRYPOINT ["/usr/local/bin/wp_start.sh"]

# WORKDIR /var/www/html

# EXPOSE 9000

# CMD [ "/usr/sbin/php-fpm7.4", "-F" ]

FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y \
        curl \
        wget \
        tar \
        php7.4 \
        php7.4-fpm \
        php7.4-mysql \
        php7.4-mbstring \
        php7.4-xml \
        php7.4-curl \
        redis \
        php7.4-redis && \
    apt clean && rm -rf /var/lib/apt/lists/*

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

CMD ["php-fpm7.4", "-F"]
