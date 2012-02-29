#!/bin/bash

function return_error {
    >&2 printf "$1\n"
    return $2
}

function mysql_connect {
    local server=$1
    if [ -n $1 ]; then
        return_error "Error: No server specified" 1
        break
    fi
    local username=$2
    local password=$3
    local port=$4
    if [ -z $port ]; then port=3306; fi
    if ! [[ "$port" =~ ^[0-9]+$ ]] ; then
        return_error "Error: Port not a number" 1
        break
    fi
    printf "mysql -sN --host=$server --port=$port --user=$username --password=$password"
}
