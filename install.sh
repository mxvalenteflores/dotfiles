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

# --- Fix git credential helper path per platform ---
if command -v gh &>/dev/null; then
  gh auth setup-git 2>/dev/null || true
fi

# --- Secrets reminder ---
if ! command -v pass &>/dev/null && [ ! -f "$HOME/.secrets" ]; then
  echo "  No se encontro pass ni ~/.secrets."
  echo "  Crea ~/.secrets con tus API keys:"
  echo "    echo 'export GITHUB_PAT=\"ghp_xxx\"' > ~/.secrets"
  echo "    echo 'export DEEPSEEK_API_KEY=\"sk-xxx\"' >> ~/.secrets"
  echo "    echo 'export GEMINI_API_KEY=\"xxx\"' >> ~/.secrets"
fi

# --- Pass auto-push hook ---
if [ -d "$HOME/.password-store/.git" ]; then
  cat > "$HOME/.password-store/.git/hooks/post-commit" << 'HOOK'
#!/bin/bash
git push origin master 2>/dev/null &
HOOK
  chmod +x "$HOME/.password-store/.git/hooks/post-commit"
fi

echo "Dotfiles instalados. Ejecuta: source ~/.zshrc"
echo ""
echo "Sync manual desde cualquier maquina: ~/dotfiles/sync.sh"
