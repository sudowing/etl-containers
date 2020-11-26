#!/bin/bash
. ../log.sh;

# filesystem examples
log info 'EXPORT [START]';
mv input/some_file.csv output/some_other_file.csv
log info 'EXPORT [COMPLETE]';

log info 'LOAD [START]';
mv input/some_file.csv output/some_other_file.csv
log info 'LOAD [COMPLETE]';