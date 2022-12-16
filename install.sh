#!/usr/bin/env zsh

set -e

DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION

./bin/font install FiraMono

./bin/dotfiles install bash
./bin/dotfiles install starship
./bin/dotfiles install omz
./bin/dotfiles install zsh
./bin/dotfiles install vscode
./bin/dotfiles install git
