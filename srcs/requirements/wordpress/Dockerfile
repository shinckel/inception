# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shinckel <shinckel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 12:52:44 by shinckel          #+#    #+#              #
#    Updated: 2024/10/02 12:53:38 by shinckel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build images automatically by reading the instructions from a Dockerfile

FROM debian:buster

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	php7.3-fpm \
	php7.3-mysql \
	mariadb-client \
	curl && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz

RUN cd /var/www && tar -xvf latest.tar.gz && \
	rm -rf latest.tar.gz

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent

RUN chmod +x ./usr/bin/wp

RUN mkdir /run/php

COPY ./conf/config.sh /var/www/wordpress/config.sh
RUN chmod +x /var/www/wordpress/config.sh
CMD ["bash", "/var/www/wordpress/config.sh"]