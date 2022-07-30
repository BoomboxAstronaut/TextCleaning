#!/usr/bin/perl
#
use utf8;
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';

open (my $inp, "<:utf8", $ARGV[0]) or die $!;
open (my $oup, ">", $ARGV[1]) or die $!;

while (<$inp>) {
    $_ =~ s/(?<= )((c|sh|w)ould|(sh|h|w)e|it?|th(at|e(re|y))|you|wh(at|o|y|e(n|re)))\x27\S+(?= )//ig;
    $_ =~ s/(?<= )(a(bo(ut|ve)|fter|gain|in'?t|l(l|so|though)|n(d|other'?s?|y)?|re(n'?t)?|[st])?|b(e(cause|en|fore|ing|tween)?|oth|ut|y)|c(a(me|n'?t?)|o(me|uld(n'?t|ve)?))|d(e|id(n'?t)?|o(es(n'?t)?|ing|n'?t|wn)?|u(e|ring))|e(ach|ig(th|ht)|l(se)?|very((body|one)'?s?)?)|f(ew|i(fth|rst|ve)|o(r|ur(th)?)|rom)|h(a(d(n'?t)?|s(n'?t)?|v(e(n'?t)?|ing))|e([ds]|rs?(elf)?|re('?s)?)?|i(m(self)?|s)|ow(ever|'?s)?)|i((m|ve)|[fm]|n(cluding|to)?|s(n'?t)?|t(d|ll|s(elf)?)?|ve)?|known|l(a(ter)?|e(ast|ss|t'?s?)?)|m(a(de|ny|y)|e|o(re|st)|y(self)?)|n(ew|in(e|th)|o(ne?|[rtw])?))(?= )//ig;
    $_ =~ s/(?<= )(o(ff?|n(ce|e'?s?|ly)?|r|ther|u(r'?s?(elves)?|t)|ver)|p(art|er)|quite|s(ame|chool|e(cond|v(en(th)?|eral))|hes?|hould(ve|n'?t)?|i(nce|x(th)?)|lightly|o(me(body|one|thing)?'?s?)?|till|uch)|t(en(th)?|h(a(n|t(d|ll|s)?)|e(irs?|m(sel(f|ves))?|n|re(s|ll)?|se|y(d|ll|re|ve)?)?|i(ngs?|rd|s)|o(se|ugh)|r(ee|ough)|us)|ime|oo?|w(ice|o)|ype)|u(n(der|less|til)|p(on)?|s(ed?)?)|very|w(as(n'?t)?|e(re(n'?t)?|ll|ve)?|h(at(d|ll|s)?|e(ns?|res?)|ich|ile|o(d|ll|se?|ve)?|ys?)|i(ll|th(in)?)|o(n'?t|uld(ve|n'?t)?))|y(ears?|ou(d|ll|s|ve|r(e|s(elf|elves)?)?)?))(?= )//ig;
    $_ =~ s/'[ds](?= )//g;
    $_ =~ s/(?<= )[XCLIV]+(?= )//g;
    $_ =~ s/(?<= )\S(?= )//g;
    print $oup $_;
}
