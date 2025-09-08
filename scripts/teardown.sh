#!/bin/bash
# Uninstall script for dotfiles setup

set -e
set -o pipefail

echo "===== Mac Uninstall Script ====="
echo "This script will attempt to uninstall tools and configurations set up by your dotfiles."
echo "Some steps may require manual intervention."

echo "Which components would you like to uninstall?"
echo "1. Uninstall radian for R (via pipx)"
echo "2. Uninstall Homebrew Packages"
echo "3. Uninstall Homebrew"
echo "4. Uninstall Oh My Zsh"
echo "5. Uninstall Xcode CLI Tools"
echo "6. Remove dotfiles symlinks"
echo "7. Uninstall/remove all of the above"
echo "q. Quit"

read -r -p "Enter your choice(s) (e.g., '1 2 3' or '7' for all): " choices

# If 7 is chosen, set $choices to "1 2 3 4 5 6"
if [[ "$choices" == *"7"* ]]; then
  choices="1 2 3 4 5 6"
fi

# Process the choices
for choice in $choices; do
  case $choice in
  1)
    echo "Uninstalling radian for R (via pipx)..."
    if command -v pipx >/dev/null 2>&1; then
      pipx uninstall radian || true
    else
      echo "pipx is not installed or already removed. Skipping radian uninstall."
    fi
    ;;
  2)
    echo "Uninstalling Homebrew Packages..."
    if command -v brew >/dev/null 2>&1; then
      brew list | xargs brew uninstall --force || true
    else
      echo "Homebrew is not installed or already removed. Skipping package uninstall."
    fi
    ;;
  3)
    echo "Uninstalling Homebrew..."
    if command -v brew >/dev/null 2>&1; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    else
      echo "Homebrew is not installed or already removed. Skipping."
    fi
    ;;
  4)
    echo "Uninstalling Oh My Zsh..."
    if [ -d "$HOME/.oh-my-zsh" ]; then
      sh "$HOME/.oh-my-zsh/tools/uninstall.sh" || true
    else
      echo "Oh My Zsh is not installed. Skipping."
    fi
    ;;
  5)
      echo "Uninstalling Xcode Command Line Tools..."
      if xcode-select -p >/dev/null 2>&1; then
        sudo rm -rf /Library/Developer/CommandLineTools
      else
        echo "Xcode CLI tools not found. Skipping."
      fi
      ;;
  6)
    echo "Removing Dotfiles Symlinks (from $HOME, not from repo)..."
    dotfiles=(".zprofile" ".zshrc" ".aliases.zsh" ".p10k.zsh" ".gitconfig" ".gitignore_global" ".jq")
    for file in "${dotfiles[@]}"; do
      if [ -L "$HOME/$file" ]; then
        echo "Removing symlink $HOME/$file"
        rm "$HOME/$file"
      fi
    done
    # VS Code symlinks
    vscode_dotfiles=("settings.json" "keybindings.json")
    vscode_directory="$HOME/Library/Application Support/Code/User"
    for file in "${vscode_dotfiles[@]}"; do
      target_file="$vscode_directory/$file"
      if [ -L "$target_file" ]; then
        echo "Removing symlink $target_file"
        rm "$target_file"
      fi
    done
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

echo "Manual Steps (if applicable):"
echo "- Please manually remove your cloned repositories in ~/Workspace or other locations."
echo "- Revert any system preferences you changed. See manual-customizations.md for details."
echo "Uninstall completed!"
