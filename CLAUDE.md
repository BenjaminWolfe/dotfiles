# CLAUDE.md

## Project Overview

This is a macOS dotfiles repository for automating development environment setup on a new Mac. The `palomar` branch is the work-specific version (Palomar Holdings). The goal is that setting up a new laptop requires only copy-pasting from `prerequisites.md`, then running one script.

## Repository Structure

```
.dotfiles/
├── config/         # Package lists (casks.txt, formulae.txt, repos.txt, taps.txt)
├── scripts/        # Setup scripts (main-setup.sh orchestrates everything)
├── vscode/         # VS Code settings, keybindings, extensions, workspace file
├── iterm2/         # iTerm2 config
├── tools/          # Custom shell scripts (e.g., bwstrip)
├── how_to/         # Reference docs (jq_and_mlr.md)
├── .zshrc          # Zsh config (symlinked to ~/)
├── .zprofile       # PATH setup (symlinked to ~/)
├── .aliases.zsh    # Shell aliases (symlinked to ~/)
├── .p10k.zsh       # Powerlevel10k theme config
├── .gitconfig      # Git identity (name/email must be updated per-user)
└── .gitignore_global
```

Key docs: `README.md`, `prerequisites.md`, `manual-customizations.md`, `snowflake.md`, `swagger.md`

## Conventions

**Commit style:** `<gitmoji> <scope>: <description>`, where scope is either `work` (palomar-specific, not intended for `main`) or `global` (intended to eventually be merged into `main`). Examples:
- `:memo: work: Outlook toolbar customizations`
- `:sparkles: global: add R connections to Snowflake + SQL Server`

**Shell scripts:** All scripts are bash (`#!/bin/bash`). They live in `scripts/` and are called by `main-setup.sh`. Each script does one thing (install packages, setup symlinks, etc.).

**Config lists:** `config/*.txt` files are plain-text lists with `#` comments for grouping. Keep them organized by category with comment headers.

**Branch:** `palomar` is the work branch. `main` is the generic/personal branch. Work-specific things (OneDrive paths, Palomar repos, work apps) belong only in `palomar`.

## Key Facts

- Scripts use `set -e` and `set -o pipefail` — failures abort immediately
- `setup-symlinks.sh` creates symlinks from `~/` to the dotfiles (`.zshrc`, `.aliases.zsh`, etc.)
- `failed_installations.txt` is written during package install failures and checked at the end of `main-setup.sh`
- GitHub repos are cloned to `~/Workspace/` (not inside dotfiles)
- VS Code settings sync is intentionally disabled — local config files are used instead
- `.p10k.zsh` and `.zshrc` have benign linter warnings that can be ignored (they run fine)

## Things to Be Careful About

- **Don't auto-commit** — this repo contains personal config (git identity, work paths). Always show diffs and ask before committing.
- **Don't add secrets** — `personal-access-token.txt` is gitignored; keep it that way. Watch for tokens or credentials accidentally added to tracked files.
- **Scripts modify system state** — changes to `scripts/` affect real Mac setup. Be conservative; test logic carefully before suggesting edits.
- **`.gitconfig` contains personal info** — name and email are user-specific; don't treat them as constants to change.
