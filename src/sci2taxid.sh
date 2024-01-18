#!/bin/bash

## Fetch Genbank taxonomy ID for scientific name.
## Last modified: tor jan 18, 2024  04:40
## By: Johan.Nylander@nrm.se
## Usage: ./sci2taxid.sh infile-with-scientific-names
## Note: No detailed error checking! If any of the scientific names
##       provided as queries are incorrect, the script will
##       print no output for that query.
## Requirements: Entrez Direct suite of software
##       (https://www.ncbi.nlm.nih.gov/books/NBK179288/)

set -euo pipefail

#author_email_address='johan.nylander@nrm.se'
#name_of_script='sci2taxid'
#econtact -email ${author_email_address} -tool ${name_of_script}

count=1
while read org ; do
  if [ "$count" -gt 100 ]; then
    sleep 2
    count=1
  else
    (( count++ ))
  fi
  esearch -db taxonomy -query "$org [Scientific Name]" < /dev/null | \
    efetch -format docsum | \
      xtract -pattern DocumentSummary -element TaxId,ScientificName
done <${1:-/dev/stdin}

