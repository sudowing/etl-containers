FROM mcr.microsoft.com/mssql/server:2019-latest

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV PATH="${PATH}:/opt/mssql-tools/bin"

ENV ETL_LOG_STDOUT='/tmp/etl.stdout.log'
ENV ETL_LOG_STDERR='/tmp/etl.stderr.log'

ENV HOME=/etl/src

WORKDIR $HOME
COPY src .
COPY log.sh ..

USER root
RUN chmod -R 775 .

USER mssql

RUN touch $ETL_LOG_STDOUT && touch $ETL_LOG_STDERR

ENTRYPOINT [ "/etl/src/etl.process.sh" ]
