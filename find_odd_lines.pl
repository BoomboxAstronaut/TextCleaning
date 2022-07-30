#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", 'odd_lines') or die $!;

my $lcount = 0;
my $rcount = 0;
my $ltrack = 0;
my $check = '';

while (<$inp>) {
    $ltrack += 1;
    if ($_ =~ /\{|\}/) {
        $check = $_;
        while ($check =~ s/\{[^{}]*\}//g) {}
        $lcount = ($check =~ tr/{//);
        $rcount = ($check =~ tr/}//);
        if ($lcount % 2 != 0 or $rcount % 2 != 0) {
            print $oup "$ltrack $lcount $rcount\n";
            print $oup $_;
            print $oup $check;
        }
        $lcount = 0;
        $rcount = 0;
    }
}

close $inp;
close $oup;

