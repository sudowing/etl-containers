#!/bin/bash
. ../log.sh;

# sftp examples
log info 'EXPORT [START]';
sftp cp host/somefile.csv output/some_file.csv
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
sftp cp input/some_file.csv host/somefile.csv
log info 'LOAD [COMPLETE]';
