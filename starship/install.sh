#!/usr/bin/env zsh

set -e

if [ ! -x "$(command -v starship)" ]; then
  echo "🚀 Installing dependency: starship"
  curl -sS https://starship.rs/install.sh | sh -s -- -f
fi

ln -sf "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
