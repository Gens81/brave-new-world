#!/bin/bash

rom_path="$1"

# Load in environment variables
source "./settings.sh"

# Helpers
assemble () {
  "$ASAR_PATH" $1 ../$rom_path
}
assemble_batch () {
  cd ../asm/$1
  for file in *.asm
  do
    assemble $file
  done
  cd ../../scripts
}

# Assemble asm by bank
# Instead of using a master asm with incsrc, we concatenate all banks
# together to ensure cross-bank labels are functional
allbanks="all.asm"
cd ../asm/banks
cat *.asm > "$allbanks"
assemble "$allbanks"
rm "$allbanks"
cd ../../scripts

# Assemble private (hidden) assembly
assemble_batch private
