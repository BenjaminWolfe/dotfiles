#!/bin/bash
# Script to set up iTerm2

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Setting Up iTerm2 ====="

# Check if iTerm2 is installed
if ! [ -d "/Applications/iTerm.app" ] && ! [ -d "$HOME/Applications/iTerm.app" ]; then
  echo "iTerm2 is not installed. Would you like to install it now? (y/n)"
  read -r install_iterm
  if [[ $install_iterm =~ ^[Yy]$ ]]; then
    if command -v brew &>/dev/null; then
      brew install --cask iterm2
    else
      echo "Homebrew is not installed. Please install iTerm2 manually."
      exit 1
    fi
  else
    echo "Skipping iTerm2 setup."
    exit 0
  fi
fi

# Create colors directory if it doesn't exist
mkdir -p "$HOME/.dotfiles/iterm2/colors"

# Ensure zsh is the current shell before installing iTerm2 shell integration
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Current shell is not zsh. Would you like to change it? (y/n)"
  read -r change_shell
  if [[ $change_shell =~ ^[Yy]$ ]]; then
    chsh -s /bin/zsh
    export SHELL=/bin/zsh
  fi
fi

# Install iTerm2 shell integration
echo "Installing iTerm2 shell integration..."
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

# Set iTerm2 to load preferences from the dotfiles directory
echo "Setting iTerm2 preferences location..."
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Download & import iTerm's Atom color scheme
echo "Downloading Atom color scheme for iTerm2..."
curl -o "$HOME/.dotfiles/iterm2/colors/Atom.itermcolors" https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Atom.itermcolors

# Ask if user wants to open the color scheme
read -r -p "Do you want to open the Atom color scheme in iTerm2? (y/n) (Note, if you say yes and then it says you already have Atom, it's OK to skip): " open_colors
if [[ $open_colors =~ ^[Yy]$ ]]; then
  open "$HOME/.dotfiles/iterm2/colors/Atom.itermcolors"
fi

echo "iTerm2 setup complete."
