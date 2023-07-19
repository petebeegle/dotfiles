#!/usr/bin/env bash

set -e

if [ -x "$(command -v fish)" ]; then
  ${DOTFILES_LOCATION}/fish/aliases.fish
  ln -sf "${DOTFILES_LOCATION}/fish/config.fish" "${HOME}/.config/fish/config.fish"
fi
