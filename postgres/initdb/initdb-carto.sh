#!/bin/bash
#
# Init script for carto extensions and other tune-ups
#

# Tune PostgreSQL
pgtune -T Web -c 100 -i "$PGDATA/postgresql.conf" -o "$PGDATA/postgresql.conf.pgtune" \
    && mv "$PGDATA/postgresql.conf" "$PGDATA/postgresql.conf.orig" \
    && mv "$PGDATA/postgresql.conf.pgtune" "$PGDATA/postgresql.conf"

# Configure schema_triggers
sed -i \
    "/#shared_preload/a shared_preload_libraries = 'schema_triggers.so'" \
    "$PGDATA/postgresql.conf"


