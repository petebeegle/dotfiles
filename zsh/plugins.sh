#!/usr/bin/env zsh

set -e

# Function to install or update a plugin from a given URL.
# Arguments:
#   $1 - The URL of the plugin repository.
#   $2 - The directory where the plugin should be installed.
# If the directory already exists, the function will update the plugin by pulling the latest changes.
# If the directory does not exist, the function will clone the plugin repository into the specified directory.
install_plugin() {
  local plugin_url=$1
  local plugin_dir=$2

  local full_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin_dir"

  if [ -d "$full_dir" ]; then
    echo "$(basename $plugin_dir) directory already exists"
    git -C "$full_dir" pull
  else
    git clone "$plugin_url" "$full_dir"
  fi
}

install_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
install_plugin "https://github.com/gradle/gradle-completion" "gradle-completion"
