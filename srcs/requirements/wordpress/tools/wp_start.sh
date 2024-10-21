#!/bin/sh

LOGFILE=/var/log/wp_setup.log

echo "Starting WordPress setup script v2" > $LOGFILE

# Log environment variables
{
    echo "MYSQL_DATABASE: $MYSQL_DATABASE"
    echo "MYSQL_USER: $MYSQL_USER"
    echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
    echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
    echo "MYSQL_HOSTNAME: $MYSQL_HOSTNAME"
    echo "WORDPRESS_URL: $WORDPRESS_URL"
    echo "WORDPRESS_TITLE: $WORDPRESS_TITLE"
    echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER"
    echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD"
    echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL"
    echo "WORDPRESS_USER: $WORDPRESS_USER"
    echo "WORDPRESS_PASSWORD: $WORDPRESS_PASSWORD"
    echo "WORDPRESS_USER_EMAIL: $WORDPRESS_USER_EMAIL"
} >> $LOGFILE

# Clean previous installations
echo "Cleaning previous installations" >> $LOGFILE
rm -rf wp-admin wp-content wp-includes latest.tar.gz wordpress >> $LOGFILE 2>&1

# Download WordPress
echo "Downloading WordPress" >> $LOGFILE
if wget https://wordpress.org/latest.tar.gz >> $LOGFILE 2>&1; then
    echo "Download successful" >> $LOGFILE
else
    echo "Download failed" >> $LOGFILE
fi

# Extract WordPress
echo "Extracting WordPress" >> $LOGFILE
tar xfz latest.tar.gz >> $LOGFILE 2>&1

# Move WordPress files
echo "Moving WordPress files" >> $LOGFILE
mv wordpress/* . >> $LOGFILE 2>&1
rm -rf latest.tar.gz wordpress >> $LOGFILE 2>&1

# Configure wp-config.php
echo "Configuring wp-config.php" >> $LOGFILE
cp wp-config-sample.php wp-config.php >> $LOGFILE 2>&1
sed -i "s/username_here/$MYSQL_USER/g" wp-config.php >> $LOGFILE 2>&1
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php >> $LOGFILE 2>&1
sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php >> $LOGFILE 2>&1
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php >> $LOGFILE 2>&1

# Log the contents of wp-config.php
echo "Contents of wp-config.php:" >> $LOGFILE
cat wp-config.php >> $LOGFILE

# Install WordPress
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
