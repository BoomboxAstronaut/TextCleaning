#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[0].'o' or die $!;

while (<$inp>) {
    if ($_ =~ /\./) {
        $_ =~ s/U\.S\./US/g;
        $_ =~ s/U\.K\./UK/g;
        $_ =~ s/((?<=[" ,;:])|^)([a-z]\.)+[^ .]*/ /ig;
        $_ =~ s/\S*[0-9]+(\.[0-9]+[^,. |]*)+/ /g;
        $_ =~ s/((?<=[" ,;:])|^)((?i)jan|feb|mar|apr|jun|jul|aug|sept|oct|nov|dec|mon|tue|wed|thu|fri|sat|sun|[djsm]r|mrs|ms|sen|gov|rep|rev|md|jd|hon|mt|ft|pvt|sgt|lt|maj|col|gen|fe|st|avg|sq|1st|2nd|3rd|[456789]th)\.\s++(?=([a-z]\S*[ ,]|$))/ $1 /g;
        $_ =~ s/((?<=[" ,;:])|^)((?i)[ap]m|inc|bros|co|ltd|ave|r[td]|k?m\/[hs]|mph|[mkcμn]?(m|hz|g|s)|ha|plc|hp|mi|in|oz|lbs?|rpm)\.\s++(?=([a-z]\S*[ ,]|$))/ $1 /g;
        $_ =~ s/((?<=[" ,;:])|^)(N[or]s?|vs?|mk|etc|rs|ste|lit|viz|app|spp?|var|ca|Op|rbis|p[tlp]?|ff|chs?|loc|et al|vols?|fig|ed|cit|dist|esq|sec|fl|smt|&c|[a-z]|ph|va|ma|fr)\.(?![a-z])/ /ig;
        $_ =~ s/(?<![a-z])no?\s*([0-9])/number $1/ig;
        if ($_ =~ /\.\.\./) {
            $_ =~ s/\.\.\.+\s*+(?=[A-Z])/. /g;
            $_ =~ s/\.\.\.+/ /g;
        }
    }
    print $oup $_;
}

close $inp;
close $oup;

