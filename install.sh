# sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
# docker-compose --version

# Ensure you have Nginx, PHP, and MySQL (or MariaDB) installed on your server
# sudo apt update
# sudo apt install nginx php-fpm php-mysql mysql-server

# download wordpress
# wget https://wordpress.org/latest.tar.gz
# tar -xvf latest.tar.gz
# sudo mv wordpress /var/www/
# sudo chown -R www-data:www-data /var/www/wordpress
# sudo chmod -R 755 /var/www/wordpress