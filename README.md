Emacs for Windows with Dark Mode
================================

This is a build of Emacs (from master branch) for Windows 10 (1809 and
higher) and Windows 11 which follows Windows light/dark mode (titlebar
and scollbars). See [this pull request](https://github.com/vsalvino/emacs/pull/1)
for a diff of only the relevant changes, exluding my build scripts and README.

Example with Windows Dark mode and Light mode:

![image](https://user-images.githubusercontent.com/13453401/138809142-0f4d10a4-a6f6-45ef-b068-041c12ba8b63.png)

![image](https://user-images.githubusercontent.com/13453401/138809293-824ed605-aee5-4041-b446-9fb2e8bf2ab2.png)

Download
--------
Download `emacs-darkmode.zip` from the latest
[release](https://github.com/vsalvino/emacs/releases), extract to your
machine, and launch `bin/runemacs.exe`. Or download
`emacs-darkmode-installer.exe` if you prefer to install Emacs.
Releases are 64-bit, built for Intel Skylake (6th gen) CPUs and newer.

If you have an older CPU, let me know and I can produce a build.

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
