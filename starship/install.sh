#!/usr/bin/env zsh

set -e

if [ ! -x "$(command -v starship)" ] && [ -z ${REMOTE_CONTAINERS+x}]; then
  echo "🚀 Installing dependency: starship"
  curl -sS https://starship.rs/install.sh | sh
fi

ln -sf "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
