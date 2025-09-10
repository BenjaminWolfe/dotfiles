# Mac Development Environment Setup

A comprehensive dotfiles repository for automating the setup of a macOS development environment. This repo contains scripts, configurations, and preferences to quickly set up a new Mac with all the tools and settings needed for development work.

## 💡 The Workflow

1. **On your OLD laptop:**
   Fork this repo and customize it with your preferences (~10 minutes)
2. **On your NEW laptop:**
   Just navigate to your fork's [prerequisites.md](prerequisites.md) in a browser,
   copy-paste into Terminal, and go! (~20-30 minutes mostly unattended)

**Note:** This setup is for Mac.
If you're coming from Windows, you'll need a Mac first!
(But this repo will help you get set up quickly once you have one.)

## 🚀 Quick Start

**If you just want to get going:**

1. Fork this repo on GitHub (you'll want the `palomar` branch for work)
2. Edit at minimum: [prerequisites.md](prerequisites.md) (your name, email, GitHub username) and [.gitconfig](.gitconfig) (name, email)
3. On new laptop: Go to your fork's [prerequisites.md](prerequisites.md) on GitHub, copy the commands, paste into Terminal
4. Run `~/.dotfiles/scripts/main-setup.sh` and choose option 9

**For full customization instructions, see below**—including notes
on Chrome bookmarks and Azure Data Studio connections.

## 🎯 What This Does

This repository automates the installation and configuration of:
- **Core Tools**: Xcode CLI, Homebrew, Oh My Zsh with Powerlevel10k theme
- **Development Tools**: VS Code, iTerm2, Git, R/radian, Azure Data Studio
- **Productivity Apps**: Rectangle, 1Password, Lunar, Karabiner
- **Shell Environment**: Custom aliases, zsh plugins, syntax highlighting
- **System Preferences**: Dock behavior, keyboard settings, file associations
- **Workspace Setup**: Creates `~/Workspace` folder for all your GitHub repos (keeping code separate from system files and OneDrive)

## 📁 Repository Structure

This is the `palomar` branch, customized for work use:

```
.dotfiles/
├── config/                # Package lists for installation
│   ├── casks.txt          # GUI applications (VS Code, iTerm2, etc.)
│   ├── formulae.txt       # CLI tools (jq, miller, r, etc.)
│   ├── repos.txt          # GitHub repositories to clone
│   └── taps.txt           # Homebrew tap repositories
├── scripts/               # Automation scripts
│   ├── main-setup.sh      # Main orchestrator script
│   ├── install-*.sh       # Component installers
│   ├── setup-*.sh         # Configuration scripts
│   └── teardown.sh        # Uninstall script
├── vscode/                # VS Code configuration
│   ├── settings.json      # Editor settings
│   ├── keybindings.json   # Custom keyboard shortcuts
│   ├── extensions.txt     # Extension list
│   └── *.code-workspace   # Workspace files
├── iterm2/                # iTerm2 configuration
├── tools/                 # Any custom shell scripts
├── .zshrc                 # Zsh configuration
├── .zprofile              # Zsh profile (PATH setup)
├── .aliases.zsh           # Shell aliases
├── .p10k.zsh              # Powerlevel10k theme config
├── .gitconfig             # Git configuration
└── .gitignore_global      # Global git ignores
```

Your GitHub repos (as listed in [repos.txt](config/repos.txt)) will be cloned to `Workspace`.
This keeps your work organized and separate from system files, dotfiles, and applications.
Workspace is also a new folder and is not unnecessarily copied to OneDrive.

## 🚀 Getting Started (For Team Members)

### Step 1: Fork and Customize (On Your OLD Laptop—Mac or Windows)

Do this part comfortably on your existing laptop where you already have VS Code and Git set up:

1. **Fork this repository** to your own GitHub account via GitHub's web interface

   - Make sure you're on the `palomar` branch before forking
   - You can make your fork private if you prefer (Settings → General → Change visibility)

2. **Clone your fork and open in VS Code:**

   ```sh
   git clone -b palomar https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles-custom
   code ~/dotfiles-custom
   ```

3. **Customize these files in VS Code:**

   | File                                                                 | What to Change                                        |
   |----------------------------------------------------------------------|-------------------------------------------------------|
   | [prerequisites.md](prerequisites.md)                                 | Your name, email, SSH key filename, and GH username   |
   | [.gitconfig](.gitconfig)                                             | Your name and email                                   |
   | [config/repos.txt](config/repos.txt)                                 | Your GitHub repositories (or clear it)                |
   | [config/casks.txt](config/casks.txt)                                 | Apps you want installed                               |
   | [config/formulae.txt](config/formulae.txt)                           | CLI tools you want                                    |
   | [vscode/extensions.txt](vscode/extensions.txt)                       | Your VS Code extensions                               |
   | [vscode/palomar.code-workspace](vscode/palomar.code-workspace)       | Your workspace configuration                          |
   | [.aliases.zsh](.aliases.zsh)                                         | Your custom aliases                                   |
   | [scripts/link-chrome-bookmarks.sh](scripts/link-chrome-bookmarks.sh) | Your OneDrive path & Chrome profile (see also step 7) |
   | [scripts/link-ads-connections.sh](scripts/link-ads-connections.sh)   | Your OneDrive path (see also step 7)                  |

4. **Commit and push your changes:**

   ```sh
   cd ~/dotfiles-custom
   git add .
   git commit -m "Customize for my setup"
   git push
   ```

5. **Optionally, test your prerequisites.md:**

   ```sh
   # View the file to make sure your customizations look right
   cat prerequisites.md | head -20
   ```

6. **Clean up:**

   ```sh
   rm -rf ~/dotfiles-custom
   ```

7. **Chrome and Azure Data Studio** (optional)

   Copy your Chrome bookmarks and Azure Data Studio settings to OneDrive:

   ```sh
   # Set these variables to match your setup
   ONEDRIVE_NAME="OneDrive - Palomar Holdings Ins"
   CHROME_PROFILE="Default"

   # Create the destination directories
   mkdir -p "$HOME/$ONEDRIVE_NAME/Chrome/$CHROME_PROFILE"
   mkdir -p "$HOME/$ONEDRIVE_NAME/Azure Data Studio/User"

   # Copy the Chrome bookmark and ADS settings files
   cp "$HOME/Library/Application Support/Google/Chrome/$CHROME_PROFILE/Bookmarks" \
     "$HOME/$ONEDRIVE_NAME/Chrome/$CHROME_PROFILE/"
   cp "$HOME/Library/Application Support/Google/Chrome/$CHROME_PROFILE/Favicons" \
     "$HOME/$ONEDRIVE_NAME/Chrome/$CHROME_PROFILE/"
   cp "$HOME/Library/Application Support/azuredatastudio/User/settings.json" \
     "$HOME/$ONEDRIVE_NAME/Azure Data Studio/User/"
   ```

### Step 2: Set Up Your NEW Laptop

Now when you get your new laptop, it's just copy-paste:

1. **Open a browser** (Chrome if Palomar IT installed it, otherwise Safari) **and navigate to:**

   ```
   https://github.com/YOUR_USERNAME/dotfiles/blob/palomar/prerequisites.md
   ```
   (Replacing `YOUR_USERNAME` with your username—and you may need to log into GitHub first)

2. **Copy and run the commands from [prerequisites.md](prerequisites.md) in Terminal**

   - The first block sets up Git with your info
   - The second block creates your SSH key
   - Add the key to GitHub when prompted (the script copies it to your clipboard)
   - The third block clones your customized dotfiles

3. **Run the automated setup:**

   ```sh
   cd ~/.dotfiles/scripts
   ./main-setup.sh
   ```

   Select **option 9** to run everything. The script will:

   - Install all your apps and tools
   - Configure your shell environment
   - Set up VS Code with your extensions
   - Create symlinks for your dotfiles
   - Create `~/Workspace` folder for organizing your work
   - Clone your GitHub repositories into `~/Workspace`

   Notes:

   - **It may prompt for your password a few times**, so stick around.
   - When it asks you about creating _dummy files_, say Yes (see below).
   - It may recommend testing `radian` from the terminal window.
     That will work best in a new Terminal session,
     so just wait till you've opened VS Code (below).
   - Finally, the script may make suggestions, like adding lines to `.zshrc`;
     I've already handled most of these, so you can likely ignore them.

4. **Open VS Code** the first time by opening Finder
   and double-clicking on `~/.dotfiles/vscode/palomar.code-workspace`.
   This will ensure all your usual repos and folders are ready to go.

   To find this file in Finder, you'll need to:

   - Add your home directory to the Finder: **Finder** > **⌘,** > **Sidebar** > your username
   - Unhide hidden files with the **⌘.** shortcut (since `.dotfiles` will be hidden).

   To test radian, hit **⌘J** to open a terminal window,
   and follow the instructions printed when you ran the setup script!

5. **Sync Chrome bookmarks and Azure Data Studio connections** to OneDrive:

   ```sh
   cd ~/.dotfiles/scripts
   ./link-chrome-bookmarks.sh
   ./link-ads-connections.sh
   ```

   When you open Azure Data Studio, you'll still have to plug in your passwords.

6. **Run through manual setup steps**

   Some things can't be automated;
   see [manual-customizations.md](manual-customizations.md) for a walk-through.
   They include:

   - **Signing into apps**: 1Password, browsers, Spotify, etc.
   - **Configuring 1Password** (including browser extensions)
   - **Setting up displays and Bluetooth devices**
   - **System Preferences** that require manual intervention

[main-setup.sh](main-setup.sh) will have added some lines and files here and there.
When you're done, open the repo in VS Code and discard changes from the source control panel
(like `.zprofile`, `.zshrc`, `failed_installations.txt`, and any dummy files).

## 🎨 Key Customization Points
### Getting Your Current Settings

**If you're on a Mac (OLD laptop):**

Before customizing the fork, you might want to export your current settings:

```sh
# Get your current VS Code extensions
code --list-extensions > ~/Desktop/my-vscode-extensions.txt

# Get your current Homebrew packages
brew list --cask > ~/Desktop/my-casks.txt
brew list --formula > ~/Desktop/my-formulae.txt

# Or, to get ONLY formulae you explicitly installed (requires jq):
brew info --json=v2 --installed \
| jq -r '.formulae[] | select([.installed[].installed_on_request] | any) | .full_name' \
| sort > ~/Desktop/my-requested-formulae.txt

# Get all installed applications (for reference)
ls /Applications > ~/Desktop/my-applications.txt

# Get your current Git config
git config --global user.name
git config --global user.email
```

**Coming from Windows?**

- You can still fork and customize on your Windows machine
- Check what applications you use most frequently
- Google "homebrew install [app name]" to see if it's available on Mac
- If it installs with `--cask`, add it to [config/casks.txt](config/casks.txt)
- If it installs without `--cask`, add it to [config/formulae.txt](config/formulae.txt)
- Note: Azure Data Studio is the Mac equivalent for SQL Server Management Studio
- Many Windows apps have Mac equivalents (e.g., Notepad++ → VS Code, WinSCP → Cyberduck)

### Essential Changes

- **Git Identity**: Update name/email in [prerequisites.md](prerequisites.md) and [.gitconfig](.gitconfig)
- **GitHub Username**: Update `GH_USERNAME` in [prerequisites.md](prerequisites.md) to your GitHub username
- **SSH Key**: Choose your own filename in [prerequisites.md](prerequisites.md)
- **Branch**: Make sure [prerequisites.md](prerequisites.md) references the `palomar` branch (it should by default)
- **Work Repositories**: Replace repos in [config/repos.txt](config/repos.txt) or clear the file

### Optional Customizations

- **Applications**: Edit [config/casks.txt](config/casks.txt) to add/remove apps
- **CLI Tools**: Edit [config/formulae.txt](config/formulae.txt) for command-line tools
- **VS Code**: 
  - Extensions in [vscode/extensions.txt](vscode/extensions.txt) (tip: run `code --list-extensions` on your old laptop to get your current list)
  - Settings in [vscode/settings.json](vscode/settings.json) (copy from `~/Library/Application Support/Code/User/settings.json`)
  - Workspace in [vscode/palomar.code-workspace](vscode/palomar.code-workspace)
- **Shell Aliases**: Add your own in [.aliases.zsh](.aliases.zsh)
- **Zsh Theme**: The repo uses Powerlevel10k; run `p10k configure` to customize after setup

### Work-Specific Features

**If you're at Palomar:**

- Keep the OneDrive sync scripts as-is
- Update [config/repos.txt](config/repos.txt) with your team's repositories

**If you're NOT at Palomar:**

- Remove or comment out everything in [config/repos.txt](config/repos.txt)
- Either ignore the OneDrive sync scripts or update them with your company's paths:
  - [scripts/link-chrome-bookmarks.sh](scripts/link-chrome-bookmarks.sh)
  - [scripts/link-ads-connections.sh](scripts/link-ads-connections.sh)
- Update workspace file [vscode/palomar.code-workspace](vscode/palomar.code-workspace) or create your own

## 💻 What Gets Installed
### Default Applications (config/casks.txt)

- **Security**: 1Password
- **Development**: VS Code, iTerm2, Azure Data Studio (for SQL Server), MongoDB Compass
- **Productivity**: Rectangle (window management), Karabiner (keyboard customization)
- **Browsers**: Firefox
- **Other**: Zoom, Signal, Spotify

### Default CLI Tools (config/formulae.txt)

- **Shell**: bash, zsh plugins (syntax highlighting, autosuggestions)
- **Data Tools**: jq, miller, R, pipx (for radian)
- **System**: wget, syslog-ng

### VS Code Extensions

See [vscode/extensions.txt](vscode/extensions.txt) for the full list including:

- GitHub Copilot
- Python/Jupyter support
- SQL tools
- Docker support
- Various formatters and linters

## 💡 Ongoing Maintenance & Tips

To keep Homebrew software updated, consider these handy commands:

```sh
brew update && brew upgrade
brew outdated
```

Oh My Zsh with PowerLevel10k is a wonderful setup.
Google or ask an AI for tips on how to use it well.

My most basic tip is, **it has its own autocomplete**, which is very powerful.
To take advantage of its suggestions, use Shift-Tab.
A simple tab will just give you zsh's built-in suggestions.

## 🗑️ Uninstalling

To remove everything installed by this repo:

```sh
cd ~/.dotfiles/scripts
./teardown.sh
```

**Notes:**

- Run this from the Terminal, not from VS Code,
  since it will uninstall VS Code itself.
- It may prompt you for your password along the way.
- It should remind you of any manual steps at the end.
- Review the script first if you want to customize what gets removed.
- Optionally, to remove all VS Code extensions first:

  ```sh
  code --list-extensions | xargs -n 1 code --uninstall-extension
  ```

## 📚 Additional Documentation

- [prerequisites.md](prerequisites.md): Initial Git/SSH setup
- [manual-customizations.md](manual-customizations.md): Manual configuration steps
- [how_to/jq_and_mlr.md](how_to/jq_and_mlr.md): Examples of data manipulation tools

## 🤝 Contributing Back

If you add useful scripts or configurations that others might benefit from:

1. Consider if they're company-specific or generally useful
2. Add clear comments explaining what they do
3. Update the README if adding new customization points
4. Share back via pull request to the original repo if it's generally useful

Feel free to share your fork with other team members too—they might like your customizations!

## ⚠️ Important Notes

- **Do all customization on your OLD laptop** where you have VS Code already installed
- On your NEW laptop, you'll just copy-paste from [prerequisites.md](prerequisites.md)—no editing needed
- This setup is Mac-specific (uses Homebrew, macOS defaults commands)
- Some installations require admin (sudo) access
- The setup modifies shell configuration files—backups are created automatically
- VS Code settings sync will be disabled in favor of local config files
- Review scripts before running to understand what they'll change

## 🆘 Troubleshooting

- **Homebrew issues**: Run `brew doctor`
- **Permission errors**: Check script permissions with `ls -la`
- **VS Code extensions fail**: Install manually through VS Code
- **Shell not changing**: Log out and back in after setup
- **iTerm2 preferences not loading**: Check preferences location in iTerm2 settings

---

*Originally created by Benjamin Wolfe.*
*This is the `palomar` branch for work use.*
*Fork it and make it your own!*
