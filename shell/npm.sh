#!/usr/bin/env bash

alias nvm='fnm'

alias nukenode="rm -rf node_modules && rm package-lock.json && npm install"

# Install dependencies globally
alias npmG="npm i -g "

# Install and save to dependencies in your package.json
alias npmS="npm i -S "

# Install and save to dev-dependencies in your package.json
alias npmD="npm i -D "

# Check which npm modules are outdated
alias npmO="npm outdated"

# Update all the packages listed to the latest version
alias npmU="npm update"

# List packages
alias npmL="npm list"

# List top-level installed packages
alias npmL0="npm ls --depth=0"

# Run npm scripts
alias npmR="npm run"

# Run npm info
alias npmI="npm info"
