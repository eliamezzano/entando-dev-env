#!/usr/bin/env bash

#warning: uncomment the following lines to enable "trust" authentication for local connections
sed -i 's/local all all ident/local all all trust/g' "${PGDATA}"/pg_hba.conf
pg_ctl reload -D "${PGDATA}"

