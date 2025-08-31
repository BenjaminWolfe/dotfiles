# --- Homebrew (idempotent) ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- pipx / local Python apps (idempotent) ---
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) : ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

# --- NVM (auto if installed; otherwise no-op) ---
# --- Feel free to delete if not using Node.js ---
# Only load if not already available (idempotent)
if ! command -v nvm >/dev/null 2>&1; then
  : "${NVM_DIR:=$HOME/.nvm}"

  if [ -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR
    . "$NVM_DIR/nvm.sh"

  # Common Homebrew locations (no brew subprocess yet)
  elif [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    export NVM_DIR
    . "/opt/homebrew/opt/nvm/nvm.sh"
  elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    export NVM_DIR
    . "/usr/local/opt/nvm/nvm.sh"

  # Fallback: ask brew where nvm lives
  else
    BREW_NVM_SH="$(brew --prefix nvm 2>/dev/null)/nvm.sh"
    if [ -s "$BREW_NVM_SH" ]; then
      export NVM_DIR
      . "$BREW_NVM_SH"
    fi
  fi
fi

# Optional: bash-style completion (quietly skipped if absent)
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# --- De-duplicate PATH entries after all other changes to PATH ---
typeset -U path PATH
