# Manual Customizations

Before walking through these, follow the steps from the [README](readme.md).

## 1Password

On the MacBook:

- Open 1Password
- Click "Sign In"
- Open 1Password on your phone
- Tap your profile picture in the top right, and tap "Scan QR Code…"
- Scan the QR code, and pick which account you're signing into
- Tap to allow full access

It's easiest to set up 1Password from your phone:

- Log in (fingerprint)
- In the upper right, go to each account in turn, if you have more than one
- For each, also in the upper right, go to _Set Up Another Device_
- Copy the secret key
- On your Mac, you may want to sign in in Chrome as well as the app

Then in the upper left drop-down, under Settings,
set _General_ and _Security_ the way you like them—e.g.:

- Lock after the computer is idle for **Never**, for a personal laptop
  (since I keep it mostly at home)
- Uncheck **Lock on sleep…** (since my laptop goes to sleep often)

—and go to _Browser_ and click to "Get 1Password for your Browser."

(Use "Add Browser" from that screen to add Firefox—_and_ open Firefox and add it there.)

Then set up 1Password CLI, if applicable.
In the app, in the upper left, click **Settings** > **Developer**,
and check **Integrate with 1Password CLI**.

To really enjoy 1Password, I also [hobbled Google Password Manager][1password-chrome-cleanup] on my personal laptop
so it wouldn't get in the way!

## OS Customization

- Add your home directory to the Finder: **Finder** > **⌘,** > **Sidebar** > your username
- Add the Workspace directory to the Finder:
  - Click on your username that's now showing
  - Then double-click the **Workspace** folder
  - Then mouse over **Workspace** at the top until you see a little blue folder
  - Drag that blue folder over into the menu bar

And for system settings, search Spotlight for...

- _Allow applications to record your screen_: Any applications that make sense
  - Conference calling apps like Zoom, Teams, and Slack (Slack also for videos)
  - Remember Google Meet meetings happen in Chrome
  - Toggl, if applicable, to make time-tracking easier
- _Allow assistive applications to control the computer_: At least the following
  - iTerm
  - Logi Options+
  - Loom, if applicable
  - Lunar
  - Rectangle
  - Visual Studio Code
  - It seems it also tends to add conference apps like Zoom and Teams
- _Allow applications to monitor keyboard input_
  - [Logi Options+][mx-master-3-setup]
- _Control center_
  - Scroll down to _Automatically hide and show the menu bar_ > **Never**
    - This is critical so you can see the time when you're in another workspace
      (to combat timeblindness!)
- _Login items_: Loom (if applicable), Rectangle
  - On the same screen, under _Allow in the background_,
    disable Epson apps if present (Epson turns on 3 by default!)
- _Display the time with seconds in the menu bar_
- _Customize modifier keys_
  - If you're using a Das Keyboard, set Option to Command and Command to Option
  - (On some keyboards there's a switch to do this automatically)
- _Mouse sensitivity_: 7/10 for magic mouse or magic trackpad
- _Mouse buttons_: set secondary click
- _Allow applications to update or delete other apps_: VS Code
  - This lets you update applications via Homebrew from the integrated terminal
- _Dictation_: turn it on, set the microphone, and set the shortcut
  (I like to use "Press the Control key twice")
- _Keyboard layout_: Turn off these two if you don't want them:
  - _Capitalize words automatically_
  - _Add period with double-space_
- _Spotlight search categories_: Applications and System Settings are all I use
- _Internet accounts_: Add Google account for Calendars, if applicable
  - This will use Safari to authenticate; resist adding 1Password for Safari
    as it's a very poorly reviewed app
  - The whole purpose of this is for rare cases
    where you have to open an `invite.ics` file (see below)
- _Night Shift options_: Schedule: Sunset to Sunrise
- To hide files on a Mac desktop, navigate to System Settings > Desktop & Dock
  and uncheck the "On Desktop" box under the "Show items" section.

## Changing Default Applications by File Type

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

## Rectangle

The first time you open Rectangle you'll get a system message:

> **Conflict with macOS tiling
> Drag to screen edge tiling is enabled in both Rectangle and macOS.

Choose the _Disable in macOS_ option, then click _OK_.
You can re-enable it later from System Settings > Desktop & Dock > Windows.

## Calendar

If you choose to use the _Calendar_ app at all:

- Open the Calendar app and hit **⌘,** for preferences
- Under **General**, for **Default Calendar** choose _Benjamin_ from _Google_
  or wherever you want `invite.ics` files to be added by default
- Under **Accounts**, disable iCloud
- Under **Alerts**, just uncheck everything

## Insomnia

If you use Insomnia:

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

On a work laptop, for Microsoft shops, MS Office generally comes
pre-installed and pre-licensed.
On a personal laptop:

[Per Microsoft][ms-licensing], you can only have Microsoft Office on one device at a time.
Just [uninstall it][ms-uninstall] from your old laptop;
then go to your [Microsoft Account][ms-account] > **Services & subscriptions** >
**Products you've purchased** at the bottom > **Install**.

## Other Manual Installs

- [Toggl Track][toggl], if you use it, is only available on the App Store.
- You may want to install **Chrome apps** like Messenger and possibly YouTube Music.
- If you may want to scan documents, and you're still using this printer,
  find the download page for the [Epson WorkForce Pro WF-4833][epson-download] printer/scanner/copier,
  and download and install the software.

## Permissions: Discord

If you use it:

Discord will ask for permission to record keystrokes from other applications.
You do _not_ have to allow that.
That's for if you're gaming, and you want to start a call w/o leaving the game.
Per [Reddit][reddit-keystrokes].

## Sync: Obsidian

On a personal laptop, use Obsidian, rather than GitHub, for the initial Journal sync.
Just start the application and sync the vault from there.

- Use the vault called Journal 2022+.
- Name it _Journal_ because that'll be the name of the folder Obsidian creates.
- Place it in `~/Workspace`.

## Other App Customization

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

[mx-master-3-setup]: https://support.logi.com/hc/en-us/articles/360035271133-Getting-Started-MX-Master-3
[tableau]: https://www.tableau.com/support/releases/desktop/2024.2#esdalt
[toggl]: https://apps.apple.com/us/app/toggl-track-hours-time-log/id1291898086
[1password-chrome-cleanup]: https://support.1password.com/disable-browser-password-manager/
[ms-licensing]: https://support.microsoft.com/en-us/office/transfer-your-office-license-to-another-device-or-another-person-8a967fb6-6c65-433e-800e-b9ae3436c2de
[ms-uninstall]: https://support.microsoft.com/en-us/office/uninstall-office-for-mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3
[ms-account]: https://account.microsoft.com/
[epson-download]: https://epson.com/Support/Printers/All-In-Ones/WorkForce-Series/Epson-WorkForce-Pro-WF-4833/s/SPT_C11CJ05202
[reddit-keystrokes]: https://www.reddit.com/r/discordapp/comments/haygfd/why_is_discord_asking_permission_to_record_all_of/
