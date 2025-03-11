#!/bin/bash
# Main setup script that calls modular components

# Ensure ~/.dotfiles exists
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "Error: $HOME/.dotfiles directory not found!"
  echo "Please make sure your dotfiles repository is cloned to $HOME/.dotfiles"
  exit 1
fi

# Function to check if sudo timestamp is still fresh
check_sudo() {
  sudo -n true 2>/dev/null
  return $?
}

# Function to get sudo credentials upfront
get_sudo_credentials() {
  echo "Some installations may require sudo access."
  echo "Please enter your password to prevent interruptions:"
  sudo -v

  # Keep sudo timestamp fresh in the background
  while true; do
    sleep 60
    check_sudo || break
    sudo -v
  done &
  SUDO_KEEPER_PID=$!

  # Ensure we kill the sudo-keeping process on script exit
  trap 'kill $SUDO_KEEPER_PID' EXIT
}

# Initialize sudo session at the start
get_sudo_credentials

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
