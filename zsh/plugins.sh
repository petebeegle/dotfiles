#!/usr/bin/env bash

set -e

PLUGIN_DIR="${HOME}/.zsh/plugins"
mkdir -p "$PLUGIN_DIR"

install_plugin() {
  local plugin_url=$1
  local plugin_name=$2
  local full_dir="${PLUGIN_DIR}/${plugin_name}"

  if [ -d "$full_dir" ]; then
    echo "${plugin_name} already installed, updating..."
    git -C "$full_dir" pull --quiet
  else
    echo "Installing ${plugin_name}..."
    git clone --quiet "$plugin_url" "$full_dir"
  fi
}

install_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
