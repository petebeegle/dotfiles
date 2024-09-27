#!/usr/bin/env zsh

set -e

ln -sf "${DOTFILES_LOCATION}/zsh/completions.zsh" "${HOME}/completions.zsh"
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_LOCATION}/zsh/.zshenv" "${HOME}/.zshenv"

sh plugins.sh
