#!/bin/sh

service mariadb start

mysql_upgrade --force

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 

	echo "Database already exists"
else

mysql_secure_installation << _EOS_

Y
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOS_

mariadb -u root << EOS
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;
EOS

mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

service mariadb stop

exec "$@"
