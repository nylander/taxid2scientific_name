# Scientific name \<=\> Taxon ID

Several variants on the same theme: get taxon ID from taxon name or the other
way around.

All scripts requires an internet accession and access to specific databases
([Genbank Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) or [ENA
Taxonomy](https://www.ebi.ac.uk/ena/taxonomy/rest/swagger-ui/index.html)).

## taxid2sci.sh, sci2taxid.sh

Get scientific name from Genbank taxon ID - or the other way around.

**Input:** File with taxids/scientific names

**Output:** Writes TaxID, rank, and taxon name to stdout.

**Notes:** The script `taxid2sci.sh` sends and retrieves queries in batches.  Output order
  can be different than input order!  To ensure the same input/output order, use
  sorting (see Examples).
  If the query cannot be found in [NCBI
  Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy), it is silently ignored in
  output.

**Examples:**

    $ ./src/taxid2sci.sh data/taxids.txt
    3055	species	Chlamydomonas reinhardtii
    3052	genus	Chlamydomonas
    3047	species	Dunaliella tertiolecta
    3046	species	Dunaliella salina

    $ ./src/taxid2sci.sh <(sort data/taxids.txt) | sort
    3046	species	Dunaliella salina
    3047	species	Dunaliella tertiolecta
    3052	genus	Chlamydomonas
    3055	species	Chlamydomonas reinhardtii

    $ ./src/sci2taxid.sh data/scinames.txt
    3055	species	Chlamydomonas reinhardtii
    3052	genus	Chlamydomonas
    3047	species	Dunaliella tertiolecta
    3046	species	Dunaliella salina

**Requirements:**

- Internet connection
- Entrez Direct suite of software (<https://www.ncbi.nlm.nih.gov/books/NBK179288/>)

## taxid2lineage.pl

Get full taxonomic lineage from Genbank taxon ID.

**Input:** File with taxids

**Output:** Writes taxon lineage with ranks to stdout.

**Notes:** Sends and retrieves queries one by one (slow).

**Examples:**

    $ ./src/taxid2lineage.pl data/taxids.txt
    taxid:3046	no_rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	clade:core chlorophytes	class:Chlorophyceae	clade:CS clade	order:Chlamydomonadales	family:Dunaliellaceae	genus:Dunaliella
    taxid:3047	no_rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	clade:core chlorophytes	class:Chlorophyceae	clade:CS clade	order:Chlamydomonadales	family:Dunaliellaceae	genus:Dunaliella
    taxid:3052	no_rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	clade:core chlorophytes	class:Chlorophyceae	clade:CS clade	order:Chlamydomonadales	family:Chlamydomonadaceae
    taxid:3055	no_rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	clade:core chlorophytes	class:Chlorophyceae	clade:CS clade	order:Chlamydomonadales	family:Chlamydomonadaceae	genus:Chlamydomonas

    $ ./src/taxid2lineage.pl data/taxids.txt | cut -f5- | sed 's/\w\+://g'
    Chlorophyta	core chlorophytes	Chlorophyceae	CS clade	Chlamydomonadales	Dunaliellaceae	Dunaliella	
    Chlorophyta	core chlorophytes	Chlorophyceae	CS clade	Chlamydomonadales	Dunaliellaceae	Dunaliella	
    Chlorophyta	core chlorophytes	Chlorophyceae	CS clade	Chlamydomonadales	Chlamydomonadaceae	
    Chlorophyta	core chlorophytes	Chlorophyceae	CS clade	Chlamydomonadales	Chlamydomonadaceae	Chlamydomonas

**Requirements:**

- Internet connection
- Perl
- [BioPerl](https://bioperl.org) modules `Bio::DB::Taxonomy` and
    `Bio::Tree::Tree`.

## ask\_ena\_for\_taxid.py, ask\_ena\_for\_taxon.py

Query the [ENA taxonomy
database](https://www.ebi.ac.uk/ena/taxonomy/rest/swagger-ui/index.html) for
either taxId or taxon.

**Input:** string (with either taxId or taxon)

**Output:** writes to stdout (either taxId or taxon)

**Notes:** Binomen as argument needs to be quoted (e.g. 'Homo sapiens')

**Examples:**

    $ ./src/ask_ena_for_taxid.py 'Dunaliella salina'
    3046
    $ ./src/ask_ena_for_taxon.py 3046
    Dunaliella salina

**Requirements:**

- Internet connection
- Python
- Python modules `json` and `requests`

