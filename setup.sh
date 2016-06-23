#!/usr/bin/env bash

set -o xtrace
set -o errexit

packages=(
    "build-essential"
    "libffi-dev"
    "libssl-dev"
    "virtualenvwrapper"
    "python-dev"
    "vim"
    "git-core"
)
# packages
sudo apt-get install "${packages[@]}"

git_config_items=(
    "color.branch"
    "color.diff"
    "color.grep"
    "color.interactive"
    "color.pager"
    "color.status"
)

for item in "${git_config_items[@]}"; do
  git config --global ${item} true
done
git config --global core.editor /usr/bin/vim

# bashit
! [[ -d "${HOME}/.bash_it" ]] && git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
! [[ -r "${HOME}/.vim/autoload/pathogen.vim" ]] \
&& curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


source "${HOME}/.bashrc"
lsvirtualenv -b | grep -E "ansible-prod" &> /dev/null \
|| mkvirtualenv ansible-prod

pip install -r ./requirements.txt
