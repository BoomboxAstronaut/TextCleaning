#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;

while (<$inp>) {
    if ($_ =~ /\{|\}/) {
        $_ =~ s/\{\{\s*as[_ -]*of\s*\|[^{}]*\|([^{}|]*)\}\}/$1/ig;
        $_ =~ s/\{\{\s*as[_ -]*of\s*\|[^{}]*\|([^{}|]*)\}\}/$1/ig;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

