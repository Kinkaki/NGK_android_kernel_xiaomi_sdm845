#!/bin/sh

# Basic build function
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

curl -LSs "https://raw.githubusercontent.com/KOWX712/KernelSU/master/kernel/setup.sh" | bash

# Grab AnyKernel3 if it isn't already here (GitHub Actions clones it in a
# separate step; this is just a fallback for local builds)
ANYKERNEL_DIR="${ANYKERNEL_DIR:-$(pwd)/AnyKernel3}"
if [ ! -d "${ANYKERNEL_DIR}" ]; then
    git clone --depth=1 https://github.com/Shiki-ghub/AnyKernel3 "${ANYKERNEL_DIR}"
fi
export ANYKERNEL_DIR

# Cleanup
rm -rf out/outputs/*

./compile-beryllium.sh
# NOTE: compile-dipper.sh needs the same two fixes applied to
# compile-beryllium.sh (COMPILERDIR fallback + mkdir -p), since it wasn't
# part of what you sent me to sync.

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Full build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
