#! /usr/bin/env python3
# vim:fenc=utf-8
# Copyright © 2024 nylander <johan.nylander@nrm.se>
# Distributed under terms of the MIT license.

"""
Query https://www.ebi.ac.uk/ena/taxonomy/rest/tax-id/+taxid

"""

import sys
import json
import argparse
import requests

def ask_ena(taxid):
    """
    Query ENA for taxon given a taxId
    """
    url = f'https://www.ebi.ac.uk/ena/taxonomy/rest/tax-id/{taxid}'
    response = requests.get(url)
    if response.status_code == 404:
        print(response.status_code)
    if response.status_code == 200:
        response = json.loads(response.text)
        return response['scientificName']
    return 'NoTaxon'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Query ENA for taxon given a taxId.')
    parser.add_argument(
        '-v', '--version', action='version', version='%(prog)s 1.0')
    parser.add_argument(
        'taxid', type=str, help='NCBI/ENA taxId to query')
    args = parser.parse_args()
    if len(sys.argv)==1:
        parser.print_help(sys.stderr)
        sys.exit(1)
    if args.taxid:
        tax = args.taxid
    else:
        tax = sys.stdin.read().strip()
    print(ask_ena(taxid=tax))
