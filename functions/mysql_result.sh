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
