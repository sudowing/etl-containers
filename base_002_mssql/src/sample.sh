#!/bin/bash
. ../log.sh;

# mssql examples
log info 'EXPORT [START]';
$SQLCMD -S $DB_HOST -d $DB_NAME -U $DB_USER -P $DB_PASSWORD -i sql/01_export.sql -o output/some_file.csv;
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
$SQLCMD -S $DB_HOST -d $DB_NAME -U $DB_USER -P $DB_PASSWORD -i sql/02_load.sql;
log info 'LOAD [COMPLETE]';

