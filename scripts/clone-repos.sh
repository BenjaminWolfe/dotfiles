#!/bin/bash
# Script to clone GitHub repositories

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Cloning GitHub Repositories ====="

# Function to check if a file exists with content
file_exists_with_content() {
  [ -f "$1" ] && [ -s "$1" ]
}

# Create a Workspace directory if it doesn't exist
workspace_dir="$HOME/Workspace"
if [ ! -d "$workspace_dir" ]; then
  echo "Creating Workspace directory at $workspace_dir"
  mkdir -p "$workspace_dir"
fi

# Create a directory for logs within the Workspace (used by iTerm2)
mkdir -p "$workspace_dir/logs"

# Change to the Workspace directory
cd "$workspace_dir" || exit 1

# Clone repositories from config/repos
if file_exists_with_content "$HOME/.dotfiles/config/repos.txt"; then
  echo "Cloning repositories..."
  failed_repos=()
  
  while IFS= read -r line || [ -n "$line" ]; do
    repo=$(echo "$line" | cut -d'#' -f1 | xargs)
    [ -z "$repo" ] && continue
    
    # Extract repo name from the URL for directory check
    repo_name=$(basename "$repo" .git)
    
    # Check if the repository already exists
    if [ -d "$workspace_dir/$repo_name" ]; then
      echo "Repository $repo_name already exists, skipping."
      continue
    fi
    
    echo "Cloning repository: $repo"
    if git clone "git@github.com:$repo"; then
      echo "Successfully cloned $repo"
    else
      # Try HTTPS if SSH fails
      echo "SSH clone failed, trying HTTPS..."
      if git clone "https://github.com/$repo"; then
        echo "Successfully cloned $repo using HTTPS"
      else
        echo "Failed to clone repository: $repo"
        failed_repos+=("$repo")
      fi
    fi
  done < "$HOME/.dotfiles/config/repos.txt"
  
  # Report failed repositories
  if [ ${#failed_repos[@]} -gt 0 ]; then
    echo "The following repositories failed to clone:"
    printf "  %s\n" "${failed_repos[@]}"
    echo "You may want to try cloning these repositories manually."
  else
    echo "All repositories cloned successfully."
  fi
else
  echo "No repos file found at $HOME/.dotfiles/config/repos.txt, skipping."
fi

echo "GitHub repositories cloning complete."
