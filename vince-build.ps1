<#
.SYNOPSIS
All-in-one script to build Emacs for Windows using MSYS2.
#>

# Enter mingw64
$env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
$env:MSYSTEM = 'MINGW64'  # Start a 64 bit Mingw environment

# Set desired gcc flags.
$env:CFLAGS = $CFLAGS = '-O3 -g0 -march=skylake'

# Get current git hash ID.
$gitHash = (& git rev-parse --short HEAD).Trim()

# File paths, swapped to unix format.
$win_srcdir = $($PSScriptRoot)
$win_blddir = $(Join-Path $win_srcdir "_build")
$win_insdir = $(Join-Path $win_srcdir "_install" $gitHash)
New-Item -Type Directory -ErrorAction Ignore -Path "$win_blddir"
New-Item -Type Directory -ErrorAction Ignore -Path "$win_insdir"
$unx_srcdir = $win_srcdir -replace "\\","/" -replace "C\:","/c"
$unx_blddir = $win_blddir -replace "\\","/" -replace "C\:","/c"
$unx_insdir = $win_insdir -replace "\\","/" -replace "C\:","/c"

# Clean build dir
#Remove-Item -Recurse -Force -ErrorAction Ignore -Path $win_blddir
#New-Item -Type Directory -Path $win_blddir
#& "C:\msys64\usr\bin\bash" -lc "make maintainer-clean";

# Refresh code
#git fetch upstream
#git rebase upstream/master

# Refresh mingw packages.
#& "C:\msys64\usr\bin\bash" -lc "set -ex; \
#  pacman -Syuu --noconfirm
#"

# Install mingw dependencies.
#& "C:\msys64\usr\bin\bash" -lc "set -ex; \
#  pacman -S --noconfirm --needed --overwrite '*' \
#  base-devel \
#  binutils \
#  git \
#  mingw-w64-x86_64-giflib \
#  mingw-w64-x86_64-gnutls \
#  mingw-w64-x86_64-harfbuzz \
#  mingw-w64-x86_64-jansson \
#  mingw-w64-x86_64-lcms2 \
#  mingw-w64-x86_64-libjpeg-turbo \
#  mingw-w64-x86_64-libpng \
#  mingw-w64-x86_64-librsvg \
#  mingw-w64-x86_64-libtiff \
#  mingw-w64-x86_64-libxml2 \
#  mingw-w64-x86_64-toolchain \
#  mingw-w64-x86_64-xpm-nox \
#  mingw-w64-x86_64-zlib \
#  zip
#"

# Setup
Write-Host -ForegroundColor Cyan "Running autogen.sh..."
& "C:\msys64\usr\bin\bash" -lc "set -ex; \
  ./autogen.sh
"

Write-Host -ForegroundColor Cyan "Running configure..."
& "C:\msys64\usr\bin\bash" -lc "set -ex;
  cd ${unx_blddir};
  ${unx_srcdir}/configure \
    --prefix=${unx_blddir} \
    --with-file-notification=w32 \
    --with-json \
    --with-w32 \
    --without-dbus \
    --without-gconf \
    --without-gpm \
    --without-libgmp \
    --without-libsystemd \
    --without-m17n-flt \
    --without-pop \
    --without-selinux \
    --without-xdbe \
    --without-xft \
    CFLAGS='${CFLAGS}';
"

# Compile
Write-Host -ForegroundColor Cyan "Make..."
& "C:\msys64\usr\bin\bash" -lc "make -j4"

# Install
Write-Host -ForegroundColor Cyan "Installing..."
& "C:\msys64\usr\bin\bash" -lc "make install prefix='${unx_insdir}'"

# Bundle mingw dependency DLLs with the executable.
Write-Host -ForegroundColor Cyan "Copying DLLs..."
& "C:\msys64\usr\bin\bash" -lc "set -ex;
  cp /mingw64/bin/libXpm-noX*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libbz2-*.dll        ${unx_insdir}/bin;
  cp /mingw64/bin/libcairo-*.dll      ${unx_insdir}/bin;
  cp /mingw64/bin/libexpat-*.dll      ${unx_insdir}/bin;
  cp /mingw64/bin/libffi-*.dll        ${unx_insdir}/bin;
  cp /mingw64/bin/libfontconfig-*.dll ${unx_insdir}/bin;
  cp /mingw64/bin/libfreetype-*.dll   ${unx_insdir}/bin;
  cp /mingw64/bin/libgcc_s_seh-*.dll  ${unx_insdir}/bin;
  cp /mingw64/bin/libgdk_pixbuf-*.dll ${unx_insdir}/bin;
  cp /mingw64/bin/libgif-*.dll        ${unx_insdir}/bin;
  cp /mingw64/bin/libgio-*.dll        ${unx_insdir}/bin;
  cp /mingw64/bin/libglib-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libgmodule-*.dll    ${unx_insdir}/bin;
  cp /mingw64/bin/libgmp-*.dll        ${unx_insdir}/bin;
  cp /mingw64/bin/libgnutls-*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libgnutlsxx-*.dll   ${unx_insdir}/bin;
  cp /mingw64/bin/libgobject-*.dll    ${unx_insdir}/bin;
  cp /mingw64/bin/libgomp-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libharfbuzz-*.dll   ${unx_insdir}/bin;
  cp /mingw64/bin/libhogweed-*.dll    ${unx_insdir}/bin;
  cp /mingw64/bin/libiconv-*.dll      ${unx_insdir}/bin;
  cp /mingw64/bin/libintl-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libjbig-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libjpeg-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/liblzma-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libnettle-*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libp11-kit-*.dll    ${unx_insdir}/bin;
  cp /mingw64/bin/libpango-*.dll      ${unx_insdir}/bin;
  cp /mingw64/bin/libpangocairo-*.dll ${unx_insdir}/bin;
  cp /mingw64/bin/libpangoft*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libpangowin32-*.dll ${unx_insdir}/bin;
  cp /mingw64/bin/libpixman-*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libpng*.dll         ${unx_insdir}/bin;
  cp /mingw64/bin/librsvg-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libtasn1-*.dll      ${unx_insdir}/bin;
  cp /mingw64/bin/libtiff-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/libtiffxx-*.dll     ${unx_insdir}/bin;
  cp /mingw64/bin/libwinpthread-*.dll ${unx_insdir}/bin;
  cp /mingw64/bin/libxml2-*.dll       ${unx_insdir}/bin;
  cp /mingw64/bin/zlib*.dll           ${unx_insdir}/bin;
"

Write-Host -ForegroundColor Cyan "Done. Output is in '_install' folder."
