@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="rom\bnw2.1.sfc"
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
set FLIPS="tools\flips"
set ATLAS="tools\Atlas.exe"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
copy %ORIGINAL_BIN% %EDITED_BIN% /y
rem ----------------------------------------------------------------------------

echo.
echo Inserting strings...
%ATLAS% %EDITED_ROM% battle_strings_english.txt

echo Applying ips...
%FLIPS% --apply "C2686C_Cinematic_Program.ips" %EDITED_ROM%
%FLIPS% --apply "D8F000_Cinematic_Title_Isle_GFX.ips" %EDITED_ROM%
%FLIPS% --apply "misc.ips" %EDITED_ROM%
%FLIPS% --apply "fast_anim_v4_n.ips" %EDITED_ROM%
%FLIPS% --apply "minimap.ips" %EDITED_ROM%
%FLIPS% --apply "docileNPCs.ips" %EDITED_ROM%
%FLIPS% --apply "newnarshe.ips" %EDITED_ROM%
%FLIPS% --apply "improved_portraits.ips" %EDITED_ROM%

echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\new_opening.asm %EDITED_BIN%
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%

echo Inserting Compressed Graphics...
%FFVIDECOMP% -m c -s 0x02686C %EDITED_ROM% < %EDITED_BIN%

echo Creating patch...
%FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 b26.ips"
