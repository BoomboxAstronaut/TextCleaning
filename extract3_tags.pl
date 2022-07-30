#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;

my $ret = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} [^][{}|]* )*/x;
my $reb = qr/(?<loop> \[ (?> [^][]+ | (?&loop) )* \] [^][{}|]* )*/x;

while (<$inp>) {
    if ($_ =~ /\{|\}/) {
        $_ =~ s/\{\{(1\/2|•|·|co2|pi|0|e|\*|!+|3\/4|--|f\/)\}\}/ $1 /ig;
        $_ =~ s/\{\{(,|"'"|'|'ll|'d|'t|'ve|'re|'m|'s|'"|'-|-'|-"|"-|’)\}\}/$1/ig;
        $_ =~ s/\{\{(asterisk)\}\}/*/ig;
        $_ =~ s/\{\{(hyphen)\}\}/-/ig;
        $_ =~ s/\|\s*(content|text|term|defn|alt|event|lit|note|math[_ -]*statement|ul?)[0-9]?\s*=/|/ig;
        print $oup $_;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

