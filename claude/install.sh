#!/usr/bin/env zsh

set -e

if [ ! -x "$(command -v claude)" ]; then
  echo "🚀 Installing dependency: claude"
  curl -fsSL https://claude.ai/install.sh | bash
fi

mkdir -p "${HOME}/.claude/commands"
mkdir -p "${HOME}/.claude/hooks"

ln -sf "${DOTFILES_LOCATION}/claude/.claude/settings.json" "${HOME}/.claude/settings.json"
ln -sf "${DOTFILES_LOCATION}/claude/.claude/commands/statusline-command.sh" "${HOME}/.claude/commands/statusline-command.sh"
ln -sf "${DOTFILES_LOCATION}/claude/.claude/hooks/compact-checkpoint.sh" "${HOME}/.claude/hooks/compact-checkpoint.sh"
