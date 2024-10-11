# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shinckel <shinckel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 12:53:02 by shinckel          #+#    #+#              #
#    Updated: 2024/10/05 18:17:36 by shinckel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# all:
# 	@sudo hostsed add 127.0.0.1 shinckel.42.fr && echo "successfully added shinckel.42.fr to /etc/hosts"
# 	sudo docker compose -f ./srcs/docker-compose.yml up -d

# clean:
# 	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v

# fclean: clean
# 	@sudo hostsed rm 127.0.0.1 shinckel.42.fr && echo "successfully removed shinckel.42.fr to /etc/hosts"
# 	@if [ -d "/home/shinckel/data/wordpress" ]; then \
# 	sudo rm -rf /home/shinckel/data/wordpress/* && \
# 	echo "successfully removed all contents from /home/shinckel/data/wordpress/"; \
# 	fi;

# 	@if [ -d "/home/shinckel/data/mariadb" ]; then \
# 	sudo rm -rf /home/shinckel/data/mariadb/* && \
# 	echo "successfully removed all contents from /home/shinckel/data/mariadb/"; \
# 	fi;

# re: fclean all

# ls:
# 	sudo docker image ls
# 	sudo docker ps

# .PHONY: all, clean, fclean, re, ls

# Build and start the containers
all:
	docker-compose -f srcs/docker-compose.yml up -d && echo "Containers ready to ROCKKKK!!!"

# Clean up (remove containers, networks, volumes, and images created by up)
clean:
	sudo docker-compose -f ./srcs/docker-compose.yml down --rmi all --volumes --remove-orphans
	@sudo apt-get clean
	@docker container prune -f
	@docker volume rm $$(docker volume ls -q)
	@docker volume prune -f
	@docker network prune -f
	@docker image prune -a -f
	@sudo rm -rf /var/log/*.log
	@sudo apt-get autoremove --purge -y

# Restart the containers
restart:
	docker-compose -f srcs/docker-compose.yml down
	docker-compose -f srcs/docker-compose.yml up -d

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, ls