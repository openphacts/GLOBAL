#!/usr/bin/env bash

## Read in a file of URLs or URL snippets that are URL-encoded and decode them.

## Reads from STDIN and writes to STDOUT.

## Example call:

# ./decode-urls.sh <core-enc.csv >core-dec.csv


urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}


while read in
do
    echo `urldecode $in`
done
