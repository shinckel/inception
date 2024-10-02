# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shinckel <shinckel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 12:52:09 by shinckel          #+#    #+#              #
#    Updated: 2024/10/02 12:52:11 by shinckel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build images automatically by reading the instructions from a Dockerfile

# Create a new build stage from a base image
FROM debian:buster 

# Describe which ports your application is listening on.
EXPOSE 3306

# Use build-time variables.
ARG DB_NAME=${DB_NAME}
ARG DB_USER=${DB_USER}
ARG DB_PASSWORD=${DB_PASSWORD}
ARG DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}

# Execute build commands.
RUN apt-get update && apt-get install \
	mariadb-server -y && \
	rm -rf /var/lib/apt/lists/*

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

# Copy files and directories.
COPY tools/create_user.sh /
RUN bash ./create_user.sh

RUN rm -rf create_user.sh

# Specify default commands.
CMD ["mysqld_safe"]