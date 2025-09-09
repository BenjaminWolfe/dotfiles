#!/usr/bin/env bash
set -euo pipefail

# Azure Data Studio settings.json symlink
ONEDRIVE_NAME="OneDrive - Palomar Holdings Ins"
ADS_USER_DIR="$HOME/Library/Application Support/azuredatastudio/User"

SRC_FILE="$ADS_USER_DIR/settings.json"
TARGET_FILE="$HOME/$ONEDRIVE_NAME/Azure Data Studio/User/settings.json"

# Back up existing file if present and not already a symlink
if [ -f "$SRC_FILE" ] && [ ! -L "$SRC_FILE" ]; then
  echo "Backing up existing ADS settings.json..."
  mv "$SRC_FILE" "$SRC_FILE.bak.$(date +%Y%m%d%H%M%S)"
fi

# Ensure the target directory exists
mkdir -p "$(dirname "$TARGET_FILE")"

# Create the symlink if it doesn't already exist
if [ ! -L "$SRC_FILE" ]; then
  echo "Creating symlink for ADS settings.json..."
  ln -s "$TARGET_FILE" "$SRC_FILE"
else
  echo "Symlink already exists: $SRC_FILE -> $(readlink "$SRC_FILE")"
fi
