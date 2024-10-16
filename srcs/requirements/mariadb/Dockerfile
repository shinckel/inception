FROM debian:bullseye
# bullseye is the codename for Debian 11

RUN echo "Dockerfile running for mariadb"

RUN apt update && apt upgrade -y

RUN apt install -y mariadb-server mariadb-client

RUN mkdir -p /var/run/mysqld \
    && chmod +x /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

# Update this line to reflect the correct path for mysqld.conf
COPY ./tools/mysqld.conf /etc/mysql/my.cnf

# Update this line to reflect the correct path for wordpress.sql
COPY ./tools/wordpress.sql /usr/local/bin

# Update this line to reflect the correct path for db_start.sh
COPY ./tools/db_start.sh /usr/local/bin

RUN chmod +x /usr/local/bin/db_start.sh

ENTRYPOINT [ "/usr/local/bin/db_start.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]
