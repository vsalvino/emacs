Emacs for Windows 10 with Dark Mode
===================================

This is an experimental build of Emacs for Windows 10/11 (20H1 and
higher) with a dark mode titlebar. See the `vsalvino/darkmode` branch
in this repository.

![image](https://user-images.githubusercontent.com/13453401/138581502-b496fe4e-5a49-4017-bac9-d8173469e0e8.png)

Caveats
-------
As this is a proof of concept, there are some caveats:
* This dark mode implementation is only available in Windows 10
  version 20H1 (2004) or higher. I'm not sure what will happen if you
  try to run it on other versions of Windows. Please experiment!
* The Win32 API calls are technically comptatible with Windows Vista
  and higher, not sure of behavior on those systems though.
* Does not follow system light/dark mode, it is just hard-coded to
  dark mode for now.
* This is using an internal (undocumented) Windows API. Therefore it
  could technically change at any time. Microsoft has notoriously not
  published an API to enable dark mode on Win32 apps. However many
  apps have "figured it out" and started using it out of desperation
  (see below).

Download
--------
Download `emacs-darkmode.zip` from the releases section, extract to
your machine, and launch `bin/runemacs.exe`. Since I use this as my
daily driver I have intentionally compiled the build with no
debugging, high optimization, and only for Intel Skylake (6th-ish gen)
processors and higher.

Inspiration
-----------
* [WinSCP (bug + commits)](https://winscp.net/tracker/1920)
* [Windows Terminal](https://github.com/microsoft/terminal/commit/bc7eb9611030aed3204aff4e662c318cbf9143a6#diff-e26a93b2aa9fea92ebf24336c4fe6412L19-L22)
  (they initially published commits using the internal API on GitHub,
  then removed it).
