#!/bin/bash
# Script to set up DataGrip symlinks

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.
timestamp=$(date +%Y%m%d%H%M%S)

echo "===== Setting Up DataGrip Symlinks ====="

# Find the latest DataGrip version directory
datagrip_dir=$(ls -d "$HOME/Library/Application Support/JetBrains/DataGrip"* 2>/dev/null | sort -V | tail -1)

if [ -z "$datagrip_dir" ]; then
  echo "DataGrip not found, skipping."
  exit 0
fi

echo "Found DataGrip at: $datagrip_dir"

while IFS= read -r source_file; do
  file="${source_file#"$HOME/.dotfiles/datagrip/"}"
  target_file="$datagrip_dir/$file"

  # Ensure the target directory exists
  mkdir -p "$(dirname "$target_file")"

  echo "Processing DataGrip $file..."

  if [ -f "$target_file" ]; then
    if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
      echo "DataGrip $file is already symlinked correctly, skipping."
    else
      echo "Backing up existing DataGrip $file to $target_file.backup.$timestamp"
      mv "$target_file" "$target_file.backup.$timestamp"
      ln -sf "$source_file" "$target_file"
      echo "Created symlink for DataGrip $file"
    fi
  else
    ln -sf "$source_file" "$target_file"
    echo "Created symlink for DataGrip $file"
  fi
done < <(find "$HOME/.dotfiles/datagrip" -type f)

echo "DataGrip symlinks setup complete."
