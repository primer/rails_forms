#!/bin/bash

script_folder="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
workspaces_folder="$(cd "${script_folder}/../.." && pwd)"

cd "${workspaces_folder}"
git clone "https://github.com/primer/css" @primer/css

/usr/bin/env ruby .devcontainer/post-create-command.rb
