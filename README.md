# Get Scientific Name from Genbank Taxon ID

- Fri 23 Feb 2018 02:15:56 PM CET
- Johan.Nylander\@{nrm|nbis}.se

## taxid2sci.sh

Get taxon name from Genbank taxon ID.

- Input: file with taxids

- Output: writes TaxID, rank, and taxon name to stdout.

- Usage: `taxid2sci.sh inputfile`

- Example:

    $ ./taxid2sci.sh taxids.txt
    1917417	species	Trebouxia sp. TZW2008
    1889259	species	Chlamydomonas klinobasis
    1735750	species	Bathycoccus sp. TOSAG39-1
    1667192	species	Coccomyxa sp. SUA001

- Requirements: [Entrez Direct suite of software](https://www.ncbi.nlm.nih.gov/books/NBK179288/)

## taxid2lineage.pl

Get full taxonomic lineage from Genbank taxon ID.

- Input: file with taxids

- Output: writes taxon lineage with ranks to stdout.

- Usage: `taxid2lineage.pl inputfile`

- Examples:

    $ ./taxid2lineage.pl taxids.txt
    taxid:3046	no rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	class:Chlorophyceae	order:Chlamydomonadales	family:Dunaliellaceae	genus:Dunaliella	
    taxid:3047	no rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	class:Chlorophyceae	order:Chlamydomonadales	family:Dunaliellaceae	genus:Dunaliella	
    taxid:3052	no rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	class:Chlorophyceae	order:Chlamydomonadales	family:Chlamydomonadaceae	
    taxid:3055	no rank:cellular organisms	superkingdom:Eukaryota	kingdom:Viridiplantae	phylum:Chlorophyta	class:Chlorophyceae	order:Chlamydomonadales	family:Chlamydomonadaceae	genus:Chlamydomonas	

    $ ./taxid2lineage.pl taxids.txt | cut -f3- | sed 's/\w\+://g'
    Eukaryota	Viridiplantae	Chlorophyta	Chlorophyceae	Chlamydomonadales	Dunaliellaceae	Dunaliella	
    Eukaryota	Viridiplantae	Chlorophyta	Chlorophyceae	Chlamydomonadales	Dunaliellaceae	Dunaliella	
    Eukaryota	Viridiplantae	Chlorophyta	Chlorophyceae	Chlamydomonadales	Chlamydomonadaceae	
    Eukaryota	Viridiplantae	Chlorophyta	Chlorophyceae	Chlamydomonadales	Chlamydomonadaceae	Chlamydomonas	

- Requirements: Perl, [BioPerl](https://bioperl.org)


