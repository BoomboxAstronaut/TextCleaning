#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[0].'o' or die $!;
open my $klog, ">", 'klog' or die $!;
my $words = $ARGV[1];

my $re = qr/\{\{ \s* ($words) \s* \| [^{}]* (?<loop> \{ (?> [^{}]+ | (?&loop) )* \} [^{}]* )* \}\}/xi;

while (<$inp>) {
    if ($_ =~ /\{\{\s*($words)\s*\|/i) {
        while ($_ =~ s/($re)/ /g) {
            print $klog "$1\n";
        }
        print $oup $_;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;
close $klog;

