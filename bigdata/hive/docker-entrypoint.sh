#!/bin/bash
set -euo pipefail
HERE=$(dirname "${BASH_SOURCE[0]}")

: ${NRETRY:=30}

wait_for() {
    local host=$1 port=$2

    local i=0
    while ! nc -z "$host" "$port" >/dev/null 2>&1; do
        ((i+=1))

        if [ $i -ge $NRETRY ]; then
            echo >&2 "[$(date -Iseconds)] $host:$port still not reachable, giving up"
            exit 1
        fi

        echo "[$(date -Iseconds)] waiting for $host:$port... $i/$NRETRY"
        sleep 3
    done
}

DB_TYPE="postgres"
DB_HOST="postgres"
DB_PORT="5432"

if [ -n "$DB_HOST" ]; then
    wait_for "$DB_HOST" "$DB_PORT"
fi

schematool -dbType "${DB_TYPE}" -upgradeSchema -verbose ||
schematool -dbType "${DB_TYPE}" -initSchema -verbose

exec "$@"
