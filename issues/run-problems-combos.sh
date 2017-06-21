#!/usr/bin/env bash

## A script for testing the LDA (Open PHACTS Linked Data API) on two versions of
## IMS and SPARQL endpoints.  Purpose is to be able to determine whether an issue
## is due to difference between IMS on v2.1 versus v2.2 or due to a Virtuoso/SPARQL
## difference.

## Each problem command is called 4 times with different combos of IMS and SPARQL
## endpoints.  The result of each call is written to files in the "out" directory.

## Issues to test are read from a csv file containing commands with issues/problems.
## Issues obtained from GitHub Issues here:
##      https://github.com/openphacts/GLOBAL/issues

problems_file="$HOME/gh/openphacts/GLOBAL/issues/problem-calls-encoded.csv"

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

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

## LDA, IMS, and SPARQL endpoints

apiurl="http://localhost:3002"
imsurl1=`urlencode "http://beta.openphacts.org:3004"`
sparqlurl1=`urlencode "http://beta.openphacts.org:3003/sparql"`
imsurl2=`urlencode "http://alpha.openphacts.org:3004"`
sparqlurl2=`urlencode "http://alpha.openphacts.org:8890/sparql"`

## Where to save results:

outdir="${HOME}/gh/openphacts/GLOBAL/issues/out"
mkdir -p "$outdir"

function testit() {
    call=$1
    issue_number=$2
    call11="${apiurl}${call}&_imsendpoint=${imsurl1}&_sparqlendpoint=${sparqlurl1}"
    call12="${apiurl}${call}&_imsendpoint=${imsurl1}&_sparqlendpoint=${sparqlurl2}"
    call21="${apiurl}${call}&_imsendpoint=${imsurl2}&_sparqlendpoint=${sparqlurl1}"
    call22="${apiurl}${call}&_imsendpoint=${imsurl2}&_sparqlendpoint=${sparqlurl2}"
    echo $call11
    curl "$call11" >"${outdir}/${issue_number}_11"
    echo $call12
    curl "$call12" >"${outdir}/${issue_number}_12"
    echo $call21
    curl "$call21" >"${outdir}/${issue_number}_21"
    echo $call22
    curl "$call22" >"${outdir}/${issue_number}_22"
}

while read line
do
   ## Split on "," into 3 fields: issue-number, issue-status, LDA command
   sp=(${line//,/ })
   issue="${sp[0]}"
   status="${sp[1]}"
   call="${sp[2]}"
   ## Skip closed issues and skip header (first) line of issues file.
   if [ $status != 'closed' ] && [ $status != 'Status' ] ; then
     testit $call $issue
   fi
done < $problems_file