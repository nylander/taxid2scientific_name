#!/bin/bash

## Fetch scientific name for Genbank taxonomy ID
## Last modified: tor jan 18, 2024  04:59
## By: Johan.Nylander@nrm.se
## Usage: ./taxid2sci.sh infile-with-taxids
## Note: No detailed error checking! If any of the taxids
##       provided as queries are incorrect, the script will
##       exit with msg: "Failure of post to find data to load.."
## Requirements: Entrez Direct suite of software
##       (https://www.ncbi.nlm.nih.gov/books/NBK179288/)

set -euo pipefail

#author_email_address='johan.nylander@nbis.se'
#name_of_script='taxid2sci'
#econtact -email ${author_email_address} -tool ${name_of_script}

xargs -n 200 <${1:-/dev/stdin} | tr ' ' ',' | \
    xargs -n 1 sh -c '
      epost -db taxonomy -id "$0" | \
        efetch -format docsum | \
          xtract -pattern DocumentSummary -element TaxId,Rank,ScientificName'

