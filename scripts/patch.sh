#!/bin/bash

rom_path="$1"
out_path="$rom_path"

# Load in environment variables
source "./settings.sh"

# Helpers
patch () {
  "$IPS_PATH" --apply "$1" "$rom_path" "$out_path"
}

# Patch all ips patches one at a time
echo -n "Applying IPS patches..."
cd ../ips
for file in *.ips
do
  patch $file > /dev/null
done
echo "done"
cd ../scripts
