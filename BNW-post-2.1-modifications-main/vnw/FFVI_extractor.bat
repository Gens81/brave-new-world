echo Extracting Scripts...
dd skip=845824 count=133887 if=vnw.smc of=town_dialog.bin bs=1 2>NUL
dd skip=1040864 count=5231 if=vnw.smc of=short_battle_dialog.bin bs=1 2>NUL
dd skip=1102336 count=11519 if=vnw.smc of=long_battle_dialog.bin bs=1 2>NUL
