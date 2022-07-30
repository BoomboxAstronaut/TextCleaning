#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[1] or die $!;

while (<$inp>) {
    if ($_ =~ /\(|\)/i) {
        while ($_ =~ s/\(([^()]*)\)/$1/g) {}
    }
    print $oup $_;
}

close $inp;
close $oup;

