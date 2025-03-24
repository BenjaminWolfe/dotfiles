#!/bin/bash
# Script to install core tools: Xcode CLI, Homebrew, Oh My Zsh

set -e          # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Exit if any part of a pipeline fails.

echo "===== Installing Core Tools ====="

# Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "Xcode CLI tools not found. Installing..."
  xcode-select --install
  echo "Please complete the Xcode CLI tools installation before continuing."
  echo "Press any key when the installation is complete..."
  read -r -n 1
else
  echo "Xcode CLI tools already installed."
fi

# Install Homebrew
echo "Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH if needed
  if [[ $(uname -m) == 'arm64' ]]; then
    echo "Adding Homebrew to PATH for Apple Silicon Mac..."
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Adding Homebrew to PATH for Intel Mac..."
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed."
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh not found. Installing..."
  # Clone directly rather than using the installer script to avoid terminal exit
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
  
  # Install Powerlevel10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
  echo "Oh My Zsh already installed."
  if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  else
    echo "Powerlevel10k theme already installed."
  fi
fi

# NVM and Node blocked by ThreatLocker (IT) and not currently needed at work
# so skipped here

echo "Core tools installation complete."
