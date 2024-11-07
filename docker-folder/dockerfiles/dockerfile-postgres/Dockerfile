FROM postgis/postgis:13-3.1

ENV POSTGRES_USER=spatialdatauser
ENV POSTGRES_PASSWORD=spatialdatapassword
ENV POSTGRES_DB=spatialdatadb

COPY ../../../sql/model.sql /docker-entrypoint-initdb.d/
