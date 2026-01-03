#!/bin/bash
# Script to install VS Code extensions

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Installing VS Code Extensions ====="

# Check if VS Code is installed
if ! command -v code &>/dev/null; then
  echo "VS Code is not installed or not in PATH. Please install VS Code first."
  exit 1
fi

# Function to check if a file exists with content
file_exists_with_content() {
  [ -f "$1" ] && [ -s "$1" ]
}

# Install VS Code extensions from vscode/extensions
if file_exists_with_content "$HOME/.dotfiles/vscode/extensions.txt"; then
  echo "Installing VS Code extensions..."
  failed_extensions=()
  
  while IFS= read -r line || [ -n "$line" ]; do
    extension=$(echo "$line" | cut -d'#' -f1 | xargs)
    [ -z "$extension" ] && continue
    
    echo "Installing extension: $extension"
    if code --install-extension "$extension" --force; then
      echo "Successfully installed $extension"
    else
      echo "Failed to install extension: $extension"
      failed_extensions+=("$extension")
    fi
  done < "$HOME/.dotfiles/vscode/extensions.txt"
  
  # Report failed extensions
  if [ ${#failed_extensions[@]} -gt 0 ]; then
    echo "The following VS Code extensions failed to install:"
    printf "  %s\n" "${failed_extensions[@]}"
    echo "You may want to try installing these extensions manually."
  else
    echo "All VS Code extensions installed successfully."
  fi
else
  echo "No extensions file found at $HOME/.dotfiles/vscode/extensions.txt, skipping."
fi

echo "VS Code extensions installation complete."
