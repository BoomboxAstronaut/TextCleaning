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
        if ($_ =~ /\{\{\s*esccnty\s*\|/i) {
            if ($_ =~ /\|\s*t\s*=/) {
                $_ =~ s/\{\{\s*esccnty\s*\|[^{}]*t\s*=([^{}|]*)[^{}]*\}\}/ $1 /gi;
            } else {
                $_ =~ s/\{\{\s*esccnty\s*\|([^{}|]*)[^{}]*\}\}/ $1 /gi;
            }
        } elsif ($_ =~ /\{\{\s*zh\s*\|/i) {
            if ($_ =~ /\|\s*l\s*=/) {
                $_ =~ s/\{\{\s*zh\s*\|[^{}]*l\s*=([^{}|]*)[^{}]*\}\}/ $1 /gi;
            }
        } elsif ($_ =~ /\{\{\s*usd\s*\|/i) {
            $_ =~ s/\{\{\s*usd\s*\|([^{}|]*)[^{}]*\}\}/ $1 dollars /gi;
        }
        if ($_ =~ /\|\s*(caption|extra|footer|translation|description|ps)[0-9]?\s*=/i) {
            $_ =~ s/\|\s*(?:caption|extra|footer|translation|description|ps)[0-9]?\s*=([^][{}|]*$reb$ret)//ig;
            $_ = " $1 $_";
        }
        $_ =~ s/\{\{(1\/2|•|·|co2|pi|0|e|\*|!+|3\/4|--|f\/|=)\}\}/ $1 /ig;
        $_ =~ s/\{\{(,|"'"|'|'ll|'d|'t|'ve|'re|'m|'s|'"|'-|-'|-"|"-|’)\}\}/$1/ig;
        $_ =~ s/\{\{asterisk\}\}/*/ig;
        $_ =~ s/\{\{hyphen\}\}/-/ig;
        $_ =~ s/\|\s*(?:content|text|term|defn|alt|event|lit|note|math[_ -]*statement|ul?)[0-9]?\s*=/|/ig;
        $_ =~ s/\|\s*([a-z0-9]+\s*){1,3}=[^{}|]*//ig;
        print $oup $_;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

