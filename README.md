# Scientific Name \<=\> Genbank Taxon ID

- Last modified: mån jan 22, 2024  09:32
- Sign: Johan Nylander

## taxid2sci.sh, sci2taxid.sh

### Description

Get scientific name from Genbank taxon ID - or the other way around.

### Input

File with taxids/scientific names

### Output

Writes TaxID, rank, and taxon name to stdout.

### Notes

The script `taxid2sci.sh` sends and retrieves queries in batches.  Output order
can be different than input order!  To ensure the same input/output order, use
sorting (see Examples).

If the query cannot be found in [NCBI
Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy), it is silently ignored in
output.

### Examples

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

### Requirements

- Internet connection
- [Entrez Direct suite of software](https://www.ncbi.nlm.nih.gov/books/NBK179288/)

---

## taxid2lineage.pl

### Description

Get full taxonomic lineage from Genbank taxon ID.

### Input

File with taxids

### Output

Writes taxon lineage with ranks to stdout.

### Notes

Sends and retrieves queries one by one (slow).

### Examples

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

### Requirements

- Internet connection
- Perl
- [BioPerl](https://bioperl.org) modules `Bio::DB::Taxonomy` and
  `Bio::Tree::Tree`.


