#!/bin/bash

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
    printf "mysql %s --host=%s --port=%s %s %s" "$secureAuth" \
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
    if regexCheck "select" $query -o regexCheck "show" $query -o regexCheck /
        "describe" $query -o regexCheck "explain" $query; then
        local result=$($link -B -N -e "$query")
    # Need to fix this error so it returns the mysql error
        if [ "$?" -ne 0 ]; then
            return_error "Error: Query failed" 1
            return 1
        fi
        printf "%s\n" "$result"
    else
		local result=$($link -B -N -e "$query")
		if [ "$?" -ne 0 ]; then
            return_error "Error: Query failed" 1
            return 1
        fi
        return 0
    fi
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

function regexCheck {
    if [[ $# -ne 2 ]]; then
        echo "Incorrect usage of regexCheck."
        exit 1
    fi
    local regex=$1
    shopt -s nocasematch
    if [[ $2 =~ $regex ]]; then
        shopt -u nocasematch
        return 0
    else
        shopt -u nocasematch
        return 1
    fi
}

function return_error {
    >&2 printf "$1\n"
    return $2
}
