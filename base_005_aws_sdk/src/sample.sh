#!/bin/bash
. ../log.sh;

## aws s3 examples
log info 'EXPORT [START]';
aws s3 cp s3://bucket/some_file.csv output/somefile.csv
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
aws s3 cp input/somefile.csv s3://bucket/some_file.csv
log info 'LOAD [COMPLETE]';
