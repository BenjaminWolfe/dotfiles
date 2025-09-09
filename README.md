# dotfiles

This is my [Everyday Carry][edc] for my personal setup, so to speak.
It's meant to help me, or you, get set up on a new Mac.

See [prerequisites.md](prerequisites.md) to get started.
I've really tried to set it up so that all you have to do
is connect to the internet, go to GitHub, find your way to this repository,
and copy-paste into a Terminal window to kick things off.

## Automated Set-Up

- Run [scripts/main-setup.sh](scripts/main-setup.sh) to set everything up!
  ```sh
  cd ~/.dotfiles/scripts
  ./main-setup.sh
  ```
  It may prompt you for your password a few times.
  Before to enter it!
  It will likely also tell you to add lines here and there to `.zshrc`.
  Don't worry; I've handled it!
- It may ask you about dummy files to change default applications.
  Feel free to select Yes! (See immediately below.)
- It may recommend testing `radian` from the terminal window.
  For that, wait till after you've opened VS Code! (See below.)
- Double-click on `~/.dotfiles/vscode/palomar.code-workspace`
  straight from Finder and it should open VS Code to a workspace
  of all the relevant repos.
- To pull up a terminal window in VS Code, use Command-J.
- If the setup script creates a dummy CSV file and displays it in Finder,
  its purpose is to help you set up your Mac to open CSVs in Excel.
  See **Changing Default Applications by File Type**
  in [manual-customizations.md](manual-customizations.md).
- The process will have added some lines and files here and there.
  So when you're done, feel free to open the repo in VS Code
  and discard changes in the source control panel
  (like `.zprofile`, `.zshrc`, `failed_installations.txt`, and `dummy_files`).

## Google Chrome Bookmarks

I was locked from syncing my Chrome bookmarks on my work laptop.
So instead, I used OneDrive to do it.

To set this up:

- Copy your `Bookmarks` and `Favicons` files on your old laptop
  from `~/Library/Application Support/Google/Chrome/Default` (for the `Default` profile)
  to `~/OneDrive - Palomar Holdings Ins/Chrome/Default`
  (again for the `Default` profile, and assuming that `OneDrive - Palomar Holdings Ins` is your shared drive).
- If it was anything other than that profile and that shared drive location,
  update the variables near the top of `scripts/link-chrome-bookmarks.sh`.
- Then on your new laptop, run the following (it will close Chrome):
  ```sh
  cd ~/.dotfiles/scripts
  ./link-chrome-bookmarks.sh
  ```

## Azure Data Studio

At work I also use Azure Data Studio to connect to SQL Server.
Similar to with Chrome, I've symlinked my `settings.json` to OneDrive.

As with Chrome, to set this up:

- Copy `settings.json` on your old laptop
  from `~/Library/Application Support/azuredatastudio/User`
  to `~/OneDrive - Palomar Holdings Ins/Azure Data Studio/User`
  (assuming that `OneDrive - Palomar Holdings Ins` is your shared drive).
- If it was anything other than that shared drive location,
  update the variable near the top of `scripts/link-ads-connections.sh`.
- Then on your new laptop, run the following:
  ```sh
  cd ~/.dotfiles/scripts
  ./link-ads-connections.sh
  ```
- When you open Azure Data Studio, you'll still have to plug in your passwords.

## Manual Customizations

Continue with the manual (and usually optional) customizations
from [manual-customizations.md](manual-customizations.md).
You'll want to, at the very least, get set up with 1Password if you use it
(along with the Chrome extension).

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

## GitHub Copilot

To use GitHub Copilot in VS Code the first time,
click where it says "Signed Out" in the bottom rail, and sign in!

Copilot is supported in VS Code, but not in iTerm2.
For Copilot in the terminal, use the VS Code integrated terminal.

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
