@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="rom\bnw2.1.sfc"
set VANILLA_ROM="rom\Final Fantasy III (USA) (Rev 1).sfc"
set EDITED_ROM="bnw.sfc"
set PATCHES="asm"
set SCRIPTS="scripts"

rem ----------------------------------------------------------------------------
set ASAR="tools\asar.exe"
set FFVIDECOMP="tools\ffvi.exe"
set GFX="gfx"
set FLIPS="tools\flips"
set ATLAS="tools\Atlas.exe"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
rem ----------------------------------------------------------------------------

echo.
echo Inserting strings...
%ATLAS% %EDITED_ROM% battle_strings_english.txt

echo Applying ips...
%FLIPS% --apply "C2686C_Cinematic_Program.ips" %EDITED_ROM%
%FLIPS% --apply "D8F000_Cinematic_Title_Isle_GFX.ips" %EDITED_ROM%
%FLIPS% --apply "misc.ips" %EDITED_ROM%
%FLIPS% --apply "minimap.ips" %EDITED_ROM%
%FLIPS% --apply "docileNPCs.ips" %EDITED_ROM%
%FLIPS% --apply "newnarshe.ips" %EDITED_ROM%
%FLIPS% --apply "improved_portraits.ips" %EDITED_ROM%

echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%

echo Creating patch...
%FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 B21.ips"
