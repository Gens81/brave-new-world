♦@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="bnw_2.2.sfc"
set EDITED_ROM="bnw_3.0.sfc"
set PATCHES="asm"
set EDITED_BIN="gfx\18F000_Title_GFX_updated.bin"
set EDITED_BIN2="gfx\02686C_Title_Program_updated.bin"

rem ----------------------------------------------------------------------------
set ASAR="asar.exe"
set FFVIDECOMP="ffvi.exe"
set GFX="gfx"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
rem ----------------------------------------------------------------------------

echo.
echo Applying hacks...

%ASAR% --pause-mode=on-error %PATCHES%\new_opening_after_khaos.asm %EDITED_BIN2%
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%

echo Inserting Compressed Graphics...
%FFVIDECOMP% -m c -s 0x18F000 %EDITED_ROM% < %EDITED_BIN% 
%FFVIDECOMP% -m c -s 0X02686C %EDITED_ROM% < %EDITED_BIN2%
