#!/bin/bash

# running script 
# chmod +x install_docker.sh
# ./install_docker.sh

# Color variables
GREEN='\e[32m'
RESET='\e[0m'

echo -e "${GREEN}Updating package index...${RESET}"
sudo apt-get update

echo -e "${GREEN}Installing required packages...${RESET}"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo -e "${GREEN}Adding Docker's GPG key...${RESET}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o docker.gpg
sudo mv docker.gpg /etc/apt/trusted.gpg.d/

echo -e "${GREEN}Setting up Docker repository...${RESET}"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo -e "${GREEN}Updating package index again...${RESET}"
sudo apt-get update

echo -e "${GREEN}Installing Docker...${RESET}"
sudo apt-get install -y docker.io

echo -e "${GREEN}Starting and enabling Docker...${RESET}"
sudo systemctl start docker
sudo systemctl enable docker

echo -e "${GREEN}Adding user to Docker group...${RESET}"
sudo usermod -aG docker $USER

echo -e "${GREEN}Installing Docker Compose...${RESET}"
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "${GREEN}Verifying Docker installation...${RESET}"
sudo docker run hello-world

echo -e "${GREEN}Verifying Docker Compose installation...${RESET}"
docker-compose --version

echo -e "${GREEN}Docker and Docker Compose installation completed successfully.${RESET}"

# Apply the changes immediately
sudo newgrp docker
