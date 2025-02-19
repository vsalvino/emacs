<#
.SYNOPSIS
All-in-one script to build Emacs for Windows using MSYS2.
#>

# Enter mingw64
$env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
$env:MSYSTEM = 'MINGW64'  # Start a 64 bit Mingw environment

# File paths, swapped to unix format.
$win_srcdir = $($PSScriptRoot)
$unx_srcdir = $win_srcdir -replace "\\","/" -replace "C\:","/c"

# Run the real build script.
& "C:\msys64\usr\bin\bash" -lc "set -ex; \
  cd ${unx_srcdir};
  chmod +x ./vince-build.sh;
  ./vince-build.sh;
"

# Run the packager script.
& "C:\msys64\usr\bin\bash" -lc "set -ex; \
  cd ${unx_srcdir};
  chmod +x ./vince-package.sh;
  ./vince-package.sh;
"
