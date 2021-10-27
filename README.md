Emacs for Windows with Dark Mode
================================

This is an experimental build of Emacs for Windows 10 (1809 and
higher) and Windows 11 which follows Windows light/dark mode (titlebar
and scollbars). See the `vsalvino/darkmode-patch` branch in this
repository for a diff of only the relevant changes, exluding my build
scripts and README.

Example with Windows Dark mode and Light mode:

![image](https://user-images.githubusercontent.com/13453401/138809142-0f4d10a4-a6f6-45ef-b068-041c12ba8b63.png)

![image](https://user-images.githubusercontent.com/13453401/138809293-824ed605-aee5-4041-b446-9fb2e8bf2ab2.png)

Caveats
-------
* This dark mode implementation is only available in supported
  versions of Windows. If you run it on an older system it should
  behave as usual.
* This is using an internal (undocumented) Windows API. Therefore it
  could technically change at any time. Microsoft has notoriously not
  published an API to enable dark mode on Win32 apps. However many
  apps have "figured it out" and started using it out of desperation
  (see "Inspiration" below). These APIs seem to have "settled" and
  have been consistent for the past several releases of Windows.

Download
--------
Download `emacs-darkmode.zip` from the latest
[release](https://github.com/vsalvino/emacs/releases), extract to your
machine, and launch `bin/runemacs.exe`. Since I use this as my daily
driver I have intentionally compiled the build with no debugging, high
optimization, and only for Intel Skylake (6th-ish gen) processors and
higher.

TODO
----
* ~~Dark titlebars~~
* ~~Dark scrollbars~~
* Dark menu bar and/or menu items
* ~~Dark tool bar~~ (tool bar colors can be customized via faces)
* ~~Dark tab bar mode~~ (tab bar colors can be customized via faces)
* ~~Follow system light/dark mode.~~ This is loaded from the Windows
  Registry when Emacs is launched.

Inspiration
-----------
* [WindowsAppSDK](https://github.com/microsoft/WindowsAppSDK/issues/41)
* [WinSCP](https://winscp.net/tracker/1920) (see discussion and
  commits on their bug tracker).
* [Windows Terminal](https://github.com/microsoft/terminal/commit/bc7eb9611030aed3204aff4e662c318cbf9143a6#diff-e26a93b2aa9fea92ebf24336c4fe6412L19-L22)
  (they initially published commits using the internal API on GitHub,
  then removed it).
* [win32-darkmode](https://github.com/ysc3839/win32-darkmode) (this
  code is quite grizzly but insightful)
