#!/usr/bin/env bash

set -e

ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_LOCATION}/zsh/.zshenv" "${HOME}/.zshenv"

# Install zsh plugins (optional - .zshrc handles missing gracefully)
bash "${DOTFILES_LOCATION}/zsh/plugins.sh"
