#!/bin/bash

set -e

echo "***** Install tools *****"
sudo apt install awscli htop tmux silversearcher-ag ipython3 curl xclip

echo ""
echo ""

echo "***** Install development tools *****"
sudo apt install build-essential gcc g++ autoconf libtool cmake git git-lfs universal-ctags ninja-build gettext flex bison shellcheck

echo ""
echo ""

echo "***** Install neovim *****"
mkdir -p ~/code/
pushd ~/code
git clone -b stable https://github.com/neovim/neovim
make CMAKE_BUILD_TYPE=Release && sudo make install && sudo ldconfig
popd

echo ""
echo ""

echo "***** Configure neovim *****"
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share
cp -R ./config/nvim/*.vim ~/.config/nvim/
# Download and install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#cp ./nvim_helpers/nview ~/.local/bin/nview
#cp ./nvim_helpers/nvimdiff ~/.local/bin/nvimdiff
echo "Remember to run `:PlugInstall` on your first use of neovim."

echo ""
echo ""

echo "***** Configure neovim *****"
mkdir -p ~/.local/share/tmux
cp ./local/share/tmux/bash_completion ~/.local/share/tmux/bash_completion

echo ""
echo ""

echo "***** Configure git *****"
cp ./gitconfig ~/.gitconfig
echo "Update init.email in .gitconfig!"
echo "Update init.signingkey in .gitconfig!"
echo "List keys: gpg --list-secret-keys --keyid-format=long"
echo "Create a new gpg key if necessary"

echo ""
echo ""

echo "***** Configure .bashrc *****"
echo "Compare default .bashrc with this repo version and move over relevant lines"
echo "Command: vimdiff ./bashrc ~/.bashrc"

echo "***** Reminders *****"
echo "Generate an SSH key with a passcode: ssh-key-gen -t ed25519"
echo "Generate a GPG key for signing git commits"
