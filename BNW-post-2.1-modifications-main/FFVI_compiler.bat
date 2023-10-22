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
rem %FLIPS% --apply "msu-1.ips" %EDITED_ROM%

echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%

echo Creating patch...
%FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 B21.ips"
rem %FLIPS% --create --ips %VANILLA_ROM% %EDITED_ROM% "[n]BNW 2.2 B21 (for real hardware).ips"

echo Compressing GFX
rem %FFVIDECOMP% -m c -s 0x02686C %EDITED_ROM% < %GFX%\modified\02686C_Title_Program.bin
rem %FFVIDECOMP% -m c -s 0x18F000 %EDITED_ROM% < %GFX%\modified\18F000_Title_GFX.bin
rem %FFVIDECOMP% -m c -s 0x19568f %EDITED_ROM% < %GFX%\modified\19568f_Ending_Cinematic_GFX_1.bin
rem %FFVIDECOMP% -m c -s 0x199d4b %EDITED_ROM% < %GFX%\modified\199d4b_Ending_Cinematic_GFX_2.bin
rem %FFVIDECOMP% -m c -s 0x19a4e5 %EDITED_ROM% < %GFX%\modified\19a4e5_Ending_Cinematic_GFX_3.bin
rem %FFVIDECOMP% -m c -s 0x19a800 %EDITED_ROM% < %GFX%\modified\19a800_Map_Tile_Properties.bin
rem %FFVIDECOMP% -m c -s 0x19cd10 %EDITED_ROM% < %GFX%\modified\19cd10_Map_Tile_Properties_Pointers.bin
