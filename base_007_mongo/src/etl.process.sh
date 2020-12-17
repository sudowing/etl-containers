#!/bin/bash
. ../log.sh;

log info "etl_base_007_mongo";
log info "mongoimport: $(mongoimport --version)";
log info "mongoexport: $(mongoexport --version)";
