#!/bin/bash
#
# Init script for template postgis
#

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# createdb -E UTF8 template_postgis;
# createlang -d template_postgis plpgsql;

# Create the 'template_postgis' template db
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE template_postgis;
CREATE OR REPLACE LANGUAGE plpgsql;
CREATE OR REPLACE LANGUAGE plpythonu;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into template_database
for DB in template_postgis; do
  echo "Loading PostGIS extensions into $DB"
  "${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
		GRANT ALL ON geometry_columns TO PUBLIC;
		GRANT ALL ON spatial_ref_sys TO PUBLIC;
EOSQL
done

