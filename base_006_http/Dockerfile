FROM python:3-slim

RUN apt-get update
RUN apt-get -y install jq curl

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1

ENV HOME=/etl/src

COPY requirements.txt .
RUN pip3 install -r requirements.txt

WORKDIR $HOME
COPY src .
COPY log.sh ..


ENTRYPOINT [ "/etl/src/etl.process.sh" ]