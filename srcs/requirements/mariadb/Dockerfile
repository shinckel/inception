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

COPY ./tools/mysqld.conf /etc/mysql/my.cnf

# use preset wordpress.sql, no wordpress template
# COPY ./tools/wordpress.sql /usr/local/bin

COPY ./tools/db_start.sh /usr/local/bin

RUN chmod +x /usr/local/bin/db_start.sh

ENTRYPOINT [ "/usr/local/bin/db_start.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]
