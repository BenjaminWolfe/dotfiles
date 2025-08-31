#!/bin/bash
# Script to set up symlinks for dotfiles

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.
timestamp=$(date +%Y%m%d%H%M%S)

echo "===== Setting Up Dotfiles Symlinks ====="

# Define the list of dotfiles and their linked locations
dotfiles=(".zprofile" ".zshrc" ".aliases.zsh" ".p10k.zsh" ".gitconfig" ".gitignore_global" ".jq")
vscode_dotfiles=("settings.json" "keybindings.json")
vscode_directory="$HOME/Library/Application Support/Code/User"

# Ensure necessary directories exist
mkdir -p "$vscode_directory"
mkdir -p "$HOME/.dotfiles/iterm2/colors"

# Backup existing configuration files if they exist and create symlinks
for file in "${dotfiles[@]}"; do
  echo "Processing $file..."
  if [ -f "$HOME/$file" ]; then
    if [ -L "$HOME/$file" ] && [ "$(readlink "$HOME/$file")" = "$HOME/.dotfiles/$file" ]; then
      echo "$file is already symlinked correctly, skipping."
    else
      echo "Backing up existing $file to $HOME/$file.backup"
    echo "Backing up existing $file to $HOME/$file.backup.$timestamp"
    mv "$HOME/$file" "$HOME/$file.backup.$timestamp"
      ln -sf "$HOME/.dotfiles/$file" "$HOME/$file"
      echo "Created symlink for $file"
    fi
  else
    ln -sf "$HOME/.dotfiles/$file" "$HOME/$file"
    echo "Created symlink for $file"
  fi
done

for file in "${vscode_dotfiles[@]}"; do
  echo "Processing VS Code $file..."
  source_file="$HOME/.dotfiles/vscode/$file"
  target_file="$vscode_directory/$file"
  
  if [ -f "$target_file" ]; then
    if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
      echo "VS Code $file is already symlinked correctly, skipping."
    else
      echo "Backing up existing VS Code $file to $target_file.backup"
    echo "Backing up existing VS Code $file to $target_file.backup.$timestamp"
    mv "$target_file" "$target_file.backup.$timestamp"
      ln -sf "$source_file" "$target_file"
      echo "Created symlink for VS Code $file"
    fi
  else
    ln -sf "$source_file" "$target_file"
    echo "Created symlink for VS Code $file"
  fi
done

echo "Dotfiles symlinks setup complete."
