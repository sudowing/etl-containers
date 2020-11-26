#!/bin/bash
. ../log.sh;

# postgres/redshift examples
log info 'EXPORT [START]';
psql -h $DB_HOST -d $POSTGRES_DB -U $POSTGRES_USER -f sql/01_export.sql;
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
psql -h $DB_HOST -d $POSTGRES_DB -U $POSTGRES_USER -f sql/02_load.sql;
log info 'LOAD [COMPLETE]';
