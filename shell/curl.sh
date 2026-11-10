#!/usr/bin/env bash

# curl is keg-only, which means it was not symlinked into /usr/local,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.

# For compilers to find curl you may need to set:
export LDFLAGS="-L/${HOMEBREW_PREFIX}/opt/curl/lib"
export CPPFLAGS="-I/${HOMEBREW_PREFIX}/opt/curl/include"

# For pkg-config to find curl you may need to set:
export PKG_CONFIG_PATH="/${HOMEBREW_PREFIX}/opt/curl/lib/pkgconfig"
