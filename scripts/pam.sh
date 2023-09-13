#!/usr/bin/env bash
# enable touch id for sudo commands

pam_file="/etc/pam.d/sudo"
temp="$HOME/etc-pam.d-sudo"
permission="auth\tsufficient\tpam_tid.so"

grep -q "$permission" "$pam_file" && exit 0

cp "$pam_file" "$temp"

sed -i "2i $permission" "$temp"

sudo mv "$temp" "$pam_file"
