#!/usr/bin/perl

use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

#open (my $inp, "<:utf8", $ARGV[0]) or die $!;
#open (my $oup, ">:utf8", $ARGV[1]) or die $!;
open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;
open my $errlog, ">", 'errlog' or die $!;
open my $replog, ">", 'replog' or die $!;

my $store = '';
my $limit = 0;
my @hold = ();
my $lintrack = 1;
my $ldl = "⛁";
my $rdl = "⛃";

while (<$inp>) {
    $lintrack += 1;
    if (@hold) {
        if ($limit < 128) {
            if ($_ =~ /^[^$ldl]*$rdl/) {
                foreach my $x (@hold) {
                    chomp($x);
                    $store = $store.' '.$x;
                }
                $store = $store.' '.$_;
                $store =~ s/($ldl[^$ldl$rdl]*$rdl)/ /g;
                print $replog $1."\n\n";
                if ($_ =~ /$ldl[^$rdl]*$/) {
                    @hold = ();
                    push(@hold, $store);
                } else {
                    if ($store !~ /^\s*$/) {
                        print $oup $store;
                    }
                    @hold = ();
                }
                $store = '';
                $limit = 0;
            } elsif ($_ =~ /$ldl/) {
                failed_exit();
                if ($_ =~ /$ldl[^$rdl]*$/) {
                    push(@hold, $_);
                } else {
                    print $oup $_;
                }
            } else {
                if ($_ =~ /^\s+/) {
                    push(@hold, $_);   
                } else {
                    push(@hold, $_);
                    $limit += 1;
                }
            }
        } else {
            failed_exit();
            print $oup $_;
        }
    } else {
        if ($_ =~ /$ldl/) {
            push(@hold, $_);
            $limit += 1;
        } else {
            print $oup $_;
        }
    }
}


sub failed_exit {
    print $errlog ($lintrack - $#hold)."\n";
    print $errlog $hold[0].$_."\n";
    print $oup @hold;
    $limit = 0;
    @hold = ();
}

close $inp;
close $oup;
close $errlog;
close $replog;

