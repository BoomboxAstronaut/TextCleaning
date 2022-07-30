#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", 'headers') or die $!;

my @hold = ();
my $ltrack = 0;
my $active = 1;

while (<$inp>) {
    $ltrack += 1;
    if ($_ =~ /^[|!]/) {
        if ($active) {
            print $oup "$ltrack\n@hold";
            @hold = ();
            $active = 0;
        }
    } elsif ($_ =~ /^[: ]*(\{\{[^{}]*$|\{\|)/) {
        $active = 0;
        @hold = ();
    } elsif ($_ =~ /^[: ]*\{\{[^{}]*\}\}\s*$/i) {
        if (!$active and $#hold > 0) {
            $active = 1;
        }
        if ($#hold > 1) {
            shift(@hold);
        }
        push(@hold, $_);
    }
}

close $inp;
close $oup;

