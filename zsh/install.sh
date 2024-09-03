#!/usr/bin/env zsh

set -e

# Install autosuggestions
autosuggestions_dir="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
if [ -d "$autosuggestions_dir" ]; then
    echo "zsh-autosuggestions directory already exists"
    git -C "$autosuggestions_dir" pull
else
    git clone https://github.com/zsh-users/zsh-autosuggestions $autosuggestions_dir
fi

ln -sf "${DOTFILES_LOCATION}/zsh/completions.zsh" "${HOME}/completions.zsh"
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_LOCATION}/zsh/.zshenv" "${HOME}/.zshenv"
