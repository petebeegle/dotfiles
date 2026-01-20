#!/usr/bin/env zsh

set -e

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "🚀 Installing dependency: oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
