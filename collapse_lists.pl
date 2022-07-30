#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;
open my $replog, ">", 'replog' or die $!;

my $store = '';
my @hold = ();

while (<$inp>) {
    if (!@hold) {
        if ($_ =~ /^\s*[*#;:]/) {
            push(@hold, $_);
        } else {
            print $oup $_;
        }
    } else {
        if ($_ =~ /^\s*[*#;:]/) {
            push(@hold, $_);
        } else {
            if ($#hold > 1) { 
                foreach my $x (@hold) {
                    chomp($x);
                    $store = $store.' '.$x;
                }
                print $replog $store."\n";
                print $oup $_;
            } else {
                print $oup @hold;
                print $oup $_;
            }
            $store = '';
            @hold = ();
        }
    }
}

close $inp;
close $oup;
close $replog;

