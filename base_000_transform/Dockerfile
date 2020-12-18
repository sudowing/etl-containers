FROM python:3-slim

RUN apt-get update
RUN apt-get -y install unzip jq sqlite3

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_PATH='etl.log'

ENV HOME=/etl/src

WORKDIR $HOME
COPY src .
COPY log.sh ..

ENTRYPOINT [ "/etl/src/etl.process.sh" ]