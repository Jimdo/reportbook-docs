#!/bin/bash -xe

cd /src
pip install -r requirements.txt

if [[ "$1" == "preview" ]]; then
  mkdocs serve -a '0.0.0.0:3000' --livereload
else
  mkdocs build --clean
fi