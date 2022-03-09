#!/bin/bash

rom_path="$1"

# Load in environment variables
source "./settings.sh"

# Helpers
assemble () {
  "${XKAS_PATH[@]}" $1 ../$rom_path
}
assemble_master () {
  cd ../asm/$1
  assemble $2
  cd ../../scripts
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

# Assemble asm files in synchysi directory one at a time
assemble_batch synchysi

# Assemble bropedio asm using master files
assemble_master bropedio-2.0 RC33.asm
assemble_master bropedio-2.1 RC-18.asm

# Assemble private (hidden) assembly
assemble_batch private
