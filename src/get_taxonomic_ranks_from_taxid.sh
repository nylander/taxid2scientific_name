#!/bin/bash

id="$1"

efetch -db taxonomy -id "$id" -format xml |
  xtract -pattern Taxon -first TaxId -tab "\n" -element ScientificName \
    -block "**/Taxon" \
      -if Rank -is-not "no rank" -and Rank -is-not clade \
        -tab "\t" -element Rank,ScientificName

