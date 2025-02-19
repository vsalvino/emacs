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
unx_insroot="${unx_srcdir}/_install/${gitHash}"
unx_insdir="${unx_insroot}/Emacs"
unx_depdir="${unx_srcdir}/_deps"
rm -rf "${unx_insdir}";
mkdir -p "${unx_insdir}"
rm -rf "${unx_depdir}"
mkdir -p "${unx_depdir}"

# Refresh mingw packages.
pacman -Syuu --noconfirm

# Install mingw dependencies.
pacman -S --noconfirm --needed --overwrite '*' \
       autoconf \
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
       mingw-w64-x86_64-libtre \
       mingw-w64-x86_64-libtree-sitter \
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

echo ""
echo "Output is in ${unx_insdir}."
