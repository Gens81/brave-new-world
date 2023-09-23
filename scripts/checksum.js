"use strict";

const fs = require('fs');
const path = process.argv[2];
const buffer = fs.readFileSync(path);
checksum();
fs.writeFileSync(path, buffer);

/* Helpers */
function write_word_at (offset, value) {
  buffer[offset] = value & 0xFF;
  buffer[offset+1] = value >> 8;
}

function checksum () {
  var sum = 0;
  var i;

  for (i = 0; i < 0x200000; i++) {
    sum += buffer[i];
  }
  for (i = 0x200000; i < 0x300000; i++) {
    sum += buffer[i] + buffer[i];
  }

  const checksum = sum & 0xFFFF;
  const inverted = checksum ^ 0xFFFF;

  // Temporary check against "final" version of 2.1
  // if (checksum !== 0xD750) {
  //   console.warn(`\n\nWARNING: Checksum does not match v2.1\n\n`);
  // }

  write_word_at(0x00FFDE, checksum);
  write_word_at(0x00FFDC, inverted);
}
