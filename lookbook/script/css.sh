#! /bin/bash

if [[ $1 == "--watch" ]]; then
  node_modules/.bin/chokidar "/workspaces/@primer/css/src/**/*.scss" -c ./script/css-compile.sh --initial
else
  ./css-compile.sh
fi
