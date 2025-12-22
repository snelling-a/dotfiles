#!/usr/bin/env bash

for f in $(comm -23 <(brew list --formula | sort) <(brew bundle list --formula | sort)); do
  if [ -z "$(brew uses --installed "$f")" ]; then
    echo "Uninstalling $f"
    brew uninstall "$f"
  else
    echo "Keeping $f (required by $(brew uses --installed "$f" | wc -l) packages)"
  fi
done
