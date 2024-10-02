# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shinckel <shinckel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 12:51:39 by shinckel          #+#    #+#              #
#    Updated: 2024/10/02 12:51:48 by shinckel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build images automatically by reading the instructions from a Dockerfile

FROM debian:buster

RUN apt-get update && apt-get install -y \
	nginx \
	openssl && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN openssl req -x509 -days 365 -nodes -newkey rsa:4096 \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt -sha256 -subj "/CN=prossi.42.fr"

CMD ["nginx", "-g", "daemon off;"]