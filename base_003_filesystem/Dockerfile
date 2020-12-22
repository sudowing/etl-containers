FROM alpine:3

RUN apk add --no-cache bash

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_STDOUT='/tmp/etl.stdout.log'
ENV ETL_LOG_STDERR='/tmp/etl.stderr.log'

ENV HOME=/etl/src

WORKDIR $HOME
COPY src .
COPY log.sh ..

RUN touch $ETL_LOG_STDOUT && touch $ETL_LOG_STDERR

ENTRYPOINT [ "/etl/src/etl.process.sh" ]