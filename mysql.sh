#!/bin/bash

function return_error {
    >&2 printf "$1\n"
    return $2
}

function mysql_connect {
    while getopts "s:P:u:p:S" option; do
        case "$option" in
            s) local server="$OPTARG";;
            P) local port="$OPTARG";;
            u) local username="$OPTARG";;
            p) local password="$OPTARG";;
            S) local disableSecureAuth="1";;
            :) local rtrn=$(return_error "Error: -$OPTARG requires argument" 1)
                return $rtrn;;
            /?) local rtrn=$(return_error "Error: Incorrect option" 1)
                return $rtrn;;
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
        local rtrn=$(return_error "Error: Port not a number" 1)
        return $rtrn
    fi
    if [ -z "$username" ]; then
        local userString=""
    else
        local userString="--user=\"$username\""
    fi
    if [ -z "$password" ]; then
        local passString=""
    else
        local passString="--password=\"$password\""
    fi
    printf "mysql $secureAuth --batch --host=$server --port=$port $userString \
$passString"
}

function mysql_query {
    while getopts "l:q:v:" option; do
        case $option in
            l) local link="$OPTARG";;
            q) local query="$OPTARG";;
            v)
                local OLD_IFS=$IFS
                IFS=''
                local varString="$OPTARG[*]"
                local varArray=(${!varString})
                IFS=$OLD_IFS;;
            :) local rtrn=$(return_error "Error: -$OPTARG requires argument" 1)
                return $rtrn;;
            /?) local rtrn=$(return_error "Error: Incorrect option" 1)
                return $rtrn;;
        esac
    done
    if [ -z "$link" ]; then
        local rtrn=$(return_error "Error: No link specified" 1)
        return $rtrn
    fi
    if [ -z "$query" ]; then
        local rtrn=$(return_error "Error: No query specified" 1)
        return $rtrn
    fi
    varArray=($($link -B -e $query))
    if [ ! "$?" ]; then
        local rtrn=$(return_error "Error: Query failed" 1)
        return $rtrn
    fi
}
