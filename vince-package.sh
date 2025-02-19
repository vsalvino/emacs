#!/bin/sh
#
# SYNOPSIS
#   All-in-one script to package an Emacs build for distribution using MSYS2.
#   Run this after vince-build.sh.
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

# Get current git hash ID.
gitHash=$(git rev-parse --short HEAD)

# File paths.
unx_srcdir=$(pwd)
unx_insroot="${unx_srcdir}/_install/${gitHash}"
unx_insdir="${unx_insroot}/Emacs"
unx_depdir="${unx_srcdir}/_deps"
rm -rf "${unx_depdir}"
mkdir -p "${unx_depdir}"

# Make zip.
cd "${unx_insroot}"
#zip -r "emacs-vince.zip" "Emacs"

# Bundle mingw dependency DLLs with the executable.
cd "${unx_depdir}";
"${unx_srcdir}/admin/nt/dist-build/build-dep-zips.py";
cp -f ${unx_depdir}/x86_64/* "${unx_insdir}/bin/";
cd "${unx_srcdir}";

echo ""
echo "Output is in ${unx_insdir}."
