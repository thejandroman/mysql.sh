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
