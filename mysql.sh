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
    local port=$2
    if [ -z $port ]; then port=3306; fi
    if ! [[ "$port" =~ ^[0-9]+$ ]] ; then
        return_error "Error: Port not a number" 1
        break
    else
        local username=$3
        local password=$4
    fi
    printf "mysql -sN --host=$server --port=$port --user=$username --password=$password"
}
