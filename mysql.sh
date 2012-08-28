#!/bin/bash

function return_error {
    >&2 printf "$1\n"
    return $2
}

function mysql_connect {
    local disableSecureAuth=0
    while getopts ":s:P:u:p:S" option; do
        case "$option" in
            s) local server="$OPTARG";;
            P) local port="$OPTARG";;
            u) local username="$OPTARG";;
            p) local password="$OPTARG";;
            S) disableSecureAuth="1";;
            :) return_error "Error: -$OPTARG requires argument" 1
                return $?;;
            /?) return_error "Error: Incorrect option" 1
                return $?;;
        esac
    done
    if [ "$disableSecureAuth" -eq "1" ]; then
        secureAuth=""
    else
        secureAuth="--secure-auth"
    fi
    if [ -z "$server" ]; then server="localhost"; fi
    if [ -z "$port" ]; then port="3306"; fi
    if ! [[ "$port" =~ ^[0-9]+$ ]] ; then
        return_error "Error: Port not a number" 1
        return $?
    fi
    if [ -z "$username" ]; then
        local userString=""
    else
        local userString="--user=$username"
    fi
    if [ -z "$password" ]; then
        local passString=""
    else
        local passString="--password=$password"
    fi
    printf "mysql %s --batch --host=%s --port=%s %s %s" "$secureAuth" \
"$server" "$port" "$userString" "$passString"
}

function mysql_query {
    while getopts ":l:q:" option; do
        case $option in
            l) local link="$OPTARG";;
            q) local query="$OPTARG";;
            :) return_error "Error: -$OPTARG requires argument" 1
                return $?;;
            /?) return_error "Error: Incorrect option" 1
                return $;;
        esac
    done
    if [ -z "$link" ]; then
        return_error "Error: No link specified" 1
        return $?
    fi
    if [ -z "$query" ]; then
        return_error "Error: No query specified" 1
        return $?
    fi
    local result=$($link -N -e "$query")
    # Need to fix this error so it returns the mysql error
    if [ "$?" -ne 0 ]; then
        return_error "Error: Query failed" 1
        return $?
    fi
    printf "%s\n" "$result"
}

function mysql_result {
    varArray=$result #result from mysql_query
    local oldIFS=$IFS
    IFS=$'\n'
    local i=0
    for newline in $varArray; do
        local oldIFS2=$IFS
        IFS=$'\t'
        for tab in $newline; do
            printf "tab: %s\n" "$tab"
        done
        IFS=$oldIFS2
    done
    IFS=$oldIFS;
}
