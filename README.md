Vince's Emacs for Windows
=========================

This is a build of Emacs optimized for Windows 10 (1809) and higher. My build is tuned to look better and run faster on Windows for those of us (probably single-digits) who use Emacs on Windows as our daily driver. Changes include:

* Dark mode support (which got merged into Emacs 29!)
* Toggles between light/dark mode automatically when changing Windows settings.
* Consolas 12pt is the default font.
* Includes pre-compiled native lisp files.
* Compiled for Intel Alder Lake (12th gen) CPU and higher.

Example with Windows Dark mode and Light mode:

![image](https://user-images.githubusercontent.com/13453401/138809142-0f4d10a4-a6f6-45ef-b068-041c12ba8b63.png)

![image](https://user-images.githubusercontent.com/13453401/138809293-824ed605-aee5-4041-b446-9fb2e8bf2ab2.png)

Download
--------
Download `emacs-vince.zip` from the latest [release](https://github.com/vsalvino/emacs/releases), extract to your
machine, and launch `bin/runemacs.exe`.

To install, I recommend copying the extracted files to `C:\Program Files` then updating your `PATH` to include `C:\Program Files\Emacs\bin\`.

Releases are 64-bit, built for Intel Alder Lake (12th gen) CPUs and newer. If you have an older CPU, let me know and I can produce a build.

TODO
----
* ~~Dark titlebars~~
* ~~Dark scrollbars~~
* Dark menu bar and/or menu items
* ~~Dark tool bar~~ (tool bar colors can be customized via faces)
* ~~Dark tab bar mode~~ (tab bar colors can be customized via faces)
* ~~Follow system light/dark mode.~~ This is loaded from the Windows
  Registry when Emacs is launched.
* Include default dark/light editor themes, and dynamically toggle between them when light/dark mode is changed.

Inspiration for implementing dark mode support
----------------------------------------------
* [WindowsAppSDK](https://github.com/microsoft/WindowsAppSDK/issues/41)
* [WinSCP](https://winscp.net/tracker/1920) (see discussion and
  commits on their bug tracker).
* [Windows Terminal](https://github.com/microsoft/terminal/commit/bc7eb9611030aed3204aff4e662c318cbf9143a6#diff-e26a93b2aa9fea92ebf24336c4fe6412L19-L22)
  (they initially published commits using the internal API on GitHub,
  then removed it).
* [win32-darkmode](https://github.com/ysc3839/win32-darkmode) (this
  code is quite grizzly but insightful)
