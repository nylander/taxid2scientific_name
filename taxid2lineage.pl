#!/usr/bin/perl 
#===============================================================================
=pod


=head2

         FILE: taxid2lineage.pl

        USAGE: ./taxid2lineage.pl file-with-taxids 

  DESCRIPTION: Print NCBI taxonomic lineage given Genbank taxids 

      OPTIONS: ---

 REQUIREMENTS: ---

         BUGS: ---

        NOTES: ---

       AUTHOR: Johan Nylander (JN), johan.nylander@nbis.se

      COMPANY: NBIS/NRM

      VERSION: 1.0

      CREATED: 02/23/2018 09:57:06 AM

     REVISION: ---

=cut


#===============================================================================

use strict;
use warnings;
use Data::Dumper;
use Bio::DB::Taxonomy;
use Bio::Tree::Tree;
#use Getopt::Long;

#exec("perldoc", $0) unless (@ARGV);

#my $infile  = q{};
#my $outfile = q{};
#my $VERBOSE = 0;
#GetOptions("infile=s"  => \$infile,
#           "outfile=s" => \$outfile,
#           "verbose!"  => \$VERBOSE,
#           "help"      => sub { exec("perldoc", $0); exit(0); },
#          );

my $dbh = Bio::DB::Taxonomy->new(-source => 'entrez');
my $tree_functions = Bio::Tree::Tree->new();

while (<>) {
    chomp;
    my $taxid = $_;
    print "taxid:", $taxid, "\t"; 
    my $h = $dbh->get_taxon(-taxonid => "$taxid");
    #my $lineage = $tree_functions->get_lineage_string($h);
    #print $lineage, "\n";
    #print STDERR "rank is ", $h->rank, "\n";
    my @lineage = $tree_functions->get_lineage_nodes($h);
    foreach my $l (@lineage) {
        if (defined($l->rank)) {
            my $rank = $l->rank;
            $rank =~ s/\s+/_/g;
            print $rank, ':';
        }
        if (defined($$l{'_names_hash'}{'scientific'})) {
            print @{ $$l{'_names_hash'}{'scientific'} }, "\t";
        }
    }
    print "\n";
}

