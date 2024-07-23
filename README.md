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
- Display the time with seconds in the menu bar (search for that phrase from Spotlight)
- Customize modifier keys (search for that phrase from Spotlight)
  - If you're using a Das Keyboard, set Option to Command and Command to Option
- Mouse sensitivity (search for that phrase from Spotlight): 7/10 for magic mouse

## License and Install: MS Office

[Per Microsoft][ms-licensing], you can only have Microsoft Office on one device at a time.
Just [uninstall it][ms-uninstall] from your old laptop;
then go to your [Microsoft Account][ms-account] > **Services & subscriptions** >
**Products you've purchased** at the bottom > **Install**.

## Other Manual Installs

- [Tableau][tableau]'s Homebrew cask is outdated. Use their download page instead.
- [Toggl Track][toggl] is only available on the App Store.
- If you're using the Insta360 Link camera, you'll have to [download that controller][insta360-link].
- You'll want to install **Chrome apps** like Messenger and possibly YouTube Music.

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

## Other Customization

Mute audio notifications in Slack.

## Other Notes

Sometimes on your old laptop, you'll have files in your working directory in local git repos.
Just copy everything to an external HD before wiping.

## Repo Notes

I can't seem to get rid of a couple spots VS Code is marking as issues:

- [.p10k.zsh](.p10k.zsh): `22:4: statements must be separated by &, ; or a newline`
- [.zshrc](.zshrc): `4:65: parameter expansion requires a literal`

Neither of them seem to be real issues, as the scripts run fine.

[edc]: https://en.wikipedia.org/wiki/Everyday_carry
[tableau]: https://www.tableau.com/support/releases/desktop/2024.2#esdalt
[toggl]: https://apps.apple.com/us/app/toggl-track-hours-time-log/id1291898086
[insta360-link]: https://www.insta360.com/download/insta360-link
[ms-licensing]: https://support.microsoft.com/en-us/office/transfer-your-office-license-to-another-device-or-another-person-8a967fb6-6c65-433e-800e-b9ae3436c2de
[ms-uninstall]: https://support.microsoft.com/en-us/office/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3
[ms-account]: https://account.microsoft.com/
