FROM postgres:13.1-alpine

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_PATH='etl.log'

ENV HOME=/etl/src
WORKDIR $HOME
COPY src .
COPY log.sh ..

ENTRYPOINT [ "/etl/src/etl.process.sh" ]

# CMD [ "/etl/src/etl.process.sh" ]