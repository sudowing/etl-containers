#!/bin/bash
. ../log.sh;

# postgres/redshift examples
log info 'EXPORT [START]';
snowsql \
    –accountname $SF_ACCOUNT_NAME \
    –username $SF_USERNAME \
    –dbname $SF_DB_NAME \
    –schemaname $SF_SCHEMA_NAME \
    –rolename $SF_ROLE_NAME \
    –warehouse $SF_WAREHOUSE \
    –host $SF_HOST \
    –port $SF_PORT \
    -f sql/01_export.sql;
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
snowsql \
    –accountname $SF_ACCOUNT_NAME \
    –username $SF_USERNAME \
    –dbname $SF_DB_NAME \
    –schemaname $SF_SCHEMA_NAME \
    –rolename $SF_ROLE_NAME \
    –warehouse $SF_WAREHOUSE \
    –host $SF_HOST \
    –port $SF_PORT \
    sql/02_load.sql;
log info 'LOAD [COMPLETE]';
