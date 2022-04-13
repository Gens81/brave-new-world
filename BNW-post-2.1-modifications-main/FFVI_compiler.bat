@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="rom\bnw.sfc"
set EDITED_ROM="bnw.sfc"
set PATCHES="asm"

rem ----------------------------------------------------------------------------
set ASAR="tools\asar.exe"
set FFVIDECOMP="tools\ffvi.exe"
set GFX="gfx"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
rem ----------------------------------------------------------------------------

echo.
echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\new_intro.asm %EDITED_ROM%
%ASAR% --pause-mode=on-error %PATCHES%\misc.asm %EDITED_ROM%
%ASAR% --pausa-mode=on-error %PATCHES%\veldt-freebies.asm %EDITED_ROM%

echo Compressing GFX
%FFVIDECOMP% -m c -s 0x02686C %EDITED_ROM% < %GFX%\modified\02686C_Title_Program.bin
%FFVIDECOMP% -m c -s 0x18F000 %EDITED_ROM% < %GFX%\modified\18F000_Title_GFX.bin
%FFVIDECOMP% -m c -s 0x19568f %EDITED_ROM% < %GFX%\modified\19568f_Ending_Cinematic_GFX_1.bin
%FFVIDECOMP% -m c -s 0x199d4b %EDITED_ROM% < %GFX%\modified\199d4b_Ending_Cinematic_GFX_2.bin
%FFVIDECOMP% -m c -s 0x19a4e5 %EDITED_ROM% < %GFX%\modified\19a4e5_Ending_Cinematic_GFX_3.bin
%FFVIDECOMP% -m c -s 0x19a800 %EDITED_ROM% < %GFX%\modified\19a800_Map_Tile_Properties.bin
%FFVIDECOMP% -m c -s 0x19cd10 %EDITED_ROM% < %GFX%\modified\19cd10_Map_Tile_Properties_Pointers.bin