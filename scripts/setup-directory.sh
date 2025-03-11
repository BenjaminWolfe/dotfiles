#!/bin/bash
# Script to set up the necessary directory structure for dotfiles

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Setting Up Directory Structure ====="

# Create the main dotfiles directory if it doesn't exist
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "Creating $HOME/.dotfiles directory..."
  mkdir -p "$HOME/.dotfiles"
else
  echo "$HOME/.dotfiles directory already exists."
fi

# Create necessary subdirectories
directories=(
  "$HOME/.dotfiles/config"
  "$HOME/.dotfiles/iterm2"
  "$HOME/.dotfiles/iterm2/colors"
  "$HOME/.dotfiles/vscode"
  "$HOME/.dotfiles/scripts"
  "$HOME/.dotfiles/dummy_files"
)

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "Creating $dir..."
    mkdir -p "$dir"
  else
    echo "$dir already exists."
  fi
done

# Copy all the script files to the scripts directory
echo "Copying script files to scripts directory..."
cp "main-setup.sh" "$HOME/.dotfiles/scripts/"
cp "install-core-tools.sh" "$HOME/.dotfiles/scripts/"
cp "setup-symlinks.sh" "$HOME/.dotfiles/scripts/"
cp "install-packages.sh" "$HOME/.dotfiles/scripts/"
cp "install-vscode-extensions.sh" "$HOME/.dotfiles/scripts/"
cp "clone-repos.sh" "$HOME/.dotfiles/scripts/"
cp "configure-preferences.sh" "$HOME/.dotfiles/scripts/"
cp "setup-iterm2.sh" "$HOME/.dotfiles/scripts/"

# Make all scripts executable
echo "Making scripts executable..."
chmod +x "$HOME/.dotfiles/scripts/"*.sh

# Create empty config files if they don't exist
config_files=(
  "taps.txt"
  "casks.txt"
  "formulae.txt"
  "go_install.txt"
  "repos.txt"
)

for file in "${config_files[@]}"; do
  if [ ! -f "$HOME/.dotfiles/config/$file" ]; then
    echo "Creating empty $file..."
    touch "$HOME/.dotfiles/config/$file"
  else
    echo "$HOME/.dotfiles/config/$file already exists."
  fi
done

# Create empty VS Code files if they don't exist
vscode_files=(
  "extensions.txt"
  "settings.json"
  "keybindings.json"
)

for file in "${vscode_files[@]}"; do
  if [ ! -f "$HOME/.dotfiles/vscode/$file" ]; then
    echo "Creating empty $file..."
    touch "$HOME/.dotfiles/vscode/$file"
  else
    echo "$HOME/.dotfiles/vscode/$file already exists."
  fi
done

echo "Directory structure setup complete."
