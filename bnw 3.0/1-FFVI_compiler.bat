@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="rom\bnw_2.1.sfc"
set VANILLA_ROM="rom\Final Fantasy III (USA) (Rev 1).sfc"
set EDITED_ROM="bnw.sfc"
set PATCHES="asm"
set SCRIPTS="scripts"
set ORIGINAL_BIN="gfx\modified\02686C_Title_Program_orig.bin"
set EDITED_BIN="gfx\modified\02686C_Title_Program.bin"

rem ----------------------------------------------------------------------------
set ASAR="tools\asar.exe"
set FFVIDECOMP="tools\ffvi.exe"
set GFX="gfx"
set FLIPS="tools\flips.exe"
set ATLAS="tools\Atlas.exe"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
copy %ORIGINAL_BIN% %EDITED_BIN% /y
rem ----------------------------------------------------------------------------

echo.
echo Inserting strings...
%ATLAS% %EDITED_ROM% battle_strings_english.txt

rem echo Applying ips...
rem %FLIPS% --apply "C2686C_Cinematic_Program.ips" %EDITED_ROM%
rem %FLIPS% --apply "D8F000_Cinematic_Title_Isle_GFX.ips" %EDITED_ROM%
rem %FLIPS% --apply "misc.ips" %EDITED_ROM%
rem %FLIPS% --apply "minimap.ips" %EDITED_ROM%
rem %FLIPS% --apply "docileNPCs.ips" %EDITED_ROM%
rem %FLIPS% --apply "newnarshe.ips" %EDITED_ROM%
rem %FLIPS% --apply "improved_portraits.ips" %EDITED_ROM%
rem %FLIPS% --apply "kaiser.ips" %EDITED_ROM%
rem %FLIPS% --apply "visible_magitek_doors.ips" %EDITED_ROM%
rem %FLIPS% --apply "sprites_and_tilemap_changes_v.1.0.ips" %EDITED_ROM%

echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%
%ASAR% --pause-mode=on-error %PATCHES%\main_slot.asm %EDITED_ROM%

rem echo Inserting Compressed Graphics...
rem %FFVIDECOMP% -m c -s 0x02686C %EDITED_ROM% < %EDITED_BIN%

rem echo Creating patch...
rem %FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 RC8.2.ips"