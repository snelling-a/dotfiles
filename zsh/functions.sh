#!/usr/bin/env

function print_path (){
    tr : '\n' <<<"$PATH" | sort
}

# pull gitignore template
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/ "$@" ;}
