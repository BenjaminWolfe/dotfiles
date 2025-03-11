#!/bin/bash
# Script to configure macOS system preferences

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Configuring System Preferences ====="

# Hide the Dock automatically and set a delay for showing the Dock
echo "Configuring Dock preferences..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 5

# Restart Dock to apply changes
echo "Restarting Dock to apply changes..."
killall Dock

# Create dummy files for setting default application associations
echo "Creating dummy files for default application setup..."
mkdir -p "$HOME/.dotfiles/dummy_files"

if [ ! -f "$HOME/.dotfiles/dummy_files/dummy.csv" ]; then
  touch "$HOME/.dotfiles/dummy_files/dummy.csv"
fi

# Ask if user wants to open the dummy files in Finder
read -r -p "Do you want to open the dummy files in Finder to set default applications? (y/n): " open_finder
if [[ $open_finder =~ ^[Yy]$ ]]; then
  open "$HOME/.dotfiles/dummy_files"
fi

# Add more macOS preferences here
# Example: Enable key repeat for VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Example: Set fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Example: Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Example: Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Example: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "System preferences configuration complete."
