#!/bin/sh

# Basic build function
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

# Cleanup
rm -rf out/outputs
mkdir -p out/outputs

# Hanya jalankan satu script build: compile-beryllium.sh
device_script="./compile-beryllium.sh"

if [ ! -f "${device_script}" ]; then
    echo -e "${red}Script tidak ditemukan: ${device_script}${nocol}"
    exit 1
fi

echo -e "${cyan}Running ${device_script}...${nocol}"
chmod +x "${device_script}"
"${device_script}"

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Full build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
