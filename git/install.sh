#!/usr/bin/env zsh

set -e

if [ ! -f "${HOME}/.gitconfig.local" ]; then
  cp "${DOTFILES_LOCATION}/git/.gitconfig.local" "${HOME}/.gitconfig.local"

  # zsh why?
  read var\?"Enter your full name: "
  sed -i "s/GITNAME/$var/g" "$HOME/.gitconfig.local"

  # zsh why?
  read var\?"Enter your email address: "
  sed -i "s/GITEMAIL/$var/g" "$HOME/.gitconfig.local"
fi

ln -sf "${DOTFILES_LOCATION}/git/.gitconfig" "${HOME}/.gitconfig"
