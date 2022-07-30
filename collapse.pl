#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

#open (my $inp, "<:utf8", $ARGV[0]) or die $!;
#open (my $oup, ">:utf8", $ARGV[1]) or die $!;
open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;
open my $replog, ">", 'replog' or die $!;

my $store = '';
my $limit = 0;
my @hold = ();
my $lintrack = 1;

while (<$inp>) {
    $lintrack += 1;
    if (@hold) {
        if ($limit < 8) {
            if ($_ =~ /^\s*[a-z]/ and $_ =~ /[a-z][;,]?\s*$/) {
                push(@hold, $_);
                $limit += 1;
            } elsif ($_ =~ /^\s*[a-z]/) {
                foreach my $x (@hold) {
                    chomp($x);
                    $store = $store.' '.$x;
                }
                $store = $store.' '.$_;
                print $replog $store;
                print $oup $store;
                $store = '';
                @hold = ();
                $limit = 0;
            } else {
                print $oup @hold;
                @hold = ();
                $limit = 0;
            }
        } else {
            print $oup @hold;
            @hold = ();
            $limit = 0;
        }
    } else {
        if ($_ =~ /^\s*[A-Z].+[a-z][,;]?\s*$/) {
            push(@hold, $_);
            $limit += 1;
        } else {
            print $oup $_;
        }
    }
}


close $inp;
close $oup;
close $replog;

