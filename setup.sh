#!/usr/bin/env bash
#set -o xtrace
#set -o errexit

os_packages=($(cat os-requirements.txt))
# packages
sudo apt-get install "${os_packages[@]}"

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

pathogen_packages=(
    "scrooloose/nerdtree.git"
    "scrooloose/syntastic.git"
)

for repo_suffix in "${pathogen_packages[@]}"; do
    repo="${repo_suffix##*/}"
    repo="${repo%.*}"
    src="https://github.com/${repo_suffix}"
    dst="${HOME}/.vim/bundle/${repo}"
    if [[ -d "${dst}" ]]; then
        continue
    fi
    git clone "${src}" "${dst}"
done

cat > ~/.vimrc << _EOF
execute pathogen#infect()
syntax on
filetype plugin indent on

set tabstop=4 shiftwidth=4 expandtab

map <silent> <F3> :set invnumber<cr>
map <silent> <F4> :NERDTreeToggle<CR>

_EOF


source "${HOME}/.bashrc"

[[ -r requirements.txt ]] || {
    echo "cannot run without requirements.txt present in $PWD";
    exit 1;
}
ve="$( sha1sum requirements.txt | cut -d' ' -f1)"
if ! [[ -d "${WORKON_HOME}/${ve}" ]]; then
    mkvirtualenv "${ve}" -r "./requirements.txt"
fi
workon "${ve}"
echo "Using virtualenv: ${ve}"
