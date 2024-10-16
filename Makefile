# Build and start the containers
all:
	@echo "Adding shinckel.42.fr to /etc/hosts"
	@echo "127.0.0.1 shinckel.42.fr" | sudo tee -a /etc/hosts > /dev/null
	@sudo docker-compose -f srcs/docker-compose.yml up -d --build && echo "Containers are up and running!"

clean:
	@sudo docker-compose -f srcs/docker-compose.yml down --rmi all -v
	@sudo apt-get clean
	@sudo docker container prune -f
	@sudo docker volume prune -f
	@sudo docker network prune -f
	@sudo docker image prune -a -f
	@echo "Cleanup completed!"

fclean: clean
	docker system prune -a
	@echo "Removing shinckel.42.fr from /etc/hosts"
	@sudo sed -i '/shinckel.42.fr/d' /etc/hosts
	@if [ -d "/home/shinckel/Documents/data/wp_data" ]; then \
		sudo rm -rf /home/shinckel/Documents/data/wp_data/* && \
		echo "successfully removed all contents from /home/shinckel/Documents/data/wp_data/"; \
	fi;
	@if [ -d "/home/shinckel/Documents/data/db_data" ]; then \
		sudo rm -rf /home/shinckel/Documents/data/db_data/* && \
		echo "successfully removed all contents from /home/shinckel/Documents/data/db_data/"; \
	fi;
		@if [ -d "/home/ubuntu/data/wp_data" ]; then \
		sudo rm -rf /home/ubuntu/data/wp_data/* && \
		echo "successfully removed all contents from /home/ubuntu/data/wp_data/"; \
	fi;
	@if [ -d "/home/ubuntu/data/db_data" ]; then \
		sudo rm -rf /home/ubuntu/data/db_data/* && \
		echo "successfully removed all contents from /home/ubuntu/data/db_data/"; \
	fi;

re: fclean all

ls:
	@sudo docker image ls
	@sudo docker ps

.PHONY: all clean fclean re ls
