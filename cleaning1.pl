#!/usr/bin/perl
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;

while (<$inp>) {
	$_ =~ s/([^ -]+)--+([^ -]+)/$1 $2/g;
	$_ =~ s/([^ -]+)-+(?= )/$1/g;
	$_ =~ s/(?<= )-+([^ -]+)/$1/g;
	$_ =~ s/([^ -]+)--+([^ -]+)/$1 $2/g;
	$_ =~ s/--+//g;
	$_ =~ s/'/SQUOTESPOT/g;
	$_ =~ s/-/HYPHENSPOT/ig;
	$_ =~ s/\p{P}|\p{S}/ /g;
	$_ =~ s/\S*\p{N}\S*//g;
	$_ =~ s/\S*[^\p{Latin}\p{Z}]\S*//g;
	$_ =~ s/SQUOTESPOT/'/g;
	$_ =~ s/HYPHENSPOT/-/g;
	$_ =~ s/(?<= )'+//g;
	$_ =~ s/'+(?= )//g;
    print $oup "$_\n";
}
