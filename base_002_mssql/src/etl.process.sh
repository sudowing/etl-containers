#!/bin/bash
. ../log.sh;

sqlcmd="/opt/mssql-tools/bin/sqlcmd"

log info "etl_base_002_mssql";
log info "sqlcmd: $($sqlcmd -?)";
