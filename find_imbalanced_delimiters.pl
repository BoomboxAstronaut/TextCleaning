#!/usr/bin/perl

use strict;
use warnings;

open my $inp, "<", $ARGV[0] or die $!;
open my $oup, ">", $ARGV[1] or die $!;

my $check = '';
my $re = qr/(?<loop> \{ (?> [^{}]+ | (?&loop) )* \} [^{}]* )*/x;

our $lcount = 0;
our $rcount = 0;

while (<$inp>) {
    if ($_ =~ /\{|\}/) {
        $check = $_;
        while ($check =~ s/\{\{[^{}]*\}\}//g) {}
        while ($check =~ s/\{[^{}]*\}//g) {}
        $lcount = ($check =~ tr/{// / 2);
        $rcount = ($check =~ tr/}// / 2);
        while ($rcount > 0.5) {
            $_ =~ s/^([^{}]*$re)\}\}/$1☝/g;
            $rcount -= 1;
        }
        while ($lcount > 0.5) {
            $_ =~ s/\{\{([^{}]*$re)$/☟$1/g;
            $lcount -= 1;
        }
        print $oup $_;
        $lcount = 0;
        $rcount = 0;
    } else {
        print $oup $_;
    }
}

close $inp;
close $oup;

