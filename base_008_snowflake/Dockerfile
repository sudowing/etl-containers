FROM ubuntu:18.04

RUN apt-get update && apt-get --assume-yes install curl unzip

ENV HOME=/etl/src
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV VERSION 1.2.9
ENV SNOWSQL_DEST /usr/local/bin
ENV SNOWSQL_LOGIN_SHELL $HOME/.bashrc

ENV BASHLOG_JSON=1
ENV BASHLOG_JSON_PATH='app_json.log'
ENV BASHLOG_JSON_STOUT=1
ENV ETL_LOG_STDOUT='/tmp/etl.stdout.log'
ENV ETL_LOG_STDERR='/tmp/etl.stderr.log'

# default to being in the user's home directory
WORKDIR $HOME

RUN touch .bashrc

# grab the installation script (based on work from https://github.com/kurron/docker-snowsql)
RUN curl -o snowsql-${VERSION}-linux_x86_64.bash https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-${VERSION}-linux_x86_64.bash

# Install the tool && remove after complete
RUN bash snowsql-${VERSION}-linux_x86_64.bash && rm snowsql-${VERSION}-linux_x86_64.bash

# Run the SnowSQL client once, allowing it to auto-upgrade to the latest version.
# See https://docs.snowflake.com/en/user-guide/snowsql-install-config.html#label-understanding-auto-upgrades
RUN snowsql -v

COPY src .
COPY log.sh ..

RUN touch $ETL_LOG_STDOUT && touch $ETL_LOG_STDERR

ENTRYPOINT [ "/etl/src/etl.process.sh" ]