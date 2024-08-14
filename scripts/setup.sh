#!/bin/bash

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

# Install Xcode Command Line Tools
xcode-select --install

# Define the list of dotfiles and their linked locations
dotfiles=(".zshrc" ".p10k.zsh" ".gitconfig" ".gitignore_global" ".jq")
vscode_dotfiles=("settings.json" "keybindings.json")
vscode_directory="$HOME/Library/Application Support/Code/User"

# Ensure necessary directories exist
mkdir -p "$vscode_directory"
mkdir -p "$HOME/.dotfiles/iterm2/colors"

# Backup existing configuration files if they exist and create symlinks
for file in "${dotfiles[@]}"; do
  if [ -f "$HOME/$file" ]; then
    mv "$HOME/$file" "$HOME/$file.backup"
  fi
  ln -sf "$HOME/.dotfiles/$file" "$HOME/$file"
done

for file in "${vscode_dotfiles[@]}"; do
  source_file="$HOME/.dotfiles/vscode/$file"
  target_file="$vscode_directory/$file"
  if [ -f "$target_file" ]; then
    mv "$target_file" "$target_file.backup"
  fi
  ln -sf "$source_file" "$target_file"
done

# Install Oh My Zsh with the Powerlevel10k theme
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install Homebrew (before sourcing .zshrc)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install nvm and load it into the current shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"

# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Then use nvm to install the latest LTS version of Node.js
nvm install --lts

# Add Homebrew taps from config/taps, skipping blanks and comments
while IFS= read -r line || [ -n "$line" ]; do
  tap=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$tap" ] && continue
  brew tap "$tap"
done <~/.dotfiles/config/taps.txt

# Install Homebrew casks from config/casks, skipping blanks and comments
while IFS= read -r line || [ -n "$line" ]; do
  cask=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$cask" ] && continue
  brew install --cask "$cask"
done <~/.dotfiles/config/casks.txt

# Install Homebrew formulae from config/formulae, skipping blanks and comments
while IFS= read -r line || [ -n "$line" ]; do
  formula=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$formula" ] && continue
  brew install "$formula"
done <~/.dotfiles/config/formulae.txt

# Install go projects config/go_install, skipping blanks and comments
while IFS= read -r line || [ -n "$line" ]; do
  project=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$project" ] && continue
  go install -v "$project"
done <~/.dotfiles/config/go_install.txt

# Install VS Code extensions from vscode/extensions, skipping blanks and comments
# TODO: Look into whether it's OK to run VS Code programatically before opening
while IFS= read -r line || [ -n "$line" ]; do
  extension=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$extension" ] && continue
  code --install-extension "$extension"
done <~/.dotfiles/vscode/extensions.txt

# Create a Workspace directory and clone repos from config/repos, skipping blanks and comments
mkdir -p ~/Workspace && cd ~/Workspace || exit 1
while IFS= read -r line || [ -n "$line" ]; do
  repo=$(echo "$line" | cut -d'#' -f1 | xargs)
  [ -z "$repo" ] && continue
  git clone git@github.com:"$repo"
done <~/.dotfiles/config/repos.txt

# Create a directory for logs within the Workspace (used by iTerm2)
mkdir -p ~/Workspace/logs

# Ensure zsh is the current shell before installing iTerm2 shell integration
if [ "$SHELL" != "/bin/zsh" ]; then
  chsh -s /bin/zsh
  export SHELL=/bin/zsh
fi

# Install iTerm2 shell integration
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

# Set iTerm2 to load preferences from the dotfiles directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# TODO: Consider adding GitHub Copilot integration to iTerm2 & VS Code terminal

# Source the custom .zshrc to apply configurations
# shellcheck disable=SC1090
source ~/.zshrc

# Hide the Dock automatically and set a delay for showing the Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 5
killall Dock

# Dummy files: Use these to set the default applications for certain file types
mkdir -p ~/.dotfiles/dummy_files
touch ~/.dotfiles/dummy_files/dummy.csv

# Open in Finder to make this easy to set up
open ~/.dotfiles/dummy_files

# Download & import iTerm's Atom color scheme (no sense keeping it in the repo)
# Do this last since it opens iTerm and may require user interaction
curl -o ~/.dotfiles/iterm2/colors/Atom.itermcolors https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Atom.itermcolors
open "$HOME/.dotfiles/iterm2/colors/Atom.itermcolors"
