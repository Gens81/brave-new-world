@echo off
rem ----------------------------------------------------------------------------
set ROM="scripts\bnw_2.2.smc"
rem ----------------------------------------------------------------------------
set SCRIPTS="scripts"
set GFX="gfx"
rem ----------------------------------------------------------------------------
set DD="tools\dd.exe"

rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
if not exist "%SCRIPTS%" mkdir %SCRIPTS%
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
echo Extracting Scripts...
%DD% skip=845824 count=133887 if=%ROM% of=%SCRIPTS%\town_dialog.bin bs=1 2>NUL
%DD% skip=1040864 count=5232 if=%ROM% of=%SCRIPTS%\short_battle_dialog.bin bs=1 2>NUL
%DD% skip=1102336 count=11519 if=%ROM% of=%SCRIPTS%\long_battle_dialog.bin bs=1 2>NUL
