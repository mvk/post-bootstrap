#!/usr/bin/env bash

set -o xtrace

items=(
    "branch"
    "diff"
    "grep"
    "interactive"
    "pager"
    "status"
)

for item in "${items[@]}"; do
  git config --global color.${item} true
done


git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

sudo apt-get install build-essential libffi-dev libssl-dev
