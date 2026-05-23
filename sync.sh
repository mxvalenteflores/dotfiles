#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "  → Dotfiles..."
cd "$DOTFILES" && git pull --rebase 2>/dev/null || echo "    (no changes)"

echo "  → Pass store..."
if [ -d "$HOME/.password-store/.git" ]; then
  cd "$HOME/.password-store" && git pull --rebase 2>/dev/null || echo "    (no changes)"
fi

echo "  ✓ Sincronizado. source ~/.zshrc para recargar variables."
