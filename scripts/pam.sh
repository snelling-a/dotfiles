#!/usr/bin/env bash
# enable touch id for sudo commands

pam_file="/etc/pam.d/sudo"
temp="$HOME/etc-pam.d-sudo"
# Real tabs between fields ($'…' so grep/awk match /etc/pam.d/sudo).
permission=$'auth\tsufficient\tpam_tid.so'

grep -q "$permission" "$pam_file" && exit 0

cp "$pam_file" "$temp"

# BSD sed needs `sed -i ''` and multiline `i\`; awk avoids sed portability issues.
awk -v line="$permission" 'NR == 2 { print line } { print }' "$temp" > "${temp}.new" \
  && mv "${temp}.new" "$temp"

sudo mv "$temp" "$pam_file"
