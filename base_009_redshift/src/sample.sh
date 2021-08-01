#!/bin/bash
. ../log.sh;

# postgres/redshift examples (using .sequel instead of .sql to prevent collision)
log info 'EXPORT [START]';
psql -h $DB_HOST -d $POSTGRES_DB -U $POSTGRES_USER -f sql/01_export.sequel;
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
psql -h $DB_HOST -d $POSTGRES_DB -U $POSTGRES_USER -f sql/02_load.sequel;
log info 'LOAD [COMPLETE]';
