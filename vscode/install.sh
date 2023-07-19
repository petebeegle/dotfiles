#!/usr/bin/env zsh

set -e

# don't run script inside dev-containers
if [ -v REMOTE_CONTAINERS ]; then
  exit
fi

if  [ ! -d "${HOME}/.vscode-server/data/Machine" ]; then
  mkdir -p "${HOME}/.vscode-server/data/Machine"
fi

ln -sf "${DOTFILES_LOCATION}/vscode/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"
