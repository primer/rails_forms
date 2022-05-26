#!/bin/bash

script_folder="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
workspaces_folder="$(cd "${script_folder}/../.." && pwd)"

cd "${workspaces_folder}"

echo "##### Cloning @primer/css"
if [[ ! -d "@primer/css" ]]; then
  git clone "https://github.com/primer/css" @primer/css
fi

echo "##### Adding index.scss stub"
echo '@import "./src";' > @primer/css/index.scss
echo 'index.scss' >> @primer/css/.git/info/exclude

cd "${workspaces_folder}/rails_forms"

echo "##### Installing ruby dependencies in rails_forms"
bundle install --jobs 3 --retry 4

echo "##### Installing JavaScript dependencies in rails_forms"
yarn install

cd lookbook

echo "##### Installing ruby dependencies in rails_forms/lookbook"
bundle install --jobs 3 --retry 4

echo "##### Installing JavaScript dependencies in rails_forms/lookbook"
yarn install
