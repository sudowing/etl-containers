#!/bin/bash
. ../log.sh;

log info "etl_base_000_transform";
log info "python3: $(python3 --version)";
log info "sqlite3: $(sqlite3 --version)";
log info "jq: $(jq --version)";
log info "unzip: $(unzip -v)";
