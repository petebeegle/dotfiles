#!/usr/bin/env zsh

set -e

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "🚀 Installing dependency: oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ln -sf "${DOTFILES_LOCATION}/omz/aliases.zsh" "${HOME}/.oh-my-zsh/custom/aliases.zsh"
ln -sf "${DOTFILES_LOCATION}/omz/exports.zsh" "${HOME}/.oh-my-zsh/custom/exports.zsh"
