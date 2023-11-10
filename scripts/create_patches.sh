#!/bin/bash

bnw_path="$1"
version="$2"

tmp_dir="../tmp"
bnw_h_path="$tmp_dir/bnw-h.sfc"
ff6_h_path="$tmp_dir/ff6-h.sfc"
header_path="$tmp_dir/header"
n_ips_path="$tmp_dir/[n]BNW-$version.ips"
h_ips_path="$tmp_dir/[h]BNW-$version.ips"
zip_path="../releases/BNW-$version.zip"

# Load in environment variables
source "./settings.sh"

# Helpers
create_patch () {
  "$IPS_PATH" --create --ips "$1" "$2" "$3" > /dev/null
}

# Main
rm -r "$tmp_dir"
mkdir "$tmp_dir"

# Construct headered ROMs
dd if=/dev/zero bs=512 count=1 status=none > "$header_path"
cat "$header_path" "$bnw_path" > "$bnw_h_path"
cat "$header_path" "$FF6_PATH" > "$ff6_h_path"

echo -n "Creating IPS patches..."
create_patch "$FF6_PATH" "$bnw_path" "$n_ips_path"
create_patch "$ff6_h_path" "$bnw_h_path" "$h_ips_path"
echo "done"

echo -n "Zipping patches for release..."
zip -j "$zip_path" "$n_ips_path" "$h_ips_path" > /dev/null
rm "$bnw_h_path" "$ff6_h_path" "$header_path" "$n_ips_path" "$h_ips_path"
echo "done"
