#!/usr/bin/env bash

git_config=${1:-$XDG_CONFIG_HOME/git/config}

sed -E 's/\s\s+/\t/g' <"$git_config" |
  awk -F '\t' '$1 { current = $1; print current } $2 { print current "\t" $2}' |
  sort |
  awk -F '\t' '!$2 {print "\n"$1} $1 && $2 { print "\t" $2 }' |
  sed '1d' >output

mv output "$git_config"
