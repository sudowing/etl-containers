FROM mcr.microsoft.com/mssql/server:2019-latest

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_PATH='etl.log'
ENV SQLCMD=/opt/mssql-tools/bin/sqlcmd

ENV HOME=/etl/src

WORKDIR $HOME
COPY src .
COPY log.sh ..

USER root
RUN chmod -R 775 .

USER mssql

ENTRYPOINT [ "/etl/src/etl.process.sh" ]
