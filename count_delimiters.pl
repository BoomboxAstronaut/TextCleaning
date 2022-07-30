#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;

my $total = 0;
my $lcount = 0;
my $rcount = 0;

while (<$inp>) {
    $lcount += tr/⚆//;
    $rcount += tr/⚈//;
}

print "$lcount  $rcount\n";

close $inp;

