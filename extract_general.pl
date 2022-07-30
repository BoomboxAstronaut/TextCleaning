#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[0].'o' or die $!;

my $re = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} )+/x;

while (<$inp>) {
    if ($_ =~ /\{|\}/i) {
        while ($_ =~ s/$re/ /g) {}
    }
    if ($_ =~ /<|>/i) {
        while ($_ =~ s/(<\s*\/?\s*(?:su[pb]|(?:span|div|dfn)(?:\s*(?:style|class)=)?|[usipb]|(?:em|tt|td|tr|dt|li|hr|h2)|strong|ref\s*name|include\s*only|section\s*(?:begin|end)|references?|cite|name|samp|ins|\.\.\.|time|abbr|kbd|center|nowiki)[^<>]*\/?\s*>)/ /gi) {}
    }
    if ($_ =~ /\(|\)/i) {
        $_ =~ s/\(([^()]*)(?<=\s|\()(?:[iea]\.?\s*[gek]\s*(?:\.\s*a)?|lit|esp)\.[ ,:]([^()]*)\)/ $1 $2 /ig;
        $_ =~ s/\([-%0-9 –.,×<>_=\/#]+\)/ /g;
        $_ =~ s/\([^()]*[0-9]+:[0-9]+[^()]*\)/ /g;
        $_ =~ s/\([^()]*(?<=\s|\()(ff|pl|p+|chs?|loc|et al|vol(?:s|ume)?|fig|ed|no?\.|cit|dist|[ivx]{2,}\.)\.?\s+[^()]*\)/ /ig;
        $_ =~ s/\([^()]*\.[^()]*\)/ /g;
        while ($_ =~ s/\(([^()]{1,3})\)/$1/g) {}
        while ($_ =~ s/\(([^()]*)\)/ $1 /g) {}
    }
    if ($_ =~ /:\/\//) {
        while ($_ =~ s/(([ts]?ftp|https?):\/\/[^][{}⛀⛂ ,|\"'<>]*)/ /ig) {}
    }
    if ($_ !~ /^\s*$/) {
        print $oup $_;
    }
}

close $inp;
close $oup;

