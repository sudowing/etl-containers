FROM python:3-slim

RUN apt-get update
RUN apt-get -y install unzip jq sqlite3

RUN pip3 install python-json-logger pandas beautifulsoup4 lxml xmltodict basket-case

ENV PYTHONPATH "${PYTHONPATH}:/etl"

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='/tmp/app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_STDOUT='/tmp/etl.stdout.log'
ENV ETL_LOG_STDERR='/tmp/etl.stderr.log'

ENV HOME=/etl/src

WORKDIR $HOME
COPY src .
COPY log.sh ..

# copy into /etl
COPY etl_utils.py /etl/etl_utils.py

RUN touch $ETL_LOG_STDOUT && touch $ETL_LOG_STDERR

ENTRYPOINT [ "/etl/src/etl.process.sh" ]