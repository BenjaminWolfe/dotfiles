# Manual Customizations

Before walking through these, follow the steps from the [README](readme.md).

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

I've also had to do this for TypeScript files, as `.ts` is also a video format.

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

## Displays and Bluetooth Devices, and Sounds

Not much to walk through here.
But this is always one of the first things I do, after the basic basics.
I want my laptop to see my monitors and my various peripherals!

And sometimes I'm switching laptops in the middle of a busy day—
so it's smart to get the audio right right away.

## OS Customization

- Add your home directory to the Finder: **Finder** > **⌘,** > **Sidebar** > your username
- Add the Workspace directory to the Finder:
  - Go back to the main Finder screen
  - Click on your username that's now showing in the lefthand sidebar
  - Then double-click the **Workspace** folder
  - Then mouse over **Workspace** at the top until you see a little blue folder
  - Drag that blue folder over into the menu bar

And for system settings, search Spotlight for the following and make some changes:

- _Allow applications to record your screen_: Any applications that make sense
  - Conference calling apps like Zoom, Teams, and Slack (Slack also for videos)
  - Remember Google Meet meetings happen in Chrome, plus maybe Firefox
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
- _Mouse sensitivity_: 7/10 for magic mouse or magic trackpad (there is no 0)
- _Mouse buttons_: set secondary click to right side if needed
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
- _Allow applications to access your location_: Up to you
- _Night Shift options_: Schedule: Sunset to Sunrise
- _Desktop & Dock_: uncheck the "On Desktop" box under the "Show items" section
  to hide all the messy screenshots on your desktop!

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

## Other Manual Installs

- [Toggl Track][toggl], if you use it, is only available on the App Store.
- You may want to install **Chrome apps** like Messenger and possibly YouTube Music.
- If you may want to scan documents, and you're still using this printer,
  find the download page for the [Epson WorkForce Pro WF-4833][epson-download] printer/scanner/copier,
  and download and install the software.

## Other App Customization

- VS Code
  - In the version control panel
    - Next to **Changes**
      - Three dots > **View & Sort** > **Repositories** > **Sort by Name**
      - Three dots > **View & Sort** > **View as Tree**
- Outlook (if applicable)
  - Consider **Tools** > **Keyboard Shortcuts**; I sometimes use Gmail shortcuts.
- Firefox (if applicable)
  - You'll want to sync bookmarks
  - It seems to want you to download the mobile app, but I think it's optional
- Signal (if applicable)
  - Just open it and follow the directions to link accounts
  - If you're not keeping your old laptop, probably un-link that one!
    - Rename this laptop from your phone:
      Profile Pic > Linked Devices > 3 dots next to a device > Edit Name
    - Confirm that the name changed on your new laptop:
      Hamburger Menu > General > Device Name
    - Unlink the old laptop from your phone:
      Profile Pic > Linked Devices > 3 dots next to the device > Unlink
    - Delete data on the old laptop:
      Hamburger Menu > Privacy > Delete Data
    - You can use the uninstall script (see `README.md`) to uninstall Signal
- Spotify (if applicable)
  - Spotify is a simple QR code as well
- Lunar (if applicable)
  - Lunar has some setup steps to check that it can update your monitors
- Slack (if applicable)
  - Mute audio notifications
- Toggl (if applicable)
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
[toggl]: https://apps.apple.com/us/app/toggl-track-hours-time-log/id1291898086
[1password-chrome-cleanup]: https://support.1password.com/disable-browser-password-manager/
[epson-download]: https://epson.com/Support/Printers/All-In-Ones/WorkForce-Series/Epson-WorkForce-Pro-WF-4833/s/SPT_C11CJ05202
