#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# --- Home dotfiles ---
ln -sf "$DOTFILES/home/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/home/.gitconfig" "$HOME/.gitconfig"

# --- .local/bin/env ---
mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES/home/.local-env" "$HOME/.local/bin/env"

# --- OpenCode config ---
mkdir -p "$HOME/.config/opencode"
ln -sf "$DOTFILES/config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"

# --- Reminder: secrets ---
if [ ! -f "$HOME/.secrets" ]; then
  echo "  Crea ~/.secrets con tus API keys (ver ejemplo abajo)"
  echo "  echo 'export GITHUB_PAT=\"ghp_xxx\"' > ~/.secrets"
fi

echo ""
echo "Dotfiles instalados. Ejecuta: source ~/.zshrc"
