#!/bin/sh

LOGFILE=/var/log/mariadb_init.log

echo "Starting MariaDB initialization script v6" > $LOGFILE

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists" >> $LOGFILE
else
    echo "Running mysql_install_db" >> $LOGFILE
    mysql_install_db >> $LOGFILE 2>&1 || {
        echo "mysql_install_db failed, running mysql_upgrade" >> $LOGFILE
        mysql_upgrade --force >> $LOGFILE 2>&1
    }

    echo "Starting MariaDB service" >> $LOGFILE
    service mariadb start >> $LOGFILE 2>&1

    # Wait for MariaDB to be fully up and running
    echo "Waiting for MariaDB to start..." >> $LOGFILE
    sleep 10

    # Check if MariaDB is running
    until mariadb -u root -e "SELECT 1" > /dev/null 2>&1; do
        echo "Waiting for MariaDB to be ready..." >> $LOGFILE
        sleep 5
    done

    echo "Running mysql_secure_installation" >> $LOGFILE
    mysql_secure_installation << _EOS_ >> $LOGFILE 2>&1
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOS_

    echo "Granting privileges and creating database" >> $LOGFILE
    mariadb -u root -p$MYSQL_ROOT_PASSWORD << EOS >> $LOGFILE 2>&1
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;
EOS

    # echo "Importing WordPress database" >> $LOGFILE
    # mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql >> $LOGFILE 2>&1

    # Verify user creation and privileges
    echo "Verifying user creation and privileges" >> $LOGFILE
    mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "SHOW GRANTS FOR '$MYSQL_USER'@'%';" >> $LOGFILE 2>&1
fi

echo "Stopping MariaDB service" >> $LOGFILE
service mariadb stop >> $LOGFILE 2>&1

echo "MariaDB initialization script completed" >> $LOGFILE

exec "$@"
