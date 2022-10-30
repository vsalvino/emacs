#!/bin/sh
#
# SYNOPSIS
#   All-in-one script to build Emacs for Windows using MSYS2.
#
# INSTRUCTIONS:
#   `cd` to the emacs source directory, then run this script.
#

set -eux;

if [ $MSYSTEM != 'MINGW64' ]
then
    echo "Run this script from MINGW64!"
    exit 1
fi

# Set desired gcc flags.
CFLAGS='-O3 -g0 -march=alderlake'

# Get current git hash ID.
gitHash=$(git rev-parse --short HEAD)

# File paths.
unx_srcdir=$(pwd)
unx_insroot="${unx_srcdir}/_install"
unx_insdir="${unx_insroot}/${gitHash}"
unx_depdir="${unx_srcdir}/_deps"
rm -rf "${unx_insdir}";
mkdir -p "${unx_insdir}"
rm -rf "${unx_depdir}"
mkdir -p "${unx_depdir}"

# Refresh mingw packages.
pacman -Syuu --noconfirm

# Install mingw dependencies.
pacman -S --noconfirm --needed --overwrite '*' \
       base-devel \
       binutils \
       git \
       mingw-w64-x86_64-giflib \
       mingw-w64-x86_64-gnutls \
       mingw-w64-x86_64-harfbuzz \
       mingw-w64-x86_64-jansson \
       mingw-w64-x86_64-lcms2 \
       mingw-w64-x86_64-libgccjit \
       mingw-w64-x86_64-libjpeg-turbo \
       mingw-w64-x86_64-libpng \
       mingw-w64-x86_64-librsvg \
       mingw-w64-x86_64-libtiff \
       mingw-w64-x86_64-libxml2 \
       mingw-w64-x86_64-nsis \
       mingw-w64-x86_64-ntldd-git \
       mingw-w64-x86_64-toolchain \
       mingw-w64-x86_64-xpm-nox \
       mingw-w64-x86_64-zlib \
       python3 \
       zip

# Setup.
./autogen.sh
./configure \
    --prefix="${unx_srcdir}" \
    --with-file-notification=w32 \
    --with-json \
    --with-native-compilation \
    --with-w32 \
    --without-compress-install \
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
    CFLAGS="${CFLAGS}";

# Compile.
make NATIVE_FULL_AOT=1 -j$(nproc)

# Install.
make install prefix="${unx_insdir}"

# Bundle mingw dependency DLLs with the executable.
cd "${unx_depdir}";
"${unx_srcdir}/admin/nt/dist-build/build-dep-zips.py";
cp -f ${unx_depdir}/x86_64/* "${unx_insdir}/bin/";
cd "${unx_srcdir}";

# Make installer.
emacsVersion=$(ls "${unx_insdir}/share/emacs/" | head -n1)
cp vince.nsi "${unx_insroot}"
cd "${unx_insroot}";
makensis -v4 \
         -DEMACS_VERSION="${emacsVersion}" \
         -DOUT_VERSION="${gitHash}" \
         vince.nsi;
rm "${unx_insroot}/vince.nsi"

# Make zip.
cd "${unx_insroot}"
zip -r "emacs-darkmode-${gitHash}.zip" "${gitHash}"

echo ""
echo "Output is in ${unx_insdir}."
