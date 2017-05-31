#!/usr/bin/env bash

## Read in a file of URLs or URL snippets that are URL-encoded and decode them.

## Reads from STDIN and writes to STDOUT.

## Example call:

# ./encode-urls.sh <core-dec.csv >core-enc.csv


## Function to perform URL encoding of URLs passed to HTTP web services.

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}


while read in
do
    echo `urlencode $in`
done
