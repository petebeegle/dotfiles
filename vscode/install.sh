#!/usr/bin/env zsh

set -e

ln -sf "${DOTFILES_LOCATION}/vscode/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"

CODE_EXTENSIONS=(
  Tyriar.theme-sapphire
  esbenp.prettier-vscode
  foxundermoon.shell-format
  eamodio.gitlens
)
for ext in "${CODE_EXTENSIONS[@]}"; do printf "  🚀 Installing extension: %s" "${ext}" && code --install-extension "${ext}" --force; done
