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
