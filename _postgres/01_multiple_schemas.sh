#!/usr/bin/env bash

set -e
set -u

pg_ctl restart

function create_user_and_schema() {
#    params=$(echo $1 | tr ':' '\n')
    IFS=':' read -r -a params <<< "$1"
    username=${params[0]}
    password=${params[1]}
    schema=${params[2]}
    echo "  Creating user '$username' with password '$password' "
    psql --username "$POSTGRES_USER" -c "CREATE ROLE $username LOGIN PASSWORD '$password' CREATEDB VALID UNTIL 'infinity';" || true
    echo "  Created user '$username' with password '$password' "

    echo "  Creating schema '$schema' on DB '$POSTGRES_DB' "
    psql -d $POSTGRES_DB -U $POSTGRES_USER -c "CREATE SCHEMA $schema AUTHORIZATION $username;" || true
    echo "  Created schema '$schema' on DB '$POSTGRES_DB' "

}

if [ -n "$POSTGRES_MULTIPLE_SCHEMAS" ]; then
    echo "Multiple schema creation requested: $POSTGRES_MULTIPLE_SCHEMAS"
    for schema in $(echo $POSTGRES_MULTIPLE_SCHEMAS | tr ',' ' '); do
      echo "  Starting to create schema '$schema' "
      create_user_and_schema $schema
    done
    echo "Multiple schema created"
fi
