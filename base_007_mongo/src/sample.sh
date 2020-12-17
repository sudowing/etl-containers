#!/bin/bash
. ../log.sh;


####################
### MONGO_EXPORT
####################

log info 'EXPORT [START]';

TIMESTAMP=$(date +%s)
# echo ${EPOCHREALTIME/./}

# create a directory to hold our data
rm -rf output && mkdir output

# execute export of collection to json
mongoexport \
    -h $DB_HOST:$DB_PORT \
    -d $DB_NAME \
    -u $DB_USER \
    -p $DB_PASS \
    -c $COLLECTION \
    -o output/${TIMESTAMP}.${COLLECTION}.json \
    --jsonArray 1> stdout.log 2> stderr.log;
    # --jsonArray 1> stdout.log &> $(log info);

log info 'EXPORT [COMPLETE]';





####################
### MONGO_IMPORT
####################

log info 'LOAD [START]';

mongoimport \
    --host $DB_HOST \
    --port $DB_PORT \
    -u $DB_USER \
    -p $DB_PASS \
    -d $DB_NAME \
    -c $COLLECTION \
    --file input/data.json \
    --type json \
    --jsonArray 1> stdout.log 2> stderr.log;
    # --jsonArray 1> stdout.log &> $(log info);

log info 'LOAD [COMPLETE]';





####################
### MONGO_ALL
####################

# could also use JQ to send the log as an object
# loop over psql stdout log
while read line; do
    escaped_line=$(echo ${line} | sed 's/"/\\"/g')
    log info "MONGO_IO_CLI: ${line}";
done <stdout.log

# loop over psql stderr log
while read line; do
    escaped_line=$(echo ${line} | sed 's/"/\\"/g')
    log error "MONGO_IO_CLI: ${escaped_line}";
done <stderr.log

