#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[0].'o' or die $!;
open my $klog, ">", 'klog' or die $!;
my $words = $ARGV[1];

my $re = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} )+/x;

while (<$inp>) {
    if ($_ =~ /\{|\}/i) {
        while ($_ =~ s/($re)/ /g) {
            print $klog "$1\n";
        }
    }
    if ($_ !~ /^\s*$/) {
        print $oup $_;
    }
}

close $inp;
close $oup;
close $klog;

