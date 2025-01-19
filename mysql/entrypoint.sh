#!/bin/bash

echo "[Custom Entrypoint] Script starting..."

for sql_file in /docker-entrypoint-initdb.d/*.sql; do
    if [ -f "$sql_file" ]; then
        echo "[Custom Entrypoint] Processing SQL file: $sql_file"
        pattern=$(env | awk -F= '{printf "s|\\${%s}|%s|g; ", $1, $2}')
        sed "$pattern" "$sql_file" > "$sql_file.tmp"
        mv "$sql_file.tmp" "$sql_file"
        echo "[Custom Entrypoint] Finished processing: $sql_file"
    fi
done

echo "[Custom Entrypoint] Running original entrypoint..."

exec /entrypoint.sh "$@"