#!/bin/bash
# Script to install radian (an enhanced R console)

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Installing radian for R ====="
echo "===== This can take a moment! ====="

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Please install Homebrew first: https://brew.sh/"
  exit 1
fi

# Check if R is installed
if ! command -v R >/dev/null 2>&1; then
  echo "R is not installed. Installing with Homebrew..."
  brew install r
else
  echo "R found: $(R --version | head -n 1)"
fi

# Ensure Python is installed (via Homebrew)
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python3 not found. Installing with Homebrew..."
  brew install python
else
  echo "Python3 found: $(python3 --version)"
fi

# Ensure pipx is installed (recommended for radian)
if ! command -v pipx >/dev/null 2>&1; then
  echo "pipx not found. Installing with Homebrew..."
  brew install pipx
  # ensure PATH for current shell as well
  pipx ensurepath || true
  export PATH="$HOME/.local/bin:$PATH"
  hash -r 2>/dev/null || true
else
  echo "pipx found: $(pipx --version)"
fi

# Install radian using pipx
# Avoid 'if ! pipeline' (bash3 quirk). Use a variable check instead.
RADIAN_INSTALLED="no"
if pipx list --short 2>/dev/null | awk '{print $1}' | grep -qx radian; then
  RADIAN_INSTALLED="yes"
fi

if [ "$RADIAN_INSTALLED" = "yes" ]; then
  echo "radian is already installed. Upgrading..."
  pipx upgrade radian
else
  echo "Installing radian..."
  pipx install radian
fi

# Verify the radian binary is on PATH
if command -v radian >/dev/null 2>&1; then
  echo "radian installed successfully: $(radian --version 2>/dev/null || echo 'version check ok')"
else
  echo "radian installation failed (binary not found on PATH)."
  echo "Try opening a new terminal, or ensure ~/.local/bin is on PATH."
  exit 1
fi

# Print next steps to test
echo "To test radian manually:"
echo "  1) Open a new terminal and run: radian"
echo "  2) At the R prompt, try: curve(sin, -2*pi, 2*pi, n = 1000, col = 'tomato', lwd = 3); grid()"
echo "  3) Exit with: q()"

echo "===== radian installation complete ====="
