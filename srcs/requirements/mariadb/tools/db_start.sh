#!/bin/bash

# Check if the database directory exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists"
else
    # Start MariaDB service
    service mariadb start

    # Secure MariaDB installation and set root password
    mysql_secure_installation <<-EOSQL
Y
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
EOSQL

    # Grant privileges and create database
    mariadb -u root <<-EOSQL
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; 
GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; 
FLUSH PRIVILEGES;
EOSQL

    # Import WordPress database schema
    mariadb -u $MYSQL_USER -p"$MYSQL_PASSWORD" $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

    # Stop MariaDB service
    service mariadb stop
fi

# Execute the command passed as arguments
exec "$@"