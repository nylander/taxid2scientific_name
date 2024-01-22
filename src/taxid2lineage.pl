#!/usr/bin/env perl
#===============================================================================
=pod

=head2

         FILE: taxid2lineage.pl

        USAGE: ./taxid2lineage.pl file-with-taxids

  DESCRIPTION: Print NCBI taxonomic lineage given Genbank taxids

      OPTIONS: -h, --help

 REQUIREMENTS: BioPerl modules Bio::DB::Taxonomy, Bio::Tree::Tree

         BUGS: ---

        NOTES: Queries NCBI one taxid at the time. Slow!

       AUTHOR: Johan Nylander

      COMPANY: NRM

      VERSION: 0.1

      CREATED: 02/23/2018 09:57:06 AM

     REVISION: ---

=cut

#===============================================================================

use strict;
use warnings;
use Bio::DB::Taxonomy;
use Bio::Tree::Tree;
use Getopt::Long;

exec("perldoc", $0) unless (@ARGV);

GetOptions(
    "h|help" => sub { exec("perldoc", $0); exit(0); },
);

my $dbh = Bio::DB::Taxonomy->new(-source => 'entrez');
my $tree_functions = Bio::Tree::Tree->new();

while (<>) {
    chomp;
    my $taxid = $_;
    my $h = $dbh->get_taxon(-taxonid => "$taxid");
    if ($h) {
        print "taxid:", $taxid, "\t";
    }
    else {
        next;
    }
    my @lineage = $tree_functions->get_lineage_nodes($h);
    foreach my $l (@lineage) {
        if (defined($l->rank)) {
            my $rank = $l->rank;
            $rank =~ s/\s+/_/g;
            print $rank, ':';
        }
        if (defined($$l{'_names_hash'}{'scientific'})) {
            print @{$$l{'_names_hash'}{'scientific'}}, "\t";
        }
    }
    print "\n";
}

