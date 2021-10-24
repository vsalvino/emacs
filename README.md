Emacs for Windows with Dark Mode
================================

This is an experimental build of Emacs for Windows 10/11 (2004 and
higher) which follows Windows dark mode (titlebar and scollbars). See
the `vsalvino/darkmode` branch in this repository.

![image](https://user-images.githubusercontent.com/13453401/138581502-b496fe4e-5a49-4017-bac9-d8173469e0e8.png)

Caveats
-------
As this is a proof of concept, there are some caveats:
* This dark mode implementation is only available in Windows 10
  version 2004 or higher. If you run it on an older system it should
  behave as usual.
* This build will only work on Windows Vista and higher. Links against
  `dwmapi.dll` which was introduced in Vista. This API is only called
  on Winddows 10 2004 and higher, so it could theoretically be
  refactored into a separate build profile to maintain 9x and XP
  compatibility.
* This is using an internal (undocumented) Windows API. Therefore it
  could technically change at any time. Microsoft has notoriously not
  published an API to enable dark mode on Win32 apps. However many
  apps have "figured it out" and started using it out of desperation
  (see below). These APIs seem to have "settled" and have been
  consistent for the past several releases of Windows.

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
* ~~Dark tab bar mode~~ (tab bar colors can be customized via faces,
  so do not require support via Win32)
* Follow system light/dark mode. Currently it is hard-coded to dark
  mode as a proof-of-concept. System theme can be looked up in the
  registry. Alternatively, it might be preferrable to create an elisp
  setting to toggle this instead.

Inspiration
-----------
* [WinSCP](https://winscp.net/tracker/1920) (see discussion and
  commits on their bug tracker).
* [Windows Terminal](https://github.com/microsoft/terminal/commit/bc7eb9611030aed3204aff4e662c318cbf9143a6#diff-e26a93b2aa9fea92ebf24336c4fe6412L19-L22)
  (they initially published commits using the internal API on GitHub,
  then removed it).
* [win32-darkmode](https://github.com/ysc3839/win32-darkmode) (this
  code is quite grizzly but insightful)
