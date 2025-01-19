FROM mysql:8.0.40-bookworm

COPY conf.d/ /etc/mysql/conf.d/

COPY initdb.d/ /docker-entrypoint-initdb.d/

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=3s \
    CMD mysqladmin ping -h localhost -u root --password=${MYSQL_ROOT_PASSWORD} || exit 1

CMD ["mysqld"]