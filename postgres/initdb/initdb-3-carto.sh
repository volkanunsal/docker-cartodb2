#!/bin/bash
#
# Init script for integration of carto extensions to postgis.
#

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Load PostGIS into template_database
for DB in template_postgis; do
  echo "Loading Carto extensions into $DB"
  "${psql[@]}" --dbname="$DB" <<-'EOSQL'
    CREATE EXTENSION IF NOT EXISTS plpythonu;
    CREATE EXTENSION IF NOT EXISTS schema_triggers;
    CREATE EXTENSION IF NOT EXISTS cartodb;
EOSQL
done