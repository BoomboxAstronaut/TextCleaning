#!/usr/bin/perl
#
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;

my $ret = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} [^{}|]* )*/x;
my $rea = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} [^{}]* )*/x;
my $sre = qr/[^{}|]*$ret/i;
my $sra = qr/[^{}]*$rea/i;
my $ex1 = qr/[^{}|]*(?:\{\{[^{}]*\}\}[^{}|]*)?/;
my $store = '';

my $words2 = '(?:abbr(?:eviation|v|link)?|cnote|h:title|resize|tooltip|verse[_ -]*translation|transl|wikt[_ -]*lang|(?:font[_ -]*)?color(?:[_ -]*box)?|currency|sclass)';

my $words1 = '(?:allcaps?|big|block[_ -]*indent|(?:angle[_ -]*)?bracket|c\.|center|char|as\s*of|currency|em|illm?|interlanguage[_ -]*link|link\s*text|large|lit(?:\.|erally)?|music|nihongo|not[_ -]*a[_ -]*typo|hat[_ -]*note|note[_ -]*tag|trans(?:lation)?|no[_ -]*(?:wr(?:ap)?|br(?:eak)?|italics?|bold)|defn(?:-[a-z]+)?|rws|stn|samp|sc2?|sm(?:all)?(?:caps|er)?|(?:simple)?nuclide|subatomic[_ -]*particle|sub|sup|tdes|term|visible[_ -]*anchor|sic|wikt[-_ a-zA-Z]*|underline|timeline[_ -]*event|us\\$|tag|font|mono|var|ship|"|(?:block|[a-z]|box|poem|(?:centered|reduced)?\s*pull)?\s*quot(?:e|e[_ -]*(?:box|frame)|ation))';

while (<$inp>) {
    if ($_ =~ /\{|\}/) {
        if ($_ =~ /\{\{\s*ety(?:mology)?/) {
           if ($_ =~ s/\{\{\s*ety(?:mology)?\s*\|$ex1\|$ex1\|($ex1)\|$ex1\|$ex1\|($ex1)\}\}/ $1 $2 /igx) {}
           elsif ($_ =~ s/\{\{\s*ety(?:mology)?\s*\|$ex1\|$ex1\|($ex1)\}\}/ $1 /igx) {}
           elsif ($_ =~ s/\{\{\s*ety(?:mology)?\s*\|$ex1\|($ex1)\}\}/ $1 /igx) {}
        }
        if ($_ =~ /\{\{\s*gli\s*\|/i) {
            $_ =~ s/\{\{\s*gli\s*\|$ex1\|($ex1)\}\}/ $1 /g;
            $_ =~ s/\{\{\s*gli\s*\|($ex1)\}\}/ $1 /g;
        }
        while ($_ =~ s/\{\{\s*shy\s*\|([^{}]*)\}\}/TEMPLACEHOLD/i) {
            $store = $1;
            $store =~ s/\|//g;
            $_ =~ s/TEMPLACEHOLD/ $store /;
        }
        while ($_ =~ s/\{\{\s*(?:shy|chem)[1-9]?\s*\|([^{}]*)\}\}/TEMPLACEHOLD/i) {
            $store = $1;
            $store =~ s/\|//g;
            $_ =~ s/TEMPLACEHOLD/ $store /;
        }
        while ($_ =~ s/\{\{\s*(?:sortname|s(?:ection)?[_ -]*link)[1-9]?\s*\|([^{}]*)\}\}/TEMPLACEHOLD/i) {
            $store = $1;
            $store =~ s/\|/ /g;
            $_ =~ s/TEMPLACEHOLD/ $store /;
        }
        if ($_ =~ /\{\{\s*(cvt|convert)\s*\|/i) {
            $_ =~ s/\{\{\s*(cvt|convert)\s*\|([^{}|]*)\|([^{}|]*)[^{}]*\}\}/ $1 $2 /gi;
        }
        while ($_ =~ s/\{\{\s*$words2[1-9]?\s*\|$sre\|($sre)(?:\|$sra)?\}\}/ $2 /gi) {}
        while ($_ =~ s/\{\{\s*$words1[1-9]?\s*\|($sre)(?:$sra)?\}\}/ $1 /gi) {}
        print $oup $_;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

