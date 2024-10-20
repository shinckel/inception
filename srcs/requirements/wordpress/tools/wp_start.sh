#!/bin/sh

# LOGFILE=/var/log/wp_setup.log

# echo "Starting WordPress setup script v2" > $LOGFILE

# # Log environment variables
# echo "MYSQL_DATABASE: $MYSQL_DATABASE" >> $LOGFILE
# echo "MYSQL_USER: $MYSQL_USER" >> $LOGFILE
# echo "MYSQL_PASSWORD: $MYSQL_PASSWORD" >> $LOGFILE
# echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD" >> $LOGFILE
# echo "MYSQL_HOSTNAME: $MYSQL_HOSTNAME" >> $LOGFILE
# echo "WORDPRESS_URL: $WORDPRESS_URL" >> $LOGFILE
# echo "WORDPRESS_TITLE: $WORDPRESS_TITLE" >> $LOGFILE
# echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER" >> $LOGFILE
# echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD" >> $LOGFILE
# echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL" >> $LOGFILE

# echo "Downloading WordPress" >> $LOGFILE
# wget http://wordpress.org/latest.tar.gz >> $LOGFILE 2>&1
# tar xfz latest.tar.gz >> $LOGFILE 2>&1
# mv wordpress/* . >> $LOGFILE 2>&1
# rm -rf latest.tar.gz wordpress >> $LOGFILE 2>&1

# # Replace placeholders in wp-config-sample.php with environment variables
# echo "Configuring wp-config.php" >> $LOGFILE
# sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php >> $LOGFILE 2>&1
# sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php >> $LOGFILE 2>&1
# sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php >> $LOGFILE 2>&1
# sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php >> $LOGFILE 2>&1
# cp wp-config-sample.php wp-config.php >> $LOGFILE 2>&1

# # Log the contents of wp-config.php
# echo "Contents of wp-config.php:" >> $LOGFILE
# cat wp-config.php >> $LOGFILE

# # Set site URL and title if provided
# echo "Installing WordPress" >> $LOGFILE
# wp core install --url=$WORDPRESS_URL --title="$WORDPRESS_TITLE" \
#     --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD \
#     --admin_email=$WORDPRESS_ADMIN_EMAIL >> $LOGFILE 2>&1

# echo "WordPress setup script completed" >> $LOGFILE

LOGFILE=/var/log/wp_setup.log

echo "Starting WordPress setup script v2" > $LOGFILE

# Log environment variables
echo "MYSQL_DATABASE: $MYSQL_DATABASE" >> $LOGFILE
echo "MYSQL_USER: $MYSQL_USER" >> $LOGFILE
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD" >> $LOGFILE
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD" >> $LOGFILE
echo "MYSQL_HOSTNAME: $MYSQL_HOSTNAME" >> $LOGFILE
echo "WORDPRESS_URL: $WORDPRESS_URL" >> $LOGFILE
echo "WORDPRESS_TITLE: $WORDPRESS_TITLE" >> $LOGFILE
echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER" >> $LOGFILE
echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD" >> $LOGFILE
echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL" >> $LOGFILE
echo "WORDPRESS_USER: $WORDPRESS_USER" >> $LOGFILE
echo "WORDPRESS_PASSWORD: $WORDPRESS_PASSWORD" >> $LOGFILE
echo "WORDPRESS_USER_EMAIL: $WORDPRESS_USER_EMAIL" >> $LOGFILE

echo "Downloading WordPress" >> $LOGFILE
wget http://wordpress.org/latest.tar.gz >> $LOGFILE 2>&1
tar xfz latest.tar.gz >> $LOGFILE 2>&1

# Move WordPress files if the target directories are empty
if [ ! "$(ls -A wp-admin)" ] && [ ! "$(ls -A wp-content)" ] && [ ! "$(ls -A wp-includes)" ]; then
    mv wordpress/* . >> $LOGFILE 2>&1
else
    echo "Target directories are not empty, skipping move" >> $LOGFILE
fi

rm -rf latest.tar.gz wordpress >> $LOGFILE 2>&1

# Replace placeholders in wp-config-sample.php with environment variables
echo "Configuring wp-config.php" >> $LOGFILE
sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php >> $LOGFILE 2>&1
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php >> $LOGFILE 2>&1
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php >> $LOGFILE 2>&1
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php >> $LOGFILE 2>&1
cp wp-config-sample.php wp-config.php >> $LOGFILE 2>&1

# Log the contents of wp-config.php
echo "Contents of wp-config.php:" >> $LOGFILE
cat wp-config.php >> $LOGFILE

# Set site URL and title if provided
echo "Installing WordPress" >> $LOGFILE
if wp core install --url=$WORDPRESS_URL --title="$WORDPRESS_TITLE" \
    --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root >> $LOGFILE 2>&1; then
    echo "WordPress installed successfully" >> $LOGFILE
else
    echo "WordPress installation failed" >> $LOGFILE
fi

# Add a regular user
echo "Adding regular user" >> $LOGFILE
if wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_PASSWORD --role=subscriber --allow-root >> $LOGFILE 2>&1; then
    echo "Regular user added successfully" >> $LOGFILE
else
    echo "Failed to add regular user" >> $LOGFILE
fi

echo "WordPress setup script completed" >> $LOGFILE

exec "$@"