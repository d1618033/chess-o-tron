#!/bin/bash -xe

url=https://database.lichess.org/standard/lichess_db_standard_rated_2024-04.pgn.zst
wget -O pgns $url 

cat pgns | zstdgrep -e '\[Site |\[%eval ' | egrep -a -B1 '\[%eval ' | sed 's/ {[^}]*}//g' | sed 's/?!//g' | sed 's/ [^ ]*\.\.\.//g' | grep -v '\-\-' | sed ':begin;$!N;/\]\n/s/\n/ /;tbegin;P;D' | grep -o '\[Site[^?]*??' > blunderlines

# uniq lines ignoring urls

cat blunderlines | sort -t']' -k2 -u | wc -l

grep '1. d4 d5 2. c4 e6' blunderlines | sort -t']' -k2 -u | sed 's/\[Site/{ url:/' | sed 's/\] /, moves: "/' | sed 's/??/??" },/' > html/js/qgd.js


