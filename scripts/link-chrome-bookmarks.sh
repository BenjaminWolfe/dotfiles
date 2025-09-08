#!/usr/bin/env bash
set -euo pipefail

ONEDRIVE_NAME="OneDrive - Palomar Holdings Ins"
CHROME_PROFILE="Default"

CHROME_DIR="$HOME/Library/Application Support/Google/Chrome/$CHROME_PROFILE"
ONEDRIVE_DIR="$HOME/$ONEDRIVE_NAME/Chrome/$CHROME_PROFILE"

# 1) Quit Chrome so nothing is locked
osascript -e 'tell application "Google Chrome" to if it is running then quit' || true
sleep 1

# 2) Ensure Chrome profile dir exists
mkdir -p "$CHROME_DIR"

timestamp() { date +"%Y%m%d-%H%M%S"; }

link_one() {
  local name="$1"  # e.g., Bookmarks or Favicons
  local src="$ONEDRIVE_DIR/$name"
  local dst="$CHROME_DIR/$name"

  if [[ ! -e "$src" ]]; then
    echo "WARNING: $src not found. Skipping."
    return
  fi

  # Backup an existing non-symlink or wrong-target symlink
  if [[ -e "$dst" && ! ( -L "$dst" && "$(readlink "$dst")" == "$src" ) ]]; then
    mv "$dst" "$dst.bak.$(timestamp)"
    echo "Backed up existing $dst → $dst.bak.$(timestamp)"
  fi

  # Create/refresh the symlink
  ln -sfn "$src" "$dst"
  echo "Linked $dst → $src"
}

# 3) Link Bookmarks & Favicons (and Favicons-journal if present)
link_one "Bookmarks"
link_one "Favicons"

echo "Done. Launch Chrome when ready."
