# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shinckel <shinckel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 12:53:02 by shinckel          #+#    #+#              #
#    Updated: 2024/10/02 12:53:04 by shinckel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	@sudo hostsed add 127.0.0.1 shinckel.42.fr && echo "successfully added shinckel.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo hostsed rm 127.0.0.1 shinckel.42.fr && echo "successfully removed shinckel.42.fr to /etc/hosts"
	@if [ -d "/home/shinckel/data/wordpress" ]; then \
	sudo rm -rf /home/shinckel/data/wordpress/* && \
	echo "successfully removed all contents from /home/shinckel/data/wordpress/"; \
	fi;

	@if [ -d "/home/shinckel/data/mariadb" ]; then \
	sudo rm -rf /home/shinckel/data/mariadb/* && \
	echo "successfully removed all contents from /home/shinckel/data/mariadb/"; \
	fi;

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls

# all: build up

# build:
#     docker-compose -f srcs/docker-compose.yml build

# up:
#     docker-compose -f srcs/docker-compose.yml up -d

# down:
#     docker-compose -f srcs/docker-compose.yml down

# clean: down
#     docker-compose -f srcs/docker-compose.yml rm -f
#     docker volume prune -f
