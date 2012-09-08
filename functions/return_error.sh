function return_error {
    >&2 printf "$1\n"
    return $2
}
