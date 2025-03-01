#!/bin/bash

if [ -z "$(ls -A '/var/lib/postgresql/data')" ]; then
	echo 'Starting backup...'
	until pg_basebackup --pgdata=/var/lib/postgresql/data -R --slot=replication_slot --host=postgres_primary --port=5432 -X stream -P --write-recovery-conf; do
		echo 'Waiting for primary to connect...'
		sleep 1s
	done
	chmod 0700 /var/lib/postgresql/data
	echo "Starting replica"
	postgres
else
	echo "Skipping backup"
	echo "Starting replica"
	postgres
fi
