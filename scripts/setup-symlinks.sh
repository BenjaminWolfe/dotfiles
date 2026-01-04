#!/bin/bash
# Script to set up symlinks for dotfiles

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Setting Up Dotfiles Symlinks ====="

# Define the list of dotfiles and their linked locations
dotfiles=(".zshrc" ".p10k.zsh" ".gitconfig" ".gitignore_global" ".jq")
vscode_dotfiles=("settings.json" "keybindings.json")
vscode_directory="$HOME/Library/Application Support/Code/User"
claude_directory="$HOME/Library/Application Support/Claude"

# Ensure necessary directories exist
mkdir -p "$vscode_directory"
mkdir -p "$HOME/.dotfiles/iterm2/colors"
mkdir -p "$claude_directory"

# Backup existing configuration files if they exist and create symlinks
for file in "${dotfiles[@]}"; do
  echo "Processing $file..."
  if [ -f "$HOME/$file" ]; then
    if [ -L "$HOME/$file" ] && [ "$(readlink "$HOME/$file")" = "$HOME/.dotfiles/$file" ]; then
      echo "$file is already symlinked correctly, skipping."
    else
      echo "Backing up existing $file to $HOME/$file.backup"
      mv "$HOME/$file" "$HOME/$file.backup"
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
      mv "$target_file" "$target_file.backup"
      ln -sf "$source_file" "$target_file"
      echo "Created symlink for VS Code $file"
    fi
  else
    ln -sf "$source_file" "$target_file"
    echo "Created symlink for VS Code $file"
  fi
done

echo "Configuring Claude for MCP Obsidian (https://github.com/MarkusPfundstein/mcp-obsidian) and REST API plugin..."
claude_config_file="$claude_directory/claude_desktop_config.json"
claude_template="$HOME/.dotfiles/claude/claude_desktop_config.json.template"

if [ ! -f "$claude_template" ]; then
  echo "ERROR: Claude template not found at $claude_template. This file should exist in your dotfiles repo." >&2
  exit 1
fi

if [ -L "$claude_config_file" ]; then
  target="$(readlink "$claude_config_file")"
  if [ "$target" = "$claude_template" ]; then
    echo "Claude config is already a symlink to the template ($target). Leaving as-is."
  else
    echo "Claude config is a symlink to $target. Leaving the symlink in place. Remove it if you want to replace it with a copied template."
  fi
else
  if [ -e "$claude_config_file" ]; then
    echo "Found existing Claude config at $claude_config_file (not a symlink). Backing up to $claude_config_file.backup"
    mv "$claude_config_file" "$claude_config_file.backup"
  else
    echo "No existing Claude config found. Creating one from template..."
  fi

  cp -f "$claude_template" "$claude_config_file"
  echo "Created Claude configuration at $claude_config_file from template $claude_template."
fi

echo "Dotfiles symlinks setup complete."
