@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="bnw.sfc"
set VANILLA_ROM="rom\Final Fantasy III (USA) (Rev 1).sfc"
set EDITED_ROM="bnw_2.2.sfc"
set PATCHES="asm"
set SCRIPTS="scripts"
set ORIGINAL_BIN="gfx\modified\02686C_Title_Program_orig.bin"
set EDITED_BIN="gfx\modified\02686C_Title_Program.bin"

rem ----------------------------------------------------------------------------
set ASAR="tools\asar.exe"
set FFVIDECOMP="tools\ffvi.exe"
set GFX="gfx"
set FLIPS="tools\flips"
set ATLAS="tools\Atlas.exe"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
copy %ORIGINAL_BIN% %EDITED_BIN% /y
rem ----------------------------------------------------------------------------

echo.

echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\new_opening.asm %EDITED_BIN%
%ASAR% --pause-mode=on-error %PATCHES%\maintro.asm %EDITED_ROM%

echo Inserting Compressed Graphics...
%FFVIDECOMP% -m c -s 0x02686C %EDITED_ROM% < %EDITED_BIN%

rem echo Applying ips...
rem %FLIPS% --apply "charm_eulogy.ips" %EDITED_ROM%

rem echo Creating patch...
rem %FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 RC8.ips"
