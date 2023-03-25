#!/usr/bin/env bash

yq 'sort_keys(..)' "$1" >temp

mv temp "$1"
