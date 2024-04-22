#! /usr/bin/env perl
#
# Usage: sci2taxid.pl [-v][-h] taxids
#
# Copyright (C) 2024 nylander <johan.nylander@nrm.se>
# Last modified: mån apr 22, 2024  12:36

use strict;
use warnings;
use Bio::DB::Taxonomy;
use Try::Tiny;
use Getopt::Long;

my $version = '0.1';

GetOptions(
    "h|help" => sub { print "Usage: $0 taxids\n"; exit(0); },
    "v|version" => sub { print "$version\n"; exit(0); },
);

while (<>) {
    my $string = $_;
    chomp($string);
    next if ($string =~ /^$/);
    my $db = Bio::DB::Taxonomy->new(-source => 'entrez');
    my @taxonids;
    $string = $string . '['; # old workaround for BioPerl bug
    try {
        (@taxonids) = $db->get_taxonids("$string");
    }
    catch {
        warn "caught error: $_";
    };
    $string =~ s/\[$//; # workaround for BioPerl bug
    if (@taxonids) {
        print "$taxonids[0]\t$string\n";
    }
    else {
        print "No_hit\t $string\n";
    }
    sleep 1;
}

__DATA__
Lissotriton vulgaris
Chlorella vulgaris
Phygadeuon solidus
Phygadeuon solidus[
Ovatus
Phygadeuon ovatus
Phygadeuon ovatus[Scientific Name]
Phygadeuon ovatus[All Names]
Phygadeuon ovatus[]
Phygadeuon ovatus[

