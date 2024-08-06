# dotfiles

The [Everyday Carry][edc] for my personal setup, so to speak.
It's meant to help me get set up on a new Mac.
See [prerequisites.md](prerequisites.md) to get started.

## Automated Set-Up

Run [scripts/setup](scripts/setup) to set everything up!
**Note:** As of 2024-07-23, I haven't actually tested this script end to end.

## OS Customization

- Add your home directory to the Finder: **Finder** > **⌘,** > **Sidebar** > your username
- Add the Workspace directory to the Finder:
  - Click on your username that's now showing
  - Then **Workspace**
  - Then mouse over **Workspace** at the top until you see a little blue folder
  - Drag that blue folder over into the menu bar

And for system settings, search Spotlight for...

- _Allow applications to record your screen_: Zoom, Slack, Toggl, Chrome, Webex
  - You'll need to add Zoom before any conference calls!
  - Slack is for huddles and async screen-share videos
  - Toggl is to make time tracking easier
  - Chrome is for Google Meet, as well as in-browser Teams meetings
  - Webex is for Tableau support sessions
- _Display the time with seconds in the menu bar_
- _Customize modifier keys_
  - If you're using a Das Keyboard, set Option to Command and Command to Option
- _Mouse sensitivity_: 7/10 for magic mouse or magic trackpad
- _Mouse buttons_: set secondary click
- _Allow applications to update or delete other apps_: VS Code
  - This lets you update applications via Homebrew from the integrated terminal
- _Dictation_: turn it on, set the microphone, and set the shortcut
- _Spotlight search categories_: Applications and System Settings are all I use

## License and Install: MS Office

[Per Microsoft][ms-licensing], you can only have Microsoft Office on one device at a time.
Just [uninstall it][ms-uninstall] from your old laptop;
then go to your [Microsoft Account][ms-account] > **Services & subscriptions** >
**Products you've purchased** at the bottom > **Install**.

## Other Manual Installs

- [Tableau][tableau]'s Homebrew cask is outdated. Use their download page instead.
- [Toggl Track][toggl] is only available on the App Store.
- You'll want to install **Chrome apps** like Messenger and possibly YouTube Music.
- Find the download page for the [Epson WorkForce Pro WF-4833][epson-download] printer/scanner/copier,
  and download and install the software. You'll need this for scanning documents.

## Permissions

Discord will ask for permission to record keystrokes from other applications.
You do _not_ have to allow that.
That's for if you're gaming, and you want to start a call w/o leaving the game.
Per [Reddit][reddit-keystrokes].

## License: Ableton Live Suite 11

You'll have installed Ableton from the automated setup script above.
An Ableton license allows installation on 2 devices simultaneously.
I haven't yet had to de-authorize it from an old device.

## Sync: Obsidian

Use Obsidian, rather than GitHub, for the initial Journal sync.
Just start the application and sync the vault from there.

- Use the vault called Journal 2022+.
- Name it _Journal_ because that'll be the name of the folder Obsidian creates.
- Place it in `~/Workspace`.

## Default Applications by File Extension

The [setup script](scripts/setup.sh) will have created a folder
within this repository, called `dummy_files`,
populated with any files worth associating with new applications (like `csv`).
It will even have opened the folder in Finder!

- Right-click on each file > **Get Info**
- Under **Open with**, select the application you want to use
- Click **Change All**, and **Continue** to confirm

Then feel free to close the _Get Info_ window, delete the file,
and delete the whole folder when you're done with them.

## Other Customization

- In the VS Code version control panel, next to the words `source control`,
  click the 3 dots, and choose:
  - View & Sort: View as Tree
  - Repositories: Sort by Path
- Mute audio notifications in Slack.
- Toggl
  - General: Open at Login
  - Calendar: Activity Recording: Record active application and window

## Other Notes

Sometimes on your old laptop, you'll have files in your working directory in local git repos.
Just copy everything to an external HD before wiping.

See [swagger.md](swagger.md) on why I clone the `swagger-ui` repo and how to use it.

## Repo Notes

I can't seem to get rid of a couple spots VS Code is marking as issues:

- [.p10k.zsh](.p10k.zsh): `22:4: statements must be separated by &, ; or a newline`
- [.zshrc](.zshrc): `4:65: parameter expansion requires a literal`

Neither of them seem to be real issues, as the scripts run fine.

[edc]: https://en.wikipedia.org/wiki/Everyday_carry
[tableau]: https://www.tableau.com/support/releases/desktop/2024.2#esdalt
[toggl]: https://apps.apple.com/us/app/toggl-track-hours-time-log/id1291898086
[ms-licensing]: https://support.microsoft.com/en-us/office/transfer-your-office-license-to-another-device-or-another-person-8a967fb6-6c65-433e-800e-b9ae3436c2de
[ms-uninstall]: https://support.microsoft.com/en-us/office/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3
[ms-account]: https://account.microsoft.com/
[epson-download]: https://epson.com/Support/Printers/All-In-Ones/WorkForce-Series/Epson-WorkForce-Pro-WF-4833/s/SPT_C11CJ05202
[reddit-keystrokes]: https://www.reddit.com/r/discordapp/comments/haygfd/why_is_discord_asking_permission_to_record_all_of/
