FROM postgres:14.7

RUN apt-get update && \
    apt-get install -y dos2unix git build-essential postgresql-server-dev-14 postgresql-14-cron

COPY *.sql /docker-entrypoint-initdb.d/
COPY *.sh /docker-entrypoint-initdb.d/

ENV POSTGRES_MULTIPLE_SCHEMAS="port:port:port, serv:serv:serv, keycloak:keycloak:keycloak" \
    POSTGRES_USER="postgres" \
    POSTGRES_PASSWORD="postgres" \
    POSTGRES_ADMIN_PASSWORD="postgres" \
    POSTGRES_DB="entando"

RUN dos2unix /docker-entrypoint-initdb.d/01_multiple_schemas.sh

EXPOSE 5432
