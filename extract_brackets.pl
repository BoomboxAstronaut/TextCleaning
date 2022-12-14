#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open my $inp, "<:utf8", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[1] or die $!;

my $re = qr/(?<loop> \[ (?> [^][]+ | (?&loop) )* \] [^][]* )*/x;

while (<$inp>) {
    if ($_ =~ /\[|\]/) {
        $_ =~ s/\[\[[^][|]*\|([^][|]*$re)\]\]/$1/g;
        $_ =~ s/\[\[([^][|]*)\]\]/$1/g;
        $_ =~ s/(?<!\[)\[([^][]*)\](?!\])/$1/g;
        $_ =~ s/(?<!\[)\[([^][]*)\]/$1/g;
        $_ =~ s/\[([^][]*)\](?!\])/$1/g;
        $_ =~ s/\[\[[^][|]*\|([^][|]*$re)\]\]/$1/g;
        $_ =~ s/\[\[([^][|]*)\]\]/$1/g;
        $_ =~ s/(?<!\[)\[([^][]*)\](?!\])/$1/g;
        $_ =~ s/(?<!\[)\[([^][]*)\]/$1/g;
        $_ =~ s/\[([^][]*)\](?!\])/$1/g;
        print $oup $_;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

