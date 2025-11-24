#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: killport <port>"
  exit 1
fi

pid=$(lsof -ti:"$1" 2>/dev/null)

if [ -z "$pid" ]; then
  echo "No process is listening on port $1"
  exit 1
fi

for pid in $pid; do
  kill -9 "$pid" && echo "Successfully killed process $pid"
done
