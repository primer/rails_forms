#! /bin/bash

echo "Compiling primer/css..."
pushd /workspaces/@primer/css > /dev/null
yarn dist
popd > /dev/null
echo "done."

mkdir -p /workspaces/rails_forms/lookbook/app/assets/stylesheets/
cp /workspaces/@primer/css/dist/primer.css /workspaces/rails_forms/lookbook/app/assets/stylesheets/
