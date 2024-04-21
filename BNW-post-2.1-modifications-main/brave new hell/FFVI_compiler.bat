@echo off
rem ----------------------------------------------------------------------------
set ORIGINAL_ROM="bnw.sfc"
set EDITED_ROM="bnh.sfc"
set PATCHES="asm"

rem ----------------------------------------------------------------------------
set ASAR="tools\asar.exe"
set FLIPS="tools\flips"

rem ----------------------------------------------------------------------------
copy %ORIGINAL_ROM% %EDITED_ROM% /y
rem ----------------------------------------------------------------------------

echo.
echo Applying hacks...
%ASAR% --pause-mode=on-error %PATCHES%\main.asm %EDITED_ROM%

echo Creating patch...
%FLIPS% --create --ips %ORIGINAL_ROM% %EDITED_ROM% "[n]brave_new_hell.ips"
