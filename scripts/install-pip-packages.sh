#!/bin/bash
# Script to install Python packages into the global venv (~/.venv)

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Installing Python packages ====="

# Check if Python is available
if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 not found. Please run install-core-tools.sh or install-packages.sh first."
  exit 1
fi

VENV_DIR="$HOME/.venv"

# Create the venv if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating global venv at $VENV_DIR..."
  python3 -m venv "$VENV_DIR"
fi

PIP="$VENV_DIR/bin/pip"

echo "Upgrading pip..."
"$PIP" install --upgrade pip --quiet

# Install packages from config file
if [ ! -f "$HOME/.dotfiles/config/pip-packages.txt" ]; then
  echo "No pip-packages.txt found at $HOME/.dotfiles/config/pip-packages.txt, skipping."
  exit 0
fi

echo "Installing packages..."
while IFS= read -r line || [ -n "$line" ]; do
  pkg=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$pkg" ] && continue
  echo "Installing: $pkg"
  "$PIP" install "$pkg"
done < "$HOME/.dotfiles/config/pip-packages.txt"

echo "Python packages installation complete."
