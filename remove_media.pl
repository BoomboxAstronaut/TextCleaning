#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[0].'o' or die $!;
open my $klog, ">", 'klog' or die $!;

my $re = qr/\[\[ \s* (file|image|datei|bild|dossier): [^][]* (?<loop> \[ (?> [^][]+ | (?&loop) )* \] [^][]* )* \]\]/xi;

while (<$inp>) {
    if ($_ =~ /\[\[\s*:?(file|image|datei|bild|dossier):/i) {
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

