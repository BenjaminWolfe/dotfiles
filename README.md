# dotfiles

The [Everyday Carry][edc] for my personal setup, so to speak.
It's meant to help me get set up on a new Mac.
See [prerequisites.md](prerequisites.md) to get started.

## Automated Set-Up

Run [scripts/main-setup.sh](scripts/main-setup.sh) to set everything up!

```sh
cd ~/.dotfiles/scripts
./main-setup.sh
```

You can then double-click on `~/.dotfiles/vscode/palomar.code-workspace`
straight from Finder and it should open VS Code to a workspace
of all the relevant repos.

If the setup script creates a dummy CSV file and displays it in Finder,
its purpose is to help you set up your Mac to open CSVs in Excel.
See **Changing Default Applications by File Type**
in [manual-customizations.md](manual-customizations.md).
Feel free to delete the whole folder when you're done with them.

## GitHub Copilot

To use GitHub Copilot in VS Code the first time,
click where it says "Signed Out" in the bottom rail, and sign in!

Copilot is supported in VS Code, but not in iTerm2.
For Copilot in the terminal, use the VS Code integrated terminal.

## Manual Customizations

Continue with the manual (and usually optional) customizations
from [manual-customizations.md](manual-customizations.md).

## After Setup Checklist

After running the automated setup, consider these post-setup steps:

- Run Homebrew maintenance commands:
  ```sh
  brew update && brew upgrade
  brew outdated
  ```
- Review manual steps:
  ```sh
  ~/.dotfiles/scripts/manual-steps-checklist.sh
  ```

## Uninstalling Everything

To remove all tools and configurations set up by this repo, use the uninstall script:

```sh
cd ~/.dotfiles/scripts
./teardown.sh
```

To remove all VS Code extensions (optional, if VS Code is still installed):

```sh
code --list-extensions | xargs -n 1 code --uninstall-extension
```

**Important notes:**
- For best results, run this script from the macOS Terminal app (not VS Code), especially if you plan to uninstall Homebrew or VS Code itself.
- Some steps (like removing cloned repos and reverting system preferences) must be done manually. The script will remind you.
- You may need to enter your password for some uninstall steps (e.g., Xcode CLI tools).
- Review the script before running if you want to customize what gets removed.

## To Update

To determine what homebrew formulae you've already added to your laptop
(in order to add them to /config/formulae.txt),
try this from the command line (with homebrew and jq installed):

```sh
brew info --json=v2 --installed \
| jq -r '.formulae[] | select([.installed[].installed_on_request] | any) | .full_name' \
| sort
```

To list taps:

```sh
brew tap | sort
```

To list casks:

```sh
brew list --cask | sort
```

## Troubleshooting

If you encounter issues:
- **VS Code warnings:** Check extensions and settings sync status.
- **Homebrew failures:** Run `brew doctor` and check for missing dependencies.
- **Permission errors:** Ensure you have the correct permissions for scripts and config files.

For more help, see [manual-customizations.md](manual-customizations.md).

[edc]: https://en.wikipedia.org/wiki/Everyday_carry
