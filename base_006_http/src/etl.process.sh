#!/bin/bash
. ../log.sh;

log info "etl_06_http";
log info "python3: $(python3 --version)";
log info "pip3 freeze: $(pip3 freeze)";
log info "jq: $(jq --version)";
log info "curl: $(curl --version)";
