#!/bin/bash
# Script to install Homebrew taps, casks, formulae, and Go packages

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Installing Homebrew Packages ====="

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is not installed. Please run install-core-tools.sh first."
  exit 1
fi

# Create a file to log failed installations
failed_log="$HOME/.dotfiles/failed_installations.txt"
touch "$failed_log"

# Function to check if a file exists with content
file_exists_with_content() {
  [ -f "$1" ] && [ -s "$1" ]
}

# Add Homebrew taps from config/taps
echo "Adding Homebrew taps..."
if file_exists_with_content "$HOME/.dotfiles/config/taps.txt"; then
  while IFS= read -r line || [ -n "$line" ]; do
    tap=$(echo "$line" | cut -d'#' -f1 | xargs)
    [ -z "$tap" ] && continue
    echo "Tapping: $tap"
    brew tap "$tap" || {
      echo "Failed to tap: $tap"
      echo "tap: $tap" >> "$failed_log"
    }
  done < "$HOME/.dotfiles/config/taps.txt"
else
  echo "No taps file found at $HOME/.dotfiles/config/taps.txt, skipping."
fi

# Install Homebrew casks from config/casks
echo "Installing Homebrew casks..."
if file_exists_with_content "$HOME/.dotfiles/config/casks.txt"; then
  while IFS= read -r line || [ -n "$line" ]; do
    cask=$(echo "$line" | cut -d'#' -f1 | xargs)
    [ -z "$cask" ] && continue
    echo "Installing cask: $cask"
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "$cask" || {
      echo "Failed to install cask: $cask"
      echo "cask: $cask" >> "$failed_log"
    }
  done < "$HOME/.dotfiles/config/casks.txt"
else
  echo "No casks file found at $HOME/.dotfiles/config/casks.txt, skipping."
fi

# Install Homebrew formulae from config/formulae
echo "Installing Homebrew formulae..."
if file_exists_with_content "$HOME/.dotfiles/config/formulae.txt"; then
  while IFS= read -r line || [ -n "$line" ]; do
    formula=$(echo "$line" | cut -d'#' -f1 | xargs)
    [ -z "$formula" ] && continue
    echo "Installing formula: $formula"
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$formula" || {
      echo "Failed to install formula: $formula"
      echo "formula: $formula" >> "$failed_log"
    }
  done < "$HOME/.dotfiles/config/formulae.txt"
else
  echo "No formulae file found at $HOME/.dotfiles/config/formulae.txt, skipping."
fi

# Check if Go is installed before trying to install Go packages
if command -v go &>/dev/null; then
  # Install go projects from config/go_install
  echo "Installing Go packages..."
  if file_exists_with_content "$HOME/.dotfiles/config/go_install.txt"; then
    while IFS= read -r line || [ -n "$line" ]; do
      project=$(echo "$line" | cut -d'#' -f1 | xargs)
      [ -z "$project" ] && continue
      echo "Installing Go package: $project"
      go install -v "$project" || {
        echo "Failed to install Go package: $project"
        echo "go package: $project" >> "$failed_log"
      }
    done < "$HOME/.dotfiles/config/go_install.txt"
  else
    echo "No Go packages file found at $HOME/.dotfiles/config/go_install.txt, skipping."
  fi
else
  echo "Go is not installed, skipping Go packages installation."
fi

echo "Homebrew packages installation complete."
