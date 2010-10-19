#!/bin/bash

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

mkdir -p "$bin"/../listings/sh/input

for f in "$bin"/../src/main/sh/*.sh; do
  out=$f.output.txt
  cat $f \
      | sed -e 's|^\(:.*\)|\1|' \
            -e 's|^\([^:].*\)|<prompt>% </prompt><userinput>\1</userinput>|' \
      > $out
  cat $out
  python "$bin"/phragmite_sh.py $out "$bin"/../listings/sh/input
done

for f in "$bin"/../src/main/sh/*.sh; do
  out=$f.output.txt
  bash -x < $f 2>&1 \
      | sed -e 's|&|\&amp;|g' \
            -e 's|"|\&quot;|g' \
            -e 's|>|\&gt;|g' \
            -e 's|<|\&lt;|g' \
            -e 's|^\(\+ \)\(:.*\)|\2|' \
            -e 's|^\(\+ \)\(.*\)|<prompt>% </prompt><userinput>\2</userinput>|' \
      > $out
  cat $out
  python "$bin"/phragmite_sh.py $out "$bin"/../listings/sh
  rm $out
done

