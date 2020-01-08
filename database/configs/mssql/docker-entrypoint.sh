#!/bin/bash
# This file is create as replacement of permissions_check.sh,
# in order to support docker-entrypoint-initdb.d, as well as
# folowing entrypoint standard of MySQL, PostgeSQL, MongoDB
set -Eeo pipefail
export PATH=/opt/mssql/bin:/opt/mssql-tools/bin:$PATH

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		mysql_error "Both $var and $fileVar are set (but are exclusive)"
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

_main() {
	# if command starts with an option, prepend sqlservr
	if [ "${1:0:1}" = '-' ]; then
		set -- sqlservr "$@"
	fi

	# TODO

	exec "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
