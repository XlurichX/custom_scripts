#!/bin/bash

# file with domains
DOMAINS_FILE="domains"

while IFS= read -r domain; do
    echo "TXT for $domain"
    dig +short TXT "_acme-challenge.$domain"
    echo "-----------------------"
done < "$DOMAINS_FILE"

