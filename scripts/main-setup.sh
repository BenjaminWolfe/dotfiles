#!/bin/bash
# Main setup script that calls modular components

# Ensure ~/.dotfiles exists
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "Error: $HOME/.dotfiles directory not found!"
  echo "Please make sure your dotfiles repository is cloned to $HOME/.dotfiles"
  exit 1
fi

echo "Some installations may require sudo access."
echo "Sit tight and enter your credentials; we could not find a reliable way around it."

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

# Menu for selecting which components to run
echo "===== Mac Setup Script ====="
echo "Which components would you like to run?"
echo "1. Install Core Tools (Xcode CLI, Homebrew, Oh My Zsh)"
echo "2. Setup Dotfiles Symlinks"
echo "3. Install Homebrew Packages"
echo "4. Install VS Code Extensions"
echo "5. Clone GitHub Repositories"
echo "6. Configure System Preferences"
echo "7. Setup iTerm2"
echo "8. Run Everything"
echo "q. Quit"

read -r -p "Enter your choice(s) (e.g., '1 2 3' or '8' for all): " choices

# Process the choices
for choice in $choices; do
  case $choice in
  1)
    echo "Installing Core Tools..."
    bash "$HOME/.dotfiles/scripts/install-core-tools.sh"
    ;;
  2)
    echo "Setting up Dotfiles Symlinks..."
    bash "$HOME/.dotfiles/scripts/setup-symlinks.sh"
    ;;
  3)
    echo "Installing Homebrew Packages..."
    bash "$HOME/.dotfiles/scripts/install-packages.sh"
    ;;
  4)
    echo "Installing VS Code Extensions..."
    bash "$HOME/.dotfiles/scripts/install-vscode-extensions.sh"
    ;;
  5)
    echo "Cloning GitHub Repositories..."
    bash "$HOME/.dotfiles/scripts/clone-repos.sh"
    ;;
  6)
    echo "Configuring System Preferences..."
    bash "$HOME/.dotfiles/scripts/configure-preferences.sh"
    ;;
  7)
    echo "Setting up iTerm2..."
    bash "$HOME/.dotfiles/scripts/setup-iterm2.sh"
    ;;
  8)
    echo "Running Everything..."
    bash "$HOME/.dotfiles/scripts/install-core-tools.sh"
    bash "$HOME/.dotfiles/scripts/setup-symlinks.sh"
    bash "$HOME/.dotfiles/scripts/install-packages.sh"
    bash "$HOME/.dotfiles/scripts/install-vscode-extensions.sh"
    bash "$HOME/.dotfiles/scripts/clone-repos.sh"
    bash "$HOME/.dotfiles/scripts/configure-preferences.sh"
    bash "$HOME/.dotfiles/scripts/setup-iterm2.sh"
    ;;
  q)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option: $choice"
    ;;
  esac
done

# If we maintained a failed homebrew installations log, check it
if [ -f "$HOME/.dotfiles/failed_installations.txt" ]; then
  echo "The following homebrew installations failed:"
  cat "$HOME/.dotfiles/failed_installations.txt"
  echo "You may want to try installing these packages manually."
fi

echo "Setup completed!"
