. "$HOME/.local/bin/env"

if command -v pass &>/dev/null; then
  export GITHUB_PAT=$(pass show github/pat 2>/dev/null)
  export DEEPSEEK_API_KEY=$(pass show deepseek/api-key 2>/dev/null)
  export HOSTINGER_API_TOKEN=$(pass show hostinger/api-token 2>/dev/null)

  # GEMINI falls back to .secrets or env
  if ! command -v pass show gemini/api-key &>/dev/null; then
    export GEMINI_API_KEY="AIzaSyC9IuMPd80XBy_PMoF-GrrrAg3aUwKHsn8"
  fi
fi

# Fallback: load from .secrets if pass is not available
if ! command -v pass &>/dev/null && [ -f "$HOME/.secrets" ]; then
  . "$HOME/.secrets"
fi
