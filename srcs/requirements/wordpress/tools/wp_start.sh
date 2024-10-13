#!/bin/sh

# Check if wp-config.php exists
if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress already configured"
else
    # Move the wp-config.php to the correct location
    mv ./wp-config.php /var/www/html/
    cd /var/www/html/

    # Change the ownership of the wp-config.php file to the current user
    chown $(whoami):$(whoami) /var/www/html/wp-config.php

    # Replace placeholders in wp-config.php with actual values
    sed -i "s/__MYSQL_DATABASE__/$MYSQL_DATABASE/g" /var/www/html/wp-config.php 
    sed -i "s/__MYSQL_USER__/$MYSQL_USER/g" /var/www/html/wp-config.php
    sed -i "s/__MYSQL_PASSWORD__/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php
    sed -i "s/__DOCKERCONTAINERNAME__/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php

    # Wait for the database to be ready
    until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
        echo "Waiting for database connection..."
        sleep 2
    done

    # Create WordPress configuration
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

    # Install WordPress
    wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email="$WP_ADMIN_EMAIL" --allow-root

    # Create a WordPress user
    wp user create $WP_USER "$WP_USER_EMAIL" --role=author --user_pass=$WP_USER_PASSWORD --allow-root

    # Change the owner of the wp-content directory to www-data
    chown -R www-data:www-data /var/www/html/wp-content
fi

# Start PHP-FPM in the foreground
exec /usr/sbin/php-fpm7.4 -F