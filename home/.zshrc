. "$HOME/.local/bin/env"

if command -v pass &>/dev/null; then
  export GITHUB_PAT=$(pass show github/pat 2>/dev/null)
  export DEEPSEEK_API_KEY=$(pass deepseek/api-key 2>/dev/null)
elif [ -f "$HOME/.secrets" ]; then
  . "$HOME/.secrets"
fi
