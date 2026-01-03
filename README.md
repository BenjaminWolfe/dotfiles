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
- _Control center_
  - Scroll down to _Automatically hide and show the menu bar_ > **Never**
    - This is critical so you can see the time when you're in another workspace
      (to combat timeblindness!)
- _Login items_: Loom, Rectangle
  - On the same screen, under _Allow in the background_, disable Epson apps
    (Epson turns on 3 by default!)
- _Display the time with seconds in the menu bar_
- _Customize modifier keys_
  - If you're using a Das Keyboard, set Option to Command and Command to Option
- _Mouse sensitivity_: 7/10 for magic mouse or magic trackpad
- _Mouse buttons_: set secondary click
- _Allow applications to update or delete other apps_: VS Code
  - This lets you update applications via Homebrew from the integrated terminal
- _Dictation_: turn it on, set the microphone, and set the shortcut
  (I like to use "Press the Control key twice")
  - On the same screen, turn off _Auto-punctuation_
- _Spotlight search categories_: Applications and System Settings are all I use
- _Internet accounts_: Add Google account for Calendars
  - This will use Safari to authenticate; resist adding 1Password for Safari
    as it's a very poorly reviewed app
  - The whole purpose of this is for rare cases
    where you have to open an `invite.ics` file (see below)
- _Night Shift options_: Schedule: Sunset to Sunrise

To change default applications for opening a file type,
find one of those files, right-click, "Get Info," "Open with,"
choose the application, and click "Change All."

In icon views in Finder, those files still may show the wrong application.
To fix that, then run these lines:

```sh
sudo rm -rf /Library/Caches/com.apple.iconservices.store
sudo killall Finder
```

I've had to do this for TypeScript files, as `.ts` is also a video format.

## Calendar

- Open the Calendar app and hit **⌘,** for preferences
- Under **General**, for **Default Calendar** choose _Benjamin_ from _Google_
  or wherever you want `invite.ics` files to be added by default
- Under **Accounts**, disable iCloud
- Under **Alerts**, just uncheck everything

## 1Password

It's easiest to set up 1Password from your phone:

- Log in (fingerprint)
- In the upper right, go to each account, business and home, in turn
- For each, also in the upper right, go to _Set Up Another Device_
- Copy the secret key
- On your Mac, you may want to sign in in Chrome as well as the app

Then in the app, under Settings, set _Security_ the way you like it:

- Require password **Every 30 days** (like Signal)
- Lock after the computer is idle for **Never** (since I keep it mostly at home)
- Uncheck **Lock on sleep…** (since my laptop goes to sleep often)

Then set up 1Password CLI.
In the app, in the upper left, click **Settings** > **Developer**,
and check **Integrate with 1Password CLI**.

To really enjoy 1Password, I also [hobbled Google Password Manager][1password-chrome-cleanup]
so it wouldn't get in the way!

## Insomnia

- Open Insomnia and log in via GitHub.
- Open **Preferences** > **Plugins** > **Browse Plugin Hub**
- Enter `insomnia-plugin-op` and click **Install Plugin**
- On the main Insomnia screen, pick a workspace
- At the bottom left, click the **+** next to **Environments** to add one;
  call it `base` or anything you like
- Tell the plugin where to find 1Password by replacing the blank `{}` with this:

  ```
  {
    "__op_plugin": {
      "cliPath": "/opt/homebrew/bin/op"
    }
  }
  ```

See [how_to/insomnia_1password.md](how_to/insomnia_1password.md) for more
on how to take advantage of this integration.

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

## Permissions: Discord

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

## Other App Customization

Allow assistive applications to control the computer
iTerm
Logi Options+
Loom
Lunar
Rectangle
Visual Studio Code

Allow applications to monitor keyboard input
Logi Options+

https://support.logi.com/hc/en-us/articles/360035271133-Getting-Started-MX-Master-3

- Rectangle
  - Launch on login
    - (This may not be needed if you set it in System Preferences!
      Come back and update this if you find that's the case)
- VS Code
  - In the version control panel
    - Next to **Source Control Repositories**
      - Three dots > **Sort by Name** just because it puts this repo at the top
    - Next to **Source Control** (below **Source Control Repositories**)
      - Three dots > **View & Sort**: **View as Tree**
- Slack
  - Mute audio notifications
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
[1password-chrome-cleanup]: https://support.1password.com/disable-browser-password-manager/
[ms-licensing]: https://support.microsoft.com/en-us/office/transfer-your-office-license-to-another-device-or-another-person-8a967fb6-6c65-433e-800e-b9ae3436c2de
[ms-uninstall]: https://support.microsoft.com/en-us/office/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3
[ms-account]: https://account.microsoft.com/
[epson-download]: https://epson.com/Support/Printers/All-In-Ones/WorkForce-Series/Epson-WorkForce-Pro-WF-4833/s/SPT_C11CJ05202
[reddit-keystrokes]: https://www.reddit.com/r/discordapp/comments/haygfd/why_is_discord_asking_permission_to_record_all_of/
