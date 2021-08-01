#!/bin/bash
. ../log.sh;

log info "etl_base_009_redshift";
log info "psql: $(psql --version)";
log info "aws: $(aws --version)";
