#! /usr/bin/env python3
# vim:fenc=utf-8
# Copyright © 2024 nylander <johan.nylander@nrm.se>
# Distributed under terms of the MIT license.

"""
Query https://www.ebi.ac.uk/ena/taxonomy/rest/scientific-name/+taxon
Return taxId
"""

import sys
import re
import json
import argparse
import requests

def ask_ena(taxon):
    """
    Query ENA for taxId given a scientific name
    """
    taxon = re.sub(' ', '%20', taxon)
    #url = f'https://www.ebi.ac.uk/ena/taxonomy/rest/scientific-name/{taxon}?binomialOnly=false'
    url = f'https://www.ebi.ac.uk/ena/taxonomy/rest/scientific-name/{taxon}?binomialOnly=false'
    response = requests.get(url)
    if response.status_code == 404:
        print(response.status_code)
    if response.status_code == 200:
        response = json.loads(response.text)
        if response != []:
            return response[0]['taxId']
    return 'NoTaxID'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
         description='Query ENA for taxId given a scientific name.')
    parser.add_argument(
        '-v', '--version', action='version', version='%(prog)s 1.0')
    parser.add_argument(
        'taxon', type=str,
        help='Scientific name to query. Note: binomen should be given in quotes.')
    args = parser.parse_args()
    if len(sys.argv)==1:
        parser.print_help(sys.stderr)
        sys.exit(1)
    if args.taxon:
        tax = args.taxon
    else:
        tax = sys.stdin.read().strip()
    print(ask_ena(taxon=tax))
