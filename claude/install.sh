#!/usr/bin/env zsh

set -e

if [ ! -x "$(command -v claude)" ]; then
  echo "🚀 Installing dependency: claude"
  curl -fsSL https://claude.ai/install.sh | bash
fi
