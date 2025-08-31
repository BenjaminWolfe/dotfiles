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

## Troubleshooting

If you encounter issues:
- **VS Code warnings:** Check extensions and settings sync status.
- **Homebrew failures:** Run `brew doctor` and check for missing dependencies.
- **Permission errors:** Ensure you have the correct permissions for scripts and config files.

For more help, see [manual-customizations.md](manual-customizations.md).

[edc]: https://en.wikipedia.org/wiki/Everyday_carry
