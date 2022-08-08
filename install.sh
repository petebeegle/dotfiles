#!/usr/bin/env zsh

set -e

DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION;

./bin/dotfiles install zsh
./bin/dotfiles install starship
./bin/dotfiles install vscode
./bin/dotfiles install git
