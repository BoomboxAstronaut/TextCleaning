#!/bin/bash

sync; echo 3 > /proc/sys/vm/drop_caches

sed -E 's/ washington d ?c\b/ W-DC/Ig' rwiki1 |\
sed -E 's/ (the )?united states( of america)?/ U-S/Ig' |\
sed -E 's/\bUSA?\b/U-S/g' |\
sed -E 's/ ((the )?united kingdom|UK)\b/ U-K/Ig' |\
sed -E 's/ ((the )?european union|EU)\b/ E-U/Ig' |\
sed -E 's/ (the )?united nations/ U-N/Ig' |\
sed -E 's/\bUN\b/U-N/g' |\
sed -E 's/ (the )?united arab emirates/ UAE/Ig' |\
sed -E 's/ world war ii/ WWII/Ig' |\
sed -E 's/ world war i/ WWI/Ig' |\
sed -E 's/ new york city/ NYC/Ig' |\
sed -E 's/ new (zealand|york|delhi|jersey|orleans|england|mexico|guinea|hampshire|brunswick)/ New-\1/Ig' |\
sed -E 's/ (Los Angeles|LA)/ L-A/g' |\
sed -E 's/ san fran(cisco)?/ S-F/Ig' |\
sed -E 's/ (hong kong|HK)\b/ H-K/Ig' |\
sed -E 's/ puerto rico/ Puerto-Rico/Ig' |\
sed -E 's/ (ussr|unions? of soviet socialist republics?|soviet (russia|union)|russian federation) / Russia /Ig' |\
sed -E "s/ (prc|people'?s republic of china) / China /Ig" > rwiki2

sync; echo 3 > /proc/sys/vm/drop_caches
