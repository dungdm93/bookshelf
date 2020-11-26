#!/bin/bash

username=$(whoami)
message="SQL Server 2019 will run as non-root by default.\nThis container is running as user $username."

# Find the master database file
master_path=""
mssql_conf="/opt/mssql/bin/mssql-conf"

# Check for master.mdf using environment settings
if [ -n "$MSSQL_MASTER_DATA_FILE" ] && [ -f "$MSSQL_MASTER_DATA_FILE" ]; then
    master_path="$MSSQL_MASTER_DATA_FILE"
elif [ -n "$MSSQL_DATA_DIR" ] && [ -f "$MSSQL_DATA_DIR/master.mdf" ]; then
    # trim any trailing slashes from the path
    trimmed_dir=$(echo "$MSSQL_DATA_DIR" | sed 's:/*$::')
    if [ -f "$trimmed_dir/master.mdf" ]; then
        master_path="$trimmed_dir/master.mdf"
    fi
fi

# If not found, check mssql.conf for location
if [ -z "$master_path" ] && [ -f /var/opt/mssql/mssql.conf ]; then
    # check for master data file
    master_data_file=$($mssql_conf get filelocation masterdatafile | cut -d ':' -f 2 | tr -d ' ')
    if [ -f "$master_data_file" ]; then
        master_path="$master_data_file"
    else
        # check for default data dir
        default_data_dir=$($mssql_conf get filelocation defaultdatadir | cut -d ':' -f 2 | tr -d ' ')
        trimmed_dir=$(echo "$default_data_dir" | sed 's:/*$::')
        if [ -f "$trimmed_dir/master.mdf" ]; then
            master_path="$trimmed_dir/master.mdf"
        fi
    fi
fi

# If not found, check /var/opt/mssql
if [ -f "/var/opt/mssql/data/master.mdf" ] && [ -z "$master_path" ]; then
    master_path="/var/opt/mssql/data/master.mdf"
fi

if [ -n "$master_path" ] && [ -f "$master_path" ]; then
    master_mdf_owner=$(stat -c '%U' "$master_path")
    message="$message\nYour master database file is owned by $master_mdf_owner."
fi

message="$message\nTo learn more visit https://go.microsoft.com/fwlink/?linkid=2099216."
echo -e "$message"

# Execute the cmd from the dockerfile
exec "$@"
