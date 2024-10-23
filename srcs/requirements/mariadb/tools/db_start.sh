#!/bin/sh

LOGFILE=/var/log/mariadb_init.log

echo "Starting MariaDB initialization script v7" > $LOGFILE

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists" >> $LOGFILE
else
    echo "Running mysql_install_db" >> $LOGFILE
    mysql_install_db >> $LOGFILE 2>&1 || {
        echo "mysql_install_db failed, running mysql_upgrade" >> $LOGFILE
        mysql_upgrade --force >> $LOGFILE 2>&1
    }

    # 2>&1 - redirect standard error (2) to the same location as standard output (1)
    # all will be written in logfile
    echo "Starting MariaDB service" >> $LOGFILE
    service mariadb start >> $LOGFILE 2>&1

    echo "Waiting for MariaDB to be ready..." >> $LOGFILE
    # use mysqladmin to wait for the server to be available
    until mysqladmin ping -u root --silent; do
        echo "MariaDB is still starting up..." >> $LOGFILE
        sleep 2
    done

    echo "Running mysql_secure_installation" >> $LOGFILE
    mysql_secure_installation << EOS >> $LOGFILE 2>&1
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
EOS

    echo "Granting privileges and creating database" >> $LOGFILE
    mariadb -u root -p$MYSQL_ROOT_PASSWORD << EOS >> $LOGFILE 2>&1
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
FLUSH PRIVILEGES;
EOS

    echo "Verifying user creation and privileges" >> $LOGFILE
    mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "SHOW GRANTS FOR '$MYSQL_USER'@'%';" >> $LOGFILE 2>&1
fi

echo "Stopping MariaDB service" >> $LOGFILE
service mariadb stop >> $LOGFILE 2>&1

echo "MariaDB initialization script completed" >> $LOGFILE

exec "$@"