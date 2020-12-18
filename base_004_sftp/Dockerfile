FROM atmoz/sftp:debian

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV ETL_LOG_PATH='etl.log'

ENV HOME=/etl/src

WORKDIR $HOME

COPY entrypoint.sh /entrypoint.sh
RUN chmod -R 775 /entrypoint.sh

COPY src .
COPY log.sh /log.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "bash", "/etl/src/etl.process.sh" ]