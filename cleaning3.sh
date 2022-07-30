#!/bin/bash

sync; echo 3 > /proc/sys/vm/drop_caches

sed -E 's/ wells / -well- /Ig' rwiki2 |\
sed -E 's/ (tin|aluminum|drink|beverage|a) can / \1 -can- /Ig' |\
sed -E 's/ (flow|passage|amount|perception|unit) of time / \1 of -time- /Ig' |\
sed -E 's/ time (dilation|travel|perception|standard|measurement|keep(ing|er)|management) / -time- \1 /Ig' |\
sed -E 's/ (measure|space|keep|take|waste|save) time / \1 -time- /Ig' |\
sed -E 's/ (a|last|free) will / \1 -will- /Ig' |\
sed -E 's/ will (power|to) / -will- \1 /Ig' |\
sed -E 's/ (first|second|third) place / -\1- place /Ig' |\
sed -E 's/ finished (first|second|third) / finished -\1- /Ig' |\
sed -E 's/ type (system|theory|design(ers)?|face|specimens?|fonts) / -type- \1 /Ig' |\
sed -E 's/ (data|display|movable) type / \1 -type- /Ig' |\
sed -E 's/ (replacement|spare|mechanical|mov(ing|able)) part / \1 -part- /g' |\
sed -E 's/ (calendar|new|tropical|julian|astronomical|seasonal) year / \1 -year- /g' |\
sed -E 's/ (all|brand|fresh|completely) new / \1 -new- /Ig' |\
sed -E 's/ (primary|elementary|middle|secondary|high|public|law|business|medical) school / \1 -school- /Ig' |\
sed -E 's/( (vertical(ly)?|elevat(ed|ion)|orient(ation|ed|ing)|located) .+) (up|down|over|under) (.+ (above|higher|below|lower|overhead|underneath|upward|downward|gain|loss) )/\1 -\6- \7/Ig' |\
sed -E 's/( (above|higher|below|lower|overhead|underneath|upward|downward|gain|loss) .+) (up|down|over|under) (.+ (vertical(ly)?|elevat(ed|ion)|orient(ation|ed|ing)|located) )/\1 -\3- \4/Ig' |\
sed -E 's/( (e(xit|nter)(ing|ed)?|box|contain(er|ing|s)|leav(e|ing)) .+) (in|out) (.+ (in(terior|side of|ward)|exterior|out(side of|ward)) )/\1 -\7- \8/Ig' |\
sed -E 's/( (in(terior|side of|ward)|exterior|out(side of|ward)) .+) (in|out) (.+ (e(xit|nter)(ing|ed)?|box|contain(er|ing|s)|leav(e|ing)) )/\1 -\5- \6/Ig' |\
sed -E 's/University of (\S+)/University-of-\1/Ig' > rwiki3

sync; echo 3 > /proc/sys/vm/drop_caches
